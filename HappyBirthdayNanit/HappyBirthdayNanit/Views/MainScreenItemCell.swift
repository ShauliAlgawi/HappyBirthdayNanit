//
//  MainScreenItemCell.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import SwiftUI

struct MainScreenItemCell: View {
    @State var item: ChildItem
    var body: some View {
        VStack {
            HStack {
                VStack (spacing: 20) {
                    CircleImage(image: item.image)
                        .frame(width: 100, height: 100)
                    NavigationLink(destination: AddUpdateChildView(childItem: item)) {
                        Text("Edit")
                    }
                    .foregroundColor(.black)
                    .disabled(item.name.isEmpty)
                }
                VStack(alignment: .leading) {
                    VStack (alignment: .center) {
                        HStack {
                            Text("Name:")
                            Text(item.name)
                        }
                        .foregroundStyle(.black)
                        
                        HStack {
                            Text("Birthday:")
                            Text(item.birthday)
                        }
                        .foregroundStyle(.black)
                    }
                    
                    NavigationLink(destination: BirthdayScreen(item: item)) {
                        Text("Show birthday screen")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 239 / 255, green: 123 / 255, blue: 123 / 255, opacity: item.name.isEmpty ? 0.5 : 1))
                        .cornerRadius(10)
                        .disabled(item.name.isEmpty)
                    }
                }
            }
        }
        .frame(width: 350, height: 200)
        .background(Color(red: 248 / 255, green: 248 / 255, blue: 249 / 255, opacity: 0.8))
        .cornerRadius(10)
    }
}

#Preview {
    MainScreenItemCell(item: ChildItem(name: "Itay Algawi", birthDate: Date.now, imageData: nil))
}
