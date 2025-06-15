//
//  TeamViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.06.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit
import Combine

class TeamViewController: BaseTabViewController, LoadableView, UIScrollViewDelegate {

    private let teamViewModel: TeamViewModel
    
    private let teamDetailsView = TeamDetailsView()
    private let teamSquadView = TeamSquadView()
    private var cancellables = Set<AnyCancellable>()
    
    private var currentTab: TabType = .details
    
    init(teamViewModel: TeamViewModel) {
        self.teamViewModel = teamViewModel
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
            if let scrollView = (currentContentView as? TeamDetailsView)?.scrollView {
                scrollViewDidScroll(scrollView)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTabs()
        
        teamDetailsView.scrollView.delegate = self
        teamSquadView.externalScrollDelegate = self
        
        observeViewModel()
        teamViewModel.loadTeam()
    }

    // MARK: - Tabs
    
    override func setupTabs() {
        customTabsView.configure(firstTab: .details, secondTab: .squad)
        customTabsView.onTabSelected = { [weak self] tab in
            self?.handleTabChange(to: tab)
        }
        handleTabChange(to: .details)
    }

    override func handleTabChange(to tab: TabType) {
        currentContentView?.removeFromSuperview()
        errorLabel.isHidden = true
        currentTab = tab
        
        switch tab {
        case .details:
            displayContentView(teamDetailsView)
            updateUI()
            if teamViewModel.state.isIdleOrError {
                teamViewModel.loadTeam()
            }
        case .squad:
            displayContentView(teamSquadView)
            updateUI()
            if teamViewModel.state.isIdleOrError {
                teamViewModel.loadTeam()
            }
        default:
            break
        }
    }
    
    private func updateUI() {
        let state = teamViewModel.state
        handleState(state)
    }

    // MARK: - ViewModel Observation
    
    private func observeViewModel() {
        teamViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }

    private func handleState(_ state: State<(TeamInfo?, [Player], [League])>) {
        handleState(state,
            onLoading: { [weak self] in
                self?.showLoadingState()
                self?.setContentHidden(true)
            },
            onLoaded: { [weak self] (teamInfo, players, tournaments) in
                guard let self = self, let teamInfo = teamInfo else { return }
                
                self.showLoadedState()
                self.setContentHidden(false)
                setupNavigationHeader(with: teamInfo)

                self.teamDetailsView.configure(with: teamInfo, and: players, tournaments: tournaments)
                self.teamSquadView.configure(players: players)
            },
            onError: { [weak self] in
                self?.showErrorState(message: "Failed to load team data.")
                self?.setContentHidden(true)
            },
            onIdle: { [weak self] in
                self?.hideError()
                self?.setContentHidden(true)
            }
        )
    }

    // MARK: - Helper
    
    private func setupNavigationHeader(with teamInfo: TeamInfo){
        navigationView.configureTitle(teamInfo.team.name)
        customHeaderView.configure(
            name: teamInfo.team.name,
            countryName: teamInfo.team.country?.name ?? "",
            imageUrl: teamInfo.team.logoUrl
        )
    }

    private func setContentHidden(_ hidden: Bool) {
        teamDetailsView.isHidden = hidden && currentTab == .details
        teamSquadView.isHidden = hidden && currentTab == .squad
    }
}
