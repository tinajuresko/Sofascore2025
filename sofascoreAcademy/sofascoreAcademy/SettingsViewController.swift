//
//  SettingsViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 02.04.2025..
//

import Foundation
import UIKit
import SofaAcademic
import SnapKit
import KeychainAccess

class SettingsViewController: UIViewController, BaseViewProtocol {
    private let dismissButton = UIButton(type: .system)
    private let nameLabel = UILabel()
    private let logoutButton = UIButton()
    private let eventCountLabel = UILabel()
    private let leagueCountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
        countDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func countDB() {
        let eventCount = try? DbManager.shared.dbQueue?.read { db in
            try? DBEvent.fetchAll(db).count
        }
        
        let leagueCount = try? DbManager.shared.dbQueue?.read { db in
            try? DBLeague.fetchAll(db).count
        }
        
        eventCountLabel.text = "Events: \(eventCount ?? 0)"
        leagueCountLabel.text = "Leagues: \(leagueCount ?? 0)"
    }
    
    func addViews() {
        view.addSubview(dismissButton)
        view.addSubview(nameLabel)
        view.addSubview(logoutButton)
        view.addSubview(eventCountLabel)
        view.addSubview(leagueCountLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        eventCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        leagueCountLabel.snp.makeConstraints {
            $0.top.equalTo(eventCountLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
        title = "Settings"
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissSettings), for: .touchUpInside)
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        nameLabel.backgroundColor = .clear
        nameLabel.font = .headlineBold32
        nameLabel.textColor = .primaryBlack
        nameLabel.numberOfLines = 2
        
        eventCountLabel.backgroundColor = .clear
        eventCountLabel.font = .regular14
        eventCountLabel.textColor = .secondaryGray
        
        leagueCountLabel.backgroundColor = .clear
        leagueCountLabel.font = .regular14
        leagueCountLabel.textColor = .secondaryGray
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .headerBackground
        logoutButton.layer.cornerRadius = 10
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc func dismissSettings() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func logoutButtonTapped() {
        UserDefaults.standard.removeObject(forKey: "name")
        
        let keychain = Keychain(service: "com.academy")
        try? keychain.remove("token")
        
        clearDB()
        
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    private func clearDB() {
        _ = try? DbManager.shared.dbQueue?.write { db in
            try? DBEvent.deleteAll(db)
            try? DBLeague.deleteAll(db)
        }
    }
}
