//
//  MainScreenItem.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import Foundation
import SwiftUI
import SwiftData


@Model class ChildItem {
    var name: String
    var imageData: Data?
    var birthDate: Date
    @Attribute(.unique) var uuid: UUID
    
    init(name: String, birthDate: Date, imageData: Data? = nil) {
        self.name = name
        self.birthDate = birthDate
        self.uuid = UUID()
    }
    
    var image: Image {
        if let data = imageData,
           let profileImage = UIImage(data: data) {
            return Image(uiImage: profileImage)
        }
        return Image("Default_place_holder_blue-1")
    }
    
    var age: String {
        let dateDiffs = getDateDiffs()
        if let year = dateDiffs.year,
           year > 0 {
            return "\(year)"
        }
        if let month = dateDiffs.month,
           month > 0 {
            return "\(month)"
        }
        
        return "0"
    }
    
    var isAgeInYears: Bool {
        let diffs = getDateDiffs()
        if let year = diffs.year, year > 0 {
            return true
        }
        
        return false
    }
    
    var birthday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: birthDate)
    }
    
    private func getDateDiffs() -> DateComponents {
        let diffs = Calendar.current.dateComponents([.year, .month], from: birthDate, to: Date())
        return diffs

    }
}

