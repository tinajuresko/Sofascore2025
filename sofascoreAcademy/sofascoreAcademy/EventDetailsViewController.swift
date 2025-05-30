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
import Combine

class EventDetailsViewController: UIViewController, BaseViewProtocol, LoadableView {
    private let selectedEvent: EventDetailsViewModel
    private let incidentsViewModel: IncidentsViewModel
    private let headerView = EventDetailsHeaderView()
    private let customTitleView = CustomNavigationTitleView()
    private let incidentsView = EventDetailsIncidentsView()
    
    private var cancellables = Set<AnyCancellable>()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    let errorLabel = UILabel()

    init(selectedEvent: EventDetailsViewModel) {
        self.selectedEvent = selectedEvent
        self.incidentsViewModel = IncidentsViewModel(eventId: selectedEvent.id)
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
        
        observeIncidentsViewModel()
        incidentsViewModel.loadIncidents()
    }
    private func observeIncidentsViewModel() {
        incidentsViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleState(_ state: State<[Incident]>) {
        handleState(state,
            onLoading: { showLoadingState() },
            onLoaded: { incidents in
                showIncidents(incidents)
                showLoadedState()
            },
            onError: { showErrorState(message: "No data available.") },
                    onIdle: { self.hideError() }
        )
    }
        
    private func showIncidents(_ incidents: [Incident]) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        incidentsView.configure(with: incidents, status: selectedEvent.status)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupNavigationBar() {
        guard let league = selectedEvent.league else {
            return
        }
        customTitleView.configure(with: league, selectedSport: SportSelectionManager.shared.selectedSport)
        customTitleView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func addViews() {
        view.addSubview(headerView)
        view.addSubview(customTitleView)
        view.addSubview(incidentsView)
        
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        customTitleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(customTitleView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(112)
        }

        incidentsView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
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
        incidentsView.backgroundColor = .clear
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        errorLabel.textColor = .secondaryGray
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
    }
}
