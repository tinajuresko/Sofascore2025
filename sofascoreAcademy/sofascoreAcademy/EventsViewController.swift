import UIKit
import SofaAcademic
import SnapKit

class EventsViewController: UIViewController, BaseViewProtocol {
    private let topBackgroundView = UIView()
    private let menuView = MenuView()
    private let matchesTableView: UITableView = .init()
    private var eventsViewModel = EventsViewModel()
    private let headerView = HeaderView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegate = self
        addViews()
        setupConstraints()
        styleViews()
        activityIndicator.center = view.center
        
        MenuViewModel.shared.onSportSelectionChanged = { [weak self] selectedSport in
            self?.handleSportSelectionChanged()
        }
        activityIndicator.startAnimating()
        Task {
            await eventsViewModel.loadSections()
            if eventsViewModel.sections.isEmpty {
                self.showError("No data available.")
            } else {
                self.hideError()
            }
            matchesTableView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }

    func hideError() {
        errorLabel.isHidden = true
    }
    
    func handleSportSelectionChanged() {
        activityIndicator.startAnimating()
        Task {
            await eventsViewModel.loadSections()
            if eventsViewModel.sections.isEmpty {
                self.showError("No data available.")
            } else {
                self.hideError()
            }
            matchesTableView.reloadData()
            activityIndicator.stopAnimating()
            menuView.updateSelectorPosition(for: MenuViewModel.shared.selectedSport)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addViews() {
        view.addSubview(topBackgroundView)
        view.addSubview(menuView)
        view.addSubview(headerView)
        view.addSubview(matchesTableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        menuView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
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

extension EventsViewController: HeaderViewDelegate, MatchTableCellDelegate {
    func didTapSettingsButton() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func didTapEvent(event: MatchViewModel) {
        let eventDetailsVC = EventDetailsViewController(event: event)
        navigationController?.pushViewController(eventDetailsVC, animated: true)
    }
}

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
            return UIView()
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

