//
//  SearchBar.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 3/12/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
                .font(.headline)
            TextField("Search", text: $text)
                .autocorrectionDisabled()
                .overlay (
                    Image(systemName: "xmark.circle.fill")
                        .opacity(text.isEmpty ? 0 : 0.8)
                        .padding(6)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            text = ""
                        }
                    ,alignment: .trailing
                )
            
        }
        .padding(10)
        .background(
            Capsule()
                .stroke(lineWidth: 1.4)
        )
        .padding()
    }
}

#Preview {
    SearchBar(text: .constant("adfsasd"))
}
