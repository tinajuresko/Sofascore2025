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

class LeagueDetailsViewController: UIViewController, BaseViewProtocol, LoadableView, ScrollAnimatableViewController, UIScrollViewDelegate {
    private let league: League
    private let tournamentMatchesViewModel: TournamentMatchesViewModel
    private let tournamentStandingsViewModel: TournamentStandingsViewModel
    
    private var topBackgroundView: TopBackgroundView!
    private let contentView = UIView()
    private var currentContentView: UIView?
    var customTabsView = CustomTabsView()
    var navigationView = CustomNavigationView()
    var customHeaderView = CustomHeaderView()
    
    var customHeaderHeightConstraint: Constraint!
    var customTabsTopConstraint: Constraint!
    var customTabsAltTopConstraint: Constraint!
    
    private var cancellables = Set<AnyCancellable>()
    private var hasLaidOutSubviewsOnce = false
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let errorLabel = UILabel()

    init(league: League) {
        self.league = league
        self.tournamentMatchesViewModel = TournamentMatchesViewModel(leagueId: league.id)
        self.tournamentStandingsViewModel = TournamentStandingsViewModel(leagueId: league.id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
        setupNavigationBar()
        setupHeader()
        setupTabs()
        
        observeTournamentMatchesViewModel()
        tournamentMatchesViewModel.loadTournamentMatches()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasLaidOutSubviewsOnce {
            hasLaidOutSubviewsOnce = true
            if let scrollView = (currentContentView as? TournamentMatchesView)?.scrollView {
                scrollViewDidScroll(scrollView)
            }
        }
    }
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ScrollBehaviorHelper.handleScroll(
            scrollView: scrollView,
            maxHeaderOffset: 72,
            delegate: self
        )
    }
    
    // MARK: State handling
    private func observeTournamentMatchesViewModel() {
        tournamentMatchesViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleState(_ state: State<[Event]>) {
        handleState(state,
            onLoading: { showLoadingState() },
            onLoaded: { events in
            showData()
                showLoadedState()
            },
            onError: { showErrorState(message: "No data available.") },
            onIdle: { self.hideError() }
        )
    }
    
    private func observeTournamentStandingsViewModel(viewModel: TournamentStandingsViewModel, view: TournamentStandingsView) {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleStandingsState(state, view: view)
            }
            .store(in: &cancellables)
    }
    
    private func handleStandingsState(_ state: State<[Standings]>, view: TournamentStandingsView) {
        handleState(state,
            onLoading: { showLoadingState() },
            onLoaded: { standings in
            view.configure(standings: standings, sport: SportSelectionManager.shared.selectedSport)
            showData()
                showLoadedState()
            },
            onError: { showErrorState(message: "No data available.") },
            onIdle: { self.hideError() }
        )
    }
        
    private func showData() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
    }
    
    private func handleTabChange(to tab: TabType) {
        currentContentView?.removeFromSuperview()
        errorLabel.isHidden = true
        switch tab {
        case .matches:
            let matchesView = TournamentMatchesView()
            matchesView.configure(with: tournamentMatchesViewModel)
            
            matchesView.scrollView.delegate = self
            
            contentView.addSubview(matchesView)
            matchesView.snp.makeConstraints { $0.edges.equalToSuperview() }
            currentContentView = matchesView
            
            observeTournamentMatchesViewModel()
            tournamentMatchesViewModel.loadTournamentMatches()

        case .standings:
            let standingsView = TournamentStandingsView()
            standingsView.delegate = self

            contentView.addSubview(standingsView)
            standingsView.snp.makeConstraints { $0.edges.equalToSuperview() }
            currentContentView = standingsView
            
            standingsView.externalScrollDelegate = self

            observeTournamentStandingsViewModel(viewModel: tournamentStandingsViewModel, view: standingsView)
            tournamentStandingsViewModel.loadTournamentStandings()
        default:
            break
        }
    }
    
    // MARK: Setting up and manipulating views
    func setupNavigationBar() {
        navigationView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationView.configureTitle(league.name)
        navigationView.setTitleAlpha(0)
    }
    
    func setupTabs() {
        customTabsView.configure(firstTab: .matches, secondTab: .standings)
        customTabsView.onTabSelected = { [weak self] tab in
            self?.handleTabChange(to: tab)
        }
        handleTabChange(to: .matches)
    }
    
    func setupHeader() {
        customHeaderView.configure(
            name: league.name,
            countryName: league.country?.name ?? "",
            imageUrl: league.logoUrl
        )
    }
    
    func addViews() {
        topBackgroundView = addTopBackgroundView()
        view.addSubview(customHeaderView)
        view.addSubview(customTabsView)
        view.addSubview(contentView)
        view.addSubview(navigationView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        errorLabel.textColor = .secondaryGray
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
    }
    
    func setupConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        customHeaderView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            customHeaderHeightConstraint = $0.height.equalTo(72).constraint
        }

        customTabsView.snp.makeConstraints {
            customTabsTopConstraint = $0.top.equalTo(customHeaderView.snp.bottom).constraint
            customTabsAltTopConstraint = $0.top.equalTo(navigationView.snp.bottom).constraint
            customTabsAltTopConstraint.deactivate()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(customTabsView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

// MARK: TournamentStandingsViewDelegate
extension LeagueDetailsViewController: TournamentStandingsViewDelegate {
    func didTapTeamLabel(teamId: Int?) {
        guard let id = teamId else { return }
        let teamViewModel = TeamViewModel(teamId: id)
        let teamVC = TeamViewController(teamViewModel: teamViewModel)
        navigationController?.pushViewController(teamVC, animated: true)
    }
}
