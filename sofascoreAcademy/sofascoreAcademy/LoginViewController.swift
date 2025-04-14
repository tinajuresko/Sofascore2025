//
//  LoginViewController.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 12.04.2025..
//

import Foundation
import UIKit
import AVKit
import SnapKit
import SofaAcademic

class LoginViewController: UIViewController, BaseViewProtocol {
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let videoContainerView = UIView()
    private let textContainerView = UIView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let stackView = UIStackView()
    private let loginButton = UIButton()
    let errorLabel = UILabel()
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
        setupVideoPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let layer = playerLayer {
            if layer.superlayer == nil {
                videoContainerView.layer.addSublayer(layer)
            }
            layer.frame = videoContainerView.bounds
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayoutForOrientation()
    }

    func addViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(textContainerView)
        stackView.addArrangedSubview(videoContainerView)
        
        textContainerView.addSubview(titleLabel)
        textContainerView.addSubview(textLabel)
        textContainerView.addSubview(usernameTextField)
        textContainerView.addSubview(passwordTextField)
        textContainerView.addSubview(loginButton)
        textContainerView.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        textContainerView.snp.makeConstraints {
            $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
                
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
                
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func styleViews() {
        view.backgroundColor = .appBackground
        videoContainerView.backgroundColor = .clear
        
        titleLabel.text = "Sign in to Sofascore"
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .primaryBlack
        titleLabel.textAlignment = .center
        titleLabel.font = .headlineBold32
        titleLabel.numberOfLines = 2
        
        textLabel.text = "Hundreds of stats. Infinite love of the game."
        textLabel.backgroundColor = .clear
        textLabel.textColor = .primaryBlack
        textLabel.textAlignment = .center
        textLabel.font = .regular14
      
        usernameTextField.placeholder = "Username"
        usernameTextField.backgroundColor = .clear
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.font = .regular14
        usernameTextField.textColor = .secondaryGray
        usernameTextField.autocapitalizationType = .none
                
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .clear
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = .regular14
        passwordTextField.textColor = .secondaryGray
        passwordTextField.autocapitalizationType = .none
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .headerBackground
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
                
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        
        errorLabel.textColor = .red
        errorLabel.backgroundColor = .clear
        errorLabel.font = .regular14
        errorLabel.textAlignment = .center
        errorLabel.text = ""
        errorLabel.numberOfLines = 2
    }
    
    private func updateLayoutForOrientation() {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
            textContainerView.snp.remakeConstraints {
                $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
                $0.leading.trailing.equalTo(view).inset(20)
            }
            videoContainerView.snp.remakeConstraints {
                $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
                $0.top.bottom.equalTo(view).inset(16)
            }
        } else {
            stackView.axis = .vertical
            textContainerView.snp.remakeConstraints {
                $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
                $0.leading.trailing.equalTo(view).inset(20)
            }
            videoContainerView.snp.remakeConstraints {
                $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
                $0.leading.trailing.equalTo(view).inset(16)
            }
        }
    }
    
    private func setupVideoPlayer() {
        guard let path = Bundle.main.path(forResource: "sports", ofType: "mp4") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        playerLayer = layer
        player?.play()

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
    }
    
    @objc private func loginButtonTapped() {
        viewModel.onLoginResponse = { [weak self] errorMessage in
            DispatchQueue.main.async {
                if errorMessage.isEmpty {
                    self?.errorLabel.text = errorMessage
                    let eventsVC = EventsViewController()
                    self?.navigationController?.pushViewController(eventsVC, animated: true)
                } else {
                    self?.errorLabel.text = errorMessage
                }
            }
        }

        Task {
            await viewModel.login(username: usernameTextField.text, password: passwordTextField.text)
        }
    }
}
