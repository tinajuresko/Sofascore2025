//
//  BaseTabViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 15.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic

class BaseTabViewController: UIViewController, BaseViewProtocol, ScrollAnimatableViewController {
    // MARK: - UI Components

    var topBackgroundView: TopBackgroundView!
    let customHeaderView = CustomHeaderView()
    let navigationView = CustomNavigationView()
    let customTabsView = CustomTabsView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let errorLabel = UILabel()

    let contentView = UIView()
    var currentContentView: UIView?
    
    var customHeaderHeightConstraint: Constraint!
    var customTabsTopConstraint: Constraint!
    var customTabsAltTopConstraint: Constraint!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
    }

    // MARK: - Setup
    func addViews() {
        topBackgroundView = addTopBackgroundView()
        [navigationView, customHeaderView, customTabsView, activityIndicator, errorLabel, contentView].forEach {
            view.addSubview($0)
        }
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

    func styleViews() {
        view.backgroundColor = .appBackground
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        errorLabel.textColor = .secondaryGray
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
    }

    // MARK: - Override

    func handleTabChange(to tab: TabType) {
        fatalError("Must override handleTabChange() in subclass")
    }
    
    func setupTabs() {
        fatalError("Must override setUpTabs() in subclass")
    }

    // MARK: - Helpers
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ScrollBehaviorHelper.handleScroll(
            scrollView: scrollView,
            maxHeaderOffset: 72,
            delegate: self
        )
    }

    func setupNavigationBar() {
        navigationView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationView.setTitleAlpha(0)
    }

    func displayContentView(_ view: UIView) {
        contentView.addSubview(view)
        view.snp.makeConstraints { $0.edges.equalToSuperview() }
        currentContentView = view
    }
}
