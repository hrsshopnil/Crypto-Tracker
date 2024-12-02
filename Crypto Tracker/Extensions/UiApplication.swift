//
//  UiApplication.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 3/12/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
