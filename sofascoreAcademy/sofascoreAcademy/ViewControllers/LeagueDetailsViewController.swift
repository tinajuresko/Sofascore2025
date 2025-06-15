//
//  LeagueDetailsViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 31.05.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit
import Combine

class LeagueDetailsViewController: BaseTabViewController, UIScrollViewDelegate, LoadableView {
    private let league: League
    private let tournamentMatchesViewModel: TournamentMatchesViewModel
    private let tournamentStandingsViewModel: TournamentStandingsViewModel

    private let matchesView = TournamentMatchesView()
    private let standingsView = TournamentStandingsView()
    
    private var cancellables = Set<AnyCancellable>()

    private var currentTab: TabType = .matches

    init(league: League) {
        self.league = league
        self.tournamentMatchesViewModel = TournamentMatchesViewModel(leagueId: league.id)
        self.tournamentStandingsViewModel = TournamentStandingsViewModel(leagueId: league.id)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var hasLaidOutSubviewsOnce = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasLaidOutSubviewsOnce {
            hasLaidOutSubviewsOnce = true
            if let scrollView = (currentContentView as? TournamentMatchesView)?.scrollView {
                scrollViewDidScroll(scrollView)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderView()
        setupTabs()
        setupNavigationBar()

        navigationView.configureTitle(league.name)
        
        observeTournamentMatchesViewModel()
        observeTournamentStandingsViewModel()

        matchesView.externalScrollDelegate = self
        standingsView.externalScrollDelegate = self
        standingsView.delegate = self

        loadCurrentTabData()
    }

    // MARK: - Tabs

    override func setupTabs() {
        customTabsView.configure(firstTab: .matches, secondTab: .standings)
        customTabsView.onTabSelected = { [weak self] tab in
            self?.handleTabChange(to: tab)
        }
        handleTabChange(to: .matches)
    }

    override func handleTabChange(to tab: TabType) {
        currentContentView?.removeFromSuperview()
        errorLabel.isHidden = true
        currentTab = tab
        
        switch tab {
        case .matches:
            displayContentView(matchesView)
            updateUIForMatches()
            if tournamentMatchesViewModel.state.isIdleOrError {
                tournamentMatchesViewModel.loadTournamentMatches()
            }
        case .standings:
            displayContentView(standingsView)
            updateUIForStandings()
            if tournamentStandingsViewModel.state.isIdleOrError {
                tournamentStandingsViewModel.loadTournamentStandings()
            }
        default:
            break
        }
    }

    private func updateUIForMatches() {
        let state = tournamentMatchesViewModel.state
        handleMatchesState(state)
    }

    private func updateUIForStandings() {
        let state = tournamentStandingsViewModel.state
        handleStandingsState(state)
    }
    
    private func loadCurrentTabData() {
        switch currentTab {
        case .matches:
            tournamentMatchesViewModel.loadTournamentMatches()
        case .standings:
            tournamentStandingsViewModel.loadTournamentStandings()
        default:
            break
        }
    }
    
    // MARK: - Header

    func setupHeaderView() {
        customHeaderView.configure(
            name: league.name,
            countryName: league.country?.name ?? "",
            imageUrl: league.logoUrl
        )
    }

    // MARK: - ViewModel Observation

    private func observeTournamentMatchesViewModel() {
        tournamentMatchesViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                if self.currentTab == .matches {
                    self.handleMatchesState(state)
                }
            }
            .store(in: &cancellables)
    }

    private func observeTournamentStandingsViewModel() {
        tournamentStandingsViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                if self.currentTab == .standings {
                    self.handleStandingsState(state)
                }
            }
            .store(in: &cancellables)
    }

    private func handleMatchesState(_ state: State<[Event]>) {
        handleState(state,
            onLoading: { showLoadingState() },
            onLoaded: { _ in
                matchesView.configure(with: tournamentMatchesViewModel)
                showLoadedState()
            },
            onError: {
                showErrorState(message: "No data available.")
            },
            onIdle: {
                self.hideError()
            }
        )
    }

    private func handleStandingsState(_ state: State<[Standings]>) {
        handleState(state,
            onLoading: { showLoadingState() },
            onLoaded: { standings in
                standingsView.configure(standings: standings, sport: SportSelectionManager.shared.selectedSport)
                showLoadedState()
            },
            onError: {
                showErrorState(message: "No data available.")
            },
            onIdle: {
                self.hideError()
            }
        )
    }
}

// MARK: - TournamentStandingsViewDelegate

extension LeagueDetailsViewController: TournamentStandingsViewDelegate {
    func didTapTeamLabel(teamId: Int?) {
        guard let id = teamId else { return }
        let teamViewModel = TeamViewModel(teamId: id)
        let teamVC = TeamViewController(teamViewModel: teamViewModel)
        navigationController?.pushViewController(teamVC, animated: true)
    }
}
