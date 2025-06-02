//
//  UIViewController+TopBackground.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 01.06.2025..
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    func addTopBackgroundView() -> TopBackgroundView {
        let topBackgroundView = TopBackgroundView()
        view.addSubview(topBackgroundView)
        
        topBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        return topBackgroundView
    }
}
