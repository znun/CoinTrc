//
//  HapticManager.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 17/12/23.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
