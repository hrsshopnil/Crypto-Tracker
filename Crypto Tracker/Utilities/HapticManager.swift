//
//  HapticManager.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 19/12/24.
//

import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
