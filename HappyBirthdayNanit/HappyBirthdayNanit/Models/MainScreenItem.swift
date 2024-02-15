//
//  MainScreenItem.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import Foundation
import SwiftUI


struct MainScreenItem {
    var id: String = UUID().uuidString
    var name: String
    var birthday: String
    var imageUrl: String?
    
    init(name: String, birthday: String, imageUrl: String?) {
        self.name = name
        self.birthday = birthday
        self.imageUrl = imageUrl
    }
    
    var image: Image {
        return Image(imageUrl ?? "Default_place_holder_blue-1")
    }
}

extension MainScreenItem {
    static let mockList: [MainScreenItem] = [
        MainScreenItem(name: "Itay Algawi", birthday: "02/07/2018", imageUrl: nil),
        MainScreenItem(name: "Shay Algawi", birthday: "29/06/2020", imageUrl: nil),
        MainScreenItem(name: "Sivan Algawi", birthday: "02/06/1984", imageUrl: nil),
        MainScreenItem(name: "Shauli Algawi", birthday: "30/05/1984", imageUrl: nil),
        MainScreenItem(name: "", birthday: "29/06/2020", imageUrl: nil)
    ]
}
