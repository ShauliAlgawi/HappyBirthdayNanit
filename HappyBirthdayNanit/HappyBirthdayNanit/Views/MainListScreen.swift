//
//  MainListScreen.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import SwiftUI

struct MainListScreen: View {
    let kids = MainScreenItem.mockList
    var body: some View {
        NavigationView {
        
        ScrollView {
            ForEach(kids, id: \.id) { childItem in
                MainScreenItemCell(item: childItem)
                Divider()
            }
        }
        .lineSpacing(10)
        .navigationTitle("Happy Birthday")
        }
    }
}

#Preview {
    MainListScreen()
}

