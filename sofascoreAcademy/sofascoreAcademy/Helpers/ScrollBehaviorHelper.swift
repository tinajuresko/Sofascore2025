//
//  ScrollBehaviorHelper.swift
//  sofascoreAcademy
//
//  Created by Tina Jureško on 02.06.2025..
//

import Foundation
import UIKit
import SnapKit

protocol ScrollAnimatableViewController: AnyObject {
    var customHeaderHeightConstraint: Constraint! { get }
    var tournamentTabsTopConstraint: Constraint! { get }
    var tournamentTabsAltTopConstraint: Constraint! { get }

    var navigationView: CustomNavigationView { get }
    var customHeaderView: CustomHeaderView { get }
    var tournamentTabsView: TournamentTabsView { get }
}

class ScrollBehaviorHelper {
    static func handleScroll(
        scrollView: UIScrollView,
        maxHeaderOffset: CGFloat,
        delegate: ScrollAnimatableViewController
    ) {
        let offset = scrollView.contentOffset.y
        let clampedOffset = min(max(offset, 0), maxHeaderOffset)

        delegate.customHeaderHeightConstraint.update(offset: maxHeaderOffset - clampedOffset)

        if clampedOffset >= maxHeaderOffset {
            if delegate.tournamentTabsTopConstraint.isActive {
                delegate.tournamentTabsTopConstraint.deactivate()
                delegate.tournamentTabsAltTopConstraint.activate()
            }
        } else {
            if delegate.tournamentTabsAltTopConstraint.isActive {
                delegate.tournamentTabsAltTopConstraint.deactivate()
                delegate.tournamentTabsTopConstraint.activate()
            }
        }

        let navAlpha = min(1, max(0, (offset - 30) / 30))
        delegate.navigationView.setTitleAlpha(navAlpha)

        let headerAlpha = max(0, 1 - (offset / maxHeaderOffset))
        delegate.customHeaderView.alpha = headerAlpha
    }
}
