//
//  RootViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 18.04.2025..
//

import Foundation
import UIKit
import SofaAcademic

enum AppState {
    case loggedIn
    case loggedOut
}

class RootViewController: UIViewController, BaseViewProtocol {
    
    private var current: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        showInitialController()
    }
    
    private func showInitialController() {
        if AuthManager.isUserAuthorized() {
            switchTo(.loggedIn)
        } else {
            switchTo(.loggedOut)
        }
    }
    
    func switchTo(_ state: AppState) {
        let viewController: UIViewController
        switch state {
        case .loggedIn:
            let eventsVC = EventsViewController()
            viewController = UINavigationController(rootViewController: eventsVC)
        case .loggedOut:
            let loginVC = LoginViewController()
            viewController = UINavigationController(rootViewController: loginVC)
        }
        switchTo(viewController: viewController)
    }
    
    func switchTo(viewController: UIViewController) {
        current?.removeFromParent()
        current?.view.removeFromSuperview()
        
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        current = viewController
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
    }
    
    func addViews() {
    }
    
    func setupConstraints() {
    }
}
