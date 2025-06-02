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
    private var topBackgroundView: TopBackgroundView!
    private let contentView = UIView()
    private var currentContentView: UIView?
    
    private var cancellables = Set<AnyCancellable>()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let errorLabel = UILabel()
    private let tournamentMatchesViewModel: TournamentMatchesViewModel
    
    var customHeaderHeightConstraint: Constraint!
    var tournamentTabsTopConstraint: Constraint!
    var tournamentTabsAltTopConstraint: Constraint!
        
    var tournamentTabsView = TournamentTabsView()
    var navigationView = CustomNavigationView()
    var customHeaderView = CustomHeaderView()

    init(league: League) {
        self.league = league
        self.tournamentMatchesViewModel = TournamentMatchesViewModel(leagueId: league.id)
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
        navigationView.configureTitle(league.name)
        navigationView.setTitleAlpha(0)
        
        tournamentTabsView.onTabSelected = { [weak self] tab in
            self?.handleTabChange(to: tab)
        }

        customHeaderView.configure(
            leagueName: league.name,
            countryName: league.country?.name ?? "",
            leagueImageUrl: league.logoUrl
        )
        
        handleTabChange(to: .matches)
        observeTournamentMatchesViewModel()
        tournamentMatchesViewModel.loadTournamentMatches()
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
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ScrollBehaviorHelper.handleScroll(
            scrollView: scrollView,
            maxHeaderOffset: 72,
            delegate: self
        )
    }
    
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
            showMatches(events)
                showLoadedState()
            },
            onError: { showErrorState(message: "No data available.") },
                    onIdle: { self.hideError() }
        )
    }
        
    private func showMatches(_ events: [Event]) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
    }
    
    private func handleTabChange(to tab: LeagueTabType) {
        currentContentView?.removeFromSuperview()

        switch tab {
        case .matches:
            let matchesView = TournamentMatchesView()
            matchesView.configure(with: tournamentMatchesViewModel)
            (matchesView as TournamentMatchesView).scrollView.delegate = self
            contentView.addSubview(matchesView)
            matchesView.snp.makeConstraints { $0.edges.equalToSuperview() }
            currentContentView = matchesView

        case .standings:
            let standingsView = TournamentStandingsView()
            contentView.addSubview(standingsView)
            standingsView.snp.makeConstraints { $0.edges.equalToSuperview() }
            currentContentView = standingsView
        }
    }
    
    func setupNavigationBar() {
        navigationView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func addViews() {
        topBackgroundView = addTopBackgroundView()
        view.addSubview(customHeaderView)
        view.addSubview(tournamentTabsView)
        view.addSubview(contentView)
        view.addSubview(navigationView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
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

        tournamentTabsView.snp.makeConstraints {
            tournamentTabsTopConstraint = $0.top.equalTo(customHeaderView.snp.bottom).constraint
            tournamentTabsAltTopConstraint = $0.top.equalTo(navigationView.snp.bottom).constraint
            tournamentTabsAltTopConstraint.deactivate()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(tournamentTabsView.snp.bottom)
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
