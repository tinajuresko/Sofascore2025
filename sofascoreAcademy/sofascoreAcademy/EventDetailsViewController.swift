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
    private let selectedEvent: EventDetailsViewModel
    private let headerView = EventDetailsHeaderView()
    private let customTitleView = CustomNavigationTitleView()
    
    init(selectedEvent: EventDetailsViewModel){
        self.selectedEvent = selectedEvent
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
        headerView.configure(with: selectedEvent)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupNavigationBar() {
        guard let league = selectedEvent.league else {
            return
        }
        customTitleView.configure(with: league, selectedSport: MenuViewModel.shared.selectedSport)
        customTitleView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func addViews() {
        view.addSubview(headerView)
        view.addSubview(customTitleView)
    }
    
    func setupConstraints() {
        customTitleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(customTitleView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
    }
}
