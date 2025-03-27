import UIKit
import SofaAcademic
import SnapKit

class EventsViewController: UIViewController, BaseViewProtocol {
    private let topBackgroundView = UIView()
    private let menuView = MenuView()
    private let matchesTableView: UITableView = .init()
    var sections: [LeagueSection] = []
    private let eventsViewModel = EventsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = eventsViewModel.getLeagueSections(allEvents: getEventData())
        addViews()
        setupConstraints()
        styleViews()
    }
    
    func addViews() {
        view.addSubview(topBackgroundView)
        view.addSubview(menuView)
        view.addSubview(matchesTableView)
    }
    
    func setupConstraints() {
        topBackgroundView.backgroundColor = .headerBackground
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        menuView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        setTableViewDelegates()
        matchesTableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
        matchesTableView.register(LeagueHeaderView.self, forHeaderFooterViewReuseIdentifier: "LeagueHeader")
        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(menuView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
        matchesTableView.separatorStyle = .none
    }
    
    func getEventData() -> [Event]{
        let allEvents = Homework3DataSource().events()
        return allEvents
    }
    
    func setTableViewDelegates() {
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchTableViewCell else {
            return UITableViewCell()
        }
        let match = sections[indexPath.section].matches[indexPath.row]
        let viewModel = MatchViewModel(event: match)
        cell.configure(with: viewModel)
        return cell
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LeagueHeader") as! LeagueHeaderView
        let league = sections[section].league
        header.configure(with: league)
        return header
    }
}

