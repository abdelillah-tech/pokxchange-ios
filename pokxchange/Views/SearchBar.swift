//
//  SearchBar.swift
//  pokxchange
//
//  Created by abdelillah ghomari on 7/3/21.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                    }
                }
                if searching {
                    Button("Cancel") {
                        searchText = ""
                        withAnimation {
                            searching = false
                        }
                    }
                }
            }
            .padding()
            .foregroundColor(.gray)
        }
        .frame(height: 40)
        .cornerRadius(13)
    }
 }
