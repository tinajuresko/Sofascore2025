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

class TeamViewController: UIViewController, BaseViewProtocol, LoadableView, ScrollAnimatableViewController, UIScrollViewDelegate {
    private let teamViewModel: TeamViewModel
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
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let errorLabel = UILabel()
    
    private let infoLabel = UILabel()
    private let teamDetailsView = TeamDetailsView()
    private let teamSquadView = TeamSquadView()


    init(teamViewModel: TeamViewModel) {
        self.teamViewModel = teamViewModel
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
        setupTabs()
        
        observeViewModel()
        teamViewModel.loadTeam()
    }
    
    private func observeViewModel() {
        teamViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
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

    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ScrollBehaviorHelper.handleScroll(
            scrollView: scrollView,
            maxHeaderOffset: 72,
            delegate: self
        )
    }

    private func handleState(_ state: State<(TeamInfo?, [Player], [League])>) {
        handleState(state,
            onLoading: { showLoadingState() },
            onLoaded: { [weak self] (teamInfo, players, tournaments) in
                guard let self = self, let teamInfo = teamInfo else { return }
                self.showData()
                self.showLoadedState()

                self.navigationView.configureTitle(teamInfo.team.name)
                self.navigationView.setTitleAlpha(0)

                self.customHeaderView.configure(
                    name: teamInfo.team.name,
                    countryName: teamInfo.team.country?.name ?? "",
                    imageUrl: teamInfo.team.logoUrl
                )
            
                self.teamDetailsView.configure(with: teamInfo, and: players, tournaments: tournaments)
                self.teamSquadView.configure(players: players)
            },
            onError: { showErrorState(message: "Failed to load team data.") },
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
        case .details:
            if teamDetailsView.superview == nil {
                contentView.addSubview(teamDetailsView)
                teamDetailsView.snp.makeConstraints { $0.edges.equalToSuperview() }
            }
            teamDetailsView.isHidden = false
            teamSquadView.isHidden = true
            contentView.bringSubviewToFront(teamDetailsView)
            currentContentView = teamDetailsView
            
            teamDetailsView.scrollView.delegate = self
        case .squad:
            if teamSquadView.superview == nil {
                contentView.addSubview(teamSquadView)
                teamSquadView.snp.makeConstraints { $0.edges.equalToSuperview() }
            }
            teamSquadView.isHidden = false
            teamDetailsView.isHidden = true
            contentView.bringSubviewToFront(teamSquadView)
            currentContentView = teamSquadView
            
            teamSquadView.externalScrollDelegate = self
        default:
            break
        }
    }
    
    // MARK: Setting up and manipulating views
    func setupNavigationBar() {
        navigationView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    func setupTabs() {
        customTabsView.configure(firstTab: .details, secondTab: .squad)
        customTabsView.onTabSelected = { [weak self] tab in
            self?.handleTabChange(to: tab)
        }
        handleTabChange(to: .details)
    }
    
    func addViews() {
        topBackgroundView = addTopBackgroundView()
        view.addSubview(customHeaderView)
        view.addSubview(customTabsView)
        teamDetailsView.isHidden = true
        view.addSubview(contentView)
        view.addSubview(navigationView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        
        contentView.addSubview(teamDetailsView)
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        errorLabel.textColor = .secondaryGray
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        
        infoLabel.font = .regularBold20
        infoLabel.textColor = .primaryBlack
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
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
            $0.height.equalTo(72)
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
        
        teamDetailsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
