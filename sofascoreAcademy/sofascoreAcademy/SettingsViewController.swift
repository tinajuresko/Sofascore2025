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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addViews() {
        view.addSubview(dismissButton)
        view.addSubview(nameLabel)
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
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
        
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}
