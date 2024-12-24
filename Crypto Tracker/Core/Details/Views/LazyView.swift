//
//  LazyView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 23/12/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
        print("LazyView got called")
    }
    
    var body: Content {
        build()
    }
}
