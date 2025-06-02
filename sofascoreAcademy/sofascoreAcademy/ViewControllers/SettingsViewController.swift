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
        Task {
            let eventCount = await StorageManager.shared.count(DBEvent.self)
            let leagueCount = await StorageManager.shared.count(DBLeague.self)
            
            eventCountLabel.text = "Events: \(eventCount)"
            leagueCountLabel.text = "Leagues: \(leagueCount)"
        }
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
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "primaryBlack") ?? .black
        ]

        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissSettings), for: .touchUpInside)
        
        nameLabel.text = UserDefaults.standard.string(forKey: KeysManager.userDefaultsKey)
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
        UserDefaults.standard.removeObject(forKey: KeysManager.userDefaultsKey)
        KeychainManager.shared.delete(forKey: KeysManager.keychainKey)
        
        clearDB()

        UIApplication.rootVC?.switchTo(.loggedOut)
    }
    
    private func clearDB() {
        Task {
            await StorageManager.shared.clearTable(DBEvent.self)
            await StorageManager.shared.clearTable(DBLeague.self)
        }
    }
}
