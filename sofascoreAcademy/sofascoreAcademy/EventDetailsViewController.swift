//
//  EventDetailsViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 03.04.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit

class EventDetailsViewController: UIViewController, BaseViewProtocol {
    private let event: MatchViewModel
    private let eventDetailsView = EventDetailsView()
    private let leagueLogoImageView = AsyncImageView()
    private let customTitleView = CustomNavigationTitleView()
    
    init(event: MatchViewModel){
        self.event = event
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
        eventDetailsView.configure(with: event)
    }
    
    func setupNavigationBar() {
        guard let league = event.league else {
            return
        }
        customTitleView.configure(with: league, selectedSport: MenuViewModel.shared.selectedSport)
        self.navigationItem.titleView = customTitleView
    }
    
    func addViews() {
        view.addSubview(eventDetailsView)
    }
    
    func setupConstraints() {
        eventDetailsView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
    }
}
