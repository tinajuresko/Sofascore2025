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
    }
    
    func setupConstraints() {
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
    }
    
    @objc func dismissSettings() {
        navigationController?.popViewController(animated: true)
    }
}
