//
//  MainScreenItemCell.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import SwiftUI

struct MainScreenItemCell: View {
    @State var item: MainScreenItem
    var body: some View {
        VStack {
            HStack {
                CircleImage(image: item.image)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Name:")
                        Text(item.name)
                    }
                    .foregroundStyle(.white)
                    HStack {
                        Text("Birthday:")
                        Text(item.birthday)
                    }
                    .foregroundStyle(.white)
                    Button {
                        print("Display birthday screen")
                    } label: {
                         Text("Show birthday screen")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 239 / 255, green: 123 / 255, blue: 123 / 255, opacity: item.name.isEmpty ? 0.5 : 1))
                    .cornerRadius(10)
                    .disabled(item.name.isEmpty)
                }
            }
        }
        .frame(width: 350, height: 200)
        .background(Color(red: 111 / 255, green: 197 / 255, blue: 175 / 255, opacity: 0.8))
        .cornerRadius(10)
    }
}

#Preview {
    MainScreenItemCell(item: MainScreenItem(name: "Itay Algawi", birthday: "02/072018", imageUrl: "Default_place_holder_blue-1"))
}
