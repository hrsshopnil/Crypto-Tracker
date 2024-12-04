//
//  IconView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 2/12/24.
//

import SwiftUI
import Kingfisher

struct IconView: View {
    let url: String
    var body: some View {
        KFImage(URL(string: url))
            .placeholder({ progress in
                ProgressView()
            })
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
    }
}

#Preview {
    IconView(url: "")
}
