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
import Combine

class LoginViewController: UIViewController, BaseViewProtocol {
    private let topSpacerView = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let videoContainerView = UIView()
    private let textContainerView = UIView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    private let usernameTextField = PaddedTextField()
    private let passwordTextField = PaddedTextField()
    private let errorLabel = UILabel()
    private let loginButton = UIButton()
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private var viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
        setupVideoPlayer()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            let isLandscape = size.width > size.height
            self.stackView.axis = isLandscape ? .horizontal : .vertical
        }, completion: { _ in
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoContainerView.bounds
    }

    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topSpacerView)
        contentView.addSubview(stackView)

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
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(topSpacerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
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
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
        }

        videoContainerView.snp.makeConstraints {
            $0.height.equalTo(300).priority(.low)
        }
    }

    func styleViews() {
        view.backgroundColor = .appBackground
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        videoContainerView.backgroundColor = .clear
        textContainerView.backgroundColor = .clear
        
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
      
        usernameTextField.setPlaceholder("Username", color: .secondaryGray)
        passwordTextField.setPlaceholder("Password", color: .secondaryGray)
        passwordTextField.isSecureTextEntry = true
        
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

        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
            .sink { [weak self] _ in
                self?.player?.seek(to: .zero)
                self?.player?.play()
            }
            .store(in: &cancellables)
    }
    
    @objc private func loginButtonTapped() {
        viewModel.onLoginResponse = { [weak self] errorMessage in
            DispatchQueue.main.async {
                if errorMessage.isEmpty {
                    self?.errorLabel.text = errorMessage
                    UIApplication.rootVC?.switchTo(.loggedIn)
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
