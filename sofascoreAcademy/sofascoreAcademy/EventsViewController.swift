import UIKit
import SofaAcademic
import SnapKit
import Combine

class EventsViewController: UIViewController, BaseViewProtocol {
    private let topBackgroundView = UIView()
    private let menuView = MenuView()
    private var eventsViewModel = EventsViewModel()
    private let eventsHeaderView = EventsHeaderView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()
    private let matchesTableView: UITableView = .init()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsHeaderView.delegate = self
        addViews()
        setupConstraints()
        styleViews()
        activityIndicator.center = view.center
        
        MenuViewModel.shared.onSportSelectionChanged = { [weak self] selectedSport in
            self?.handleSportSelectionChanged()
        }
        observeEventsViewModel()
    }
    
    private func observeEventsViewModel () {
        eventsViewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleState(_ state: EventsViewModel.State) {
        switch state {
        case .loading:
            showLoadingState()
        case .loaded(_):
            showLoadedState()
        case .error:
            showErrorState()
        default:
            break
        }
    }
    
    func showLoadingState() {
        activityIndicator.startAnimating()
        hideError()
    }
    
    func showLoadedState() {
        activityIndicator.stopAnimating()
        hideError()
        matchesTableView.reloadData()
    }
    
    func showErrorState() {
        activityIndicator.stopAnimating()
        showError("No data available.")
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    func hideError() {
        errorLabel.isHidden = true
    }
    
    func handleSportSelectionChanged() {
        self.eventsViewModel.sections = []
        self.matchesTableView.reloadData()
        menuView.updateSelectorPosition(for: MenuViewModel.shared.selectedSport)
        Task {
            await eventsViewModel.loadSections()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        switch eventsViewModel.state {
        case .idle:
            Task {
                await eventsViewModel.loadSections()
            }
        default:
            break
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addViews() {
        view.addSubview(topBackgroundView)
        view.addSubview(menuView)
        view.addSubview(eventsHeaderView)
        view.addSubview(matchesTableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        eventsHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        menuView.snp.makeConstraints {
            $0.top.equalTo(eventsHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
                
        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(menuView.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        errorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
        matchesTableView.separatorStyle = .none
        matchesTableView.backgroundColor = .clear
        topBackgroundView.backgroundColor = .headerBackground
        setTableViewDelegates()
        setupTableView(matchesTableView: matchesTableView)
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        errorLabel.textColor = .secondaryGray
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
    }
    
    func setTableViewDelegates() {
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
    }
    
    func setupTableView(matchesTableView: UITableView) {
        matchesTableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
        matchesTableView.register(LeagueHeaderView.self, forHeaderFooterViewReuseIdentifier: "LeagueHeader")
    }
}

// MARK: - EventsHeaderViewDelegate
extension EventsViewController: EventsHeaderViewDelegate {
    func didTapSettingsButton() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

// MARK: - MatchTableCellDelegate
extension EventsViewController: MatchTableCellDelegate {
    func didTapEvent(selectedEvent: EventDetailsViewModel) {
        let eventDetailsVC = EventDetailsViewController(selectedEvent: selectedEvent)
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventsViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsViewModel.sections[section].matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchTableViewCell else {
            return UITableViewCell()
        }
        let match = eventsViewModel.sections[indexPath.section].matches[indexPath.row]
        let viewModel = MatchViewModel(event: match)
        cell.configure(with: viewModel)
        cell.delegate = self
        return cell
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LeagueHeader") as? LeagueHeaderView
        else {
            return nil
        }
        let league = eventsViewModel.sections[section].league
        header.configure(with: league)
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            let bgView = UIView(frame: header.bounds)
            bgView.backgroundColor = .appBackground
            header.backgroundView = bgView
        }
    }
}

