import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {
    
    private let topBackgroundView = UIView()
    private let menuView = MenuView()
    private let matchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
   
    var sections: [LeagueSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "AppBackgroundColor")
        
        sections = groupedEvents()
        
        configureTop()
        configureMenu()
        configureMatchesTableView()
    }
  
    func configureTop() {
        topBackgroundView.backgroundColor = AppStyles.Colors.headerBackgroundColor
        view.addSubview(topBackgroundView)
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    func configureMenu() {
        view.addSubview(menuView)
        menuView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configureMatchesTableView() {
        view.addSubview(matchesTableView)
        setTableViewDelegates()
        matchesTableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchCell")
        matchesTableView.register(LeagueHeaderView.self, forHeaderFooterViewReuseIdentifier: "LeagueHeader")
        matchesTableView.snp.makeConstraints {
            $0.top.equalTo(menuView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setTableViewDelegates() {
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 56
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "LeagueHeader") as! LeagueHeaderView
        let league = sections[section].league
        header.configure(with: league)
        return header
    }
}

