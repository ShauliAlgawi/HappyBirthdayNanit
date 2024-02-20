//
//  MainListScreen.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import SwiftUI
import SwiftData

struct MainListScreen: View {
    ///Environment variable
    @Environment(\.modelContext) private var context
    
    ///Persistent data query for kids list
    @Query(sort: \ChildItem.uuid, order: .reverse) private var kids: [ChildItem]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(kids, id: \.id) { childItem in
                    MainScreenItemCell(item: childItem)
                }
            }
            .lineSpacing(10)
            .navigationTitle("Happy Birthday")
            .toolbar {
                NavigationLink {
                    AddUpdateChildView()
                } label: {
                    Text("Add Child")
                }
            }
        }
    }
    
    private func deleteItem(offsets: IndexSet) {
        
    }
}

#Preview {
    MainListScreen()
}

