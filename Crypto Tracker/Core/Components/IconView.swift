//
//  IconView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 2/12/24.
//

import SwiftUI

struct IconView: View {
    let url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    IconView(url: "")
}
