//
//  TeamDetailsView.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 04.06.2025..
//

import Foundation
import UIKit
import SnapKit
import SofaAcademic
import Combine

class TeamDetailsView: BaseView {
    private var tournaments: [League] = []
    
    let scrollView = UIScrollView()
    private let contentView = UIView()
    private let infoContainer = UIView()
    private let playersContainer = UIView()
    private let venueContainer = UIView()
    
    private let teamInfoTitle = UILabel()
    private let coachNameLabel = UILabel()
    private let coachCountryLabel = UILabel()
    private let coachImageView = AsyncImageView()
    
    private let playersIcon = UIImageView()
    private let numberOfPlayers = UILabel()
    private let totalPlayersLabel = UILabel()
    private let numForeignPlayersLabel = UILabel()
    private let foreignPlayersLabel = UILabel()
    private let firstStack = UIStackView()
    private let secondStack = UIStackView()
    private let playersStack = UIStackView()
    private let foreignProgressView = ConcentricRingView()
    
    private let tournamentsTitle = UILabel()
    private let tournamentsContainer = UIView()
    
    private let venueTitle = UILabel()
    private let venueNameLabel = UILabel()
    private let venueCityLabel = UILabel()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TournamentCell.self, forCellWithReuseIdentifier: "TournamentCell")
        return collectionView
    }()
    private var collectionViewHeightConstraint: Constraint?

    
    override func addViews() {
        super.addViews()
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [infoContainer, playersContainer, tournamentsContainer, venueContainer].forEach {
            contentView.addSubview($0)
            addSeparator(to: $0)
        }
        
        // Info container
        infoContainer.addSubview(teamInfoTitle)
        infoContainer.addSubview(coachImageView)
        infoContainer.addSubview(coachNameLabel)
        infoContainer.addSubview(coachCountryLabel)
        
        // Players container
        firstStack.addArrangedSubview(playersIcon)
        firstStack.addArrangedSubview(numberOfPlayers)
        firstStack.addArrangedSubview(totalPlayersLabel)
        secondStack.addArrangedSubview(numForeignPlayersLabel)
        secondStack.addArrangedSubview(foreignPlayersLabel)
        secondStack.insertArrangedSubview(foreignProgressView, at: 0)
        playersStack.addArrangedSubview(firstStack)
        playersStack.addArrangedSubview(secondStack)
        playersContainer.addSubview(playersStack)
        
        // Tournaments
        tournamentsContainer.addSubview(tournamentsTitle)
        tournamentsContainer.addSubview(collectionView)
    
        // Venue container
        venueContainer.addSubview(venueTitle)
        venueContainer.addSubview(venueNameLabel)
        venueContainer.addSubview(venueCityLabel)
    }

    override func styleViews() {
        super.styleViews()
        backgroundColor = .containerBackground
        collectionView.dataSource = self
        collectionView.delegate = self

        [infoContainer, playersContainer, tournamentsContainer, venueContainer].forEach {
            $0.backgroundColor = .white
        }
        
        [teamInfoTitle, tournamentsTitle, venueTitle].forEach {
            $0.font = .regularBold16
            $0.textColor = .primaryBlack
            $0.textAlignment = .center
        }
        teamInfoTitle.text = "Team Info"
        tournamentsTitle.text = "Tournaments"
        venueTitle.text = "Venue"
        totalPlayersLabel.text = "Total Players"
        foreignPlayersLabel.text = "Foreign Players"

        coachNameLabel.font = .regular14
        coachNameLabel.textColor = .primaryBlack
        coachCountryLabel.font = .regularBold12
        coachCountryLabel.textColor = .secondaryGray
        coachImageView.layer.cornerRadius = 20
        coachImageView.clipsToBounds = true
        coachImageView.contentMode = .scaleAspectFill

        [totalPlayersLabel, foreignPlayersLabel].forEach {
            $0.font = .regular14
            $0.textColor = .secondaryGray
            $0.textAlignment = .center
        }
        playersIcon.image = UIImage(named: "team")
        [numberOfPlayers, numForeignPlayersLabel].forEach {
            $0.font = .regularBold12
            $0.textColor = .headerBackground
            $0.textAlignment = .center
        }
        
        firstStack.axis = .vertical
        firstStack.alignment = .center
        firstStack.spacing = 4

        secondStack.axis = .vertical
        secondStack.alignment = .center
        secondStack.spacing = 4
        
        playersStack.axis = .horizontal
        playersStack.alignment = .center
        playersStack.distribution = .fillEqually
        playersStack.spacing = 16
        
        [venueNameLabel, venueCityLabel].forEach {
            $0.font = .regular14
            $0.textColor = .primaryBlack
            $0.textAlignment = .center
        }
    }

    override func setupConstraints() {
        super.setupConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        infoContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(112)
        }

        playersContainer.snp.makeConstraints {
            $0.top.equalTo(infoContainer.snp.bottom)
            $0.leading.trailing.equalTo(infoContainer)
            $0.height.equalTo(124)
        }
        
        tournamentsContainer.snp.makeConstraints {
            $0.top.equalTo(playersContainer.snp.bottom)
            $0.leading.trailing.equalTo(infoContainer)
            $0.bottom.equalTo(collectionView.snp.bottom).offset(8)
        }

        venueContainer.snp.remakeConstraints {
            $0.top.equalTo(tournamentsContainer.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(88)
            $0.bottom.equalToSuperview().inset(16)
        }

        // Info container layout
        teamInfoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }

        coachImageView.snp.makeConstraints {
            $0.top.equalTo(teamInfoTitle.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(40)
            $0.bottom.equalToSuperview().inset(8)
        }

        coachNameLabel.snp.makeConstraints {
            $0.leading.equalTo(coachImageView.snp.trailing).offset(16)
            $0.top.equalTo(coachImageView.snp.top).offset(4)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
        }

        coachCountryLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(coachNameLabel)
            $0.top.equalTo(coachNameLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(18)
            $0.height.equalTo(16)
        }

        // Players container layout
        playersStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        // Tournaments layout
        tournamentsTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(tournamentsTitle.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            collectionViewHeightConstraint = $0.height.equalTo(100).constraint
        }
        
        // Venue layout
        venueTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
        }

        venueNameLabel.snp.makeConstraints {
            $0.top.equalTo(venueTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(venueCityLabel.snp.leading).offset(-8)
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview().inset(8)
        }

        venueCityLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(16)
            $0.centerY.equalTo(venueNameLabel)
        }
        venueNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        venueCityLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        venueNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        venueCityLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        foreignProgressView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
    }

    func configure(with teamInfo: TeamInfo, and players: [Player], tournaments: [League]) {
        
        coachNameLabel.text = "Coach: \(teamInfo.manager?.name ?? "")"
        coachCountryLabel.text = teamInfo.manager?.country?.name
        coachImageView.setImage(from: teamInfo.manager?.imageUrl)
        venueNameLabel.text = teamInfo.venue?.name ?? "-"
        venueCityLabel.text = teamInfo.venue?.city?.name ?? "-"
        
        let total = players.count
        numberOfPlayers.text = "\(total)"
        
        let foreign = players.filter { $0.isForeign == true }.count
        numForeignPlayersLabel.text = "\(foreign)"
        
        let ratio = total > 0 ? Double(foreign) / Double(total) : 0
        foreignProgressView.progress = CGFloat(ratio)
        
        self.tournaments = tournaments
        collectionView.reloadData()
        updateCollectionViewHeight()
    }
    
    private func addSeparator(to view: UIView) {
        let separator = UIView()
        separator.backgroundColor = .periodContainerBackground
        view.addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func updateCollectionViewHeight() {
        let itemsPerRow: CGFloat = 3
        let cellHeight: CGFloat = 96
        let lineSpacing: CGFloat = 12
        let rows = ceil(CGFloat(tournaments.count) / itemsPerRow)
        let height = rows * cellHeight + max(0, rows - 1) * lineSpacing
        collectionViewHeightConstraint?.update(offset: height)
        layoutIfNeeded()
    }
}

// MARK: UICollectionViewDataSource

extension TeamDetailsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tournaments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TournamentCell", for: indexPath) as? TournamentCell else {
            return UICollectionViewCell()
        }
        let tournament = tournaments[indexPath.item]
        cell.nameLabel.text = tournament.name
        cell.imageView.setImage(from: tournament.logoUrl)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 12
        let itemsPerRow: CGFloat = 3
        let totalSpacing = (itemsPerRow - 1) * spacing
        let itemWidth = (collectionView.bounds.width - totalSpacing) / itemsPerRow
        return CGSize(width: itemWidth, height: 80)
    }

}
