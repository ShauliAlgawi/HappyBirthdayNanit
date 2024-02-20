//
//  SharedBirthdayView.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 19/02/2024.
//

import SwiftUI

struct SharedBirthdayView: View {
    
    /// State Varibable
    @State var item: ChildItem
   
    var designKit: DesignKit = .Pelican
    
    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    Text("Today \(item.name) is".uppercased())
                        .font(.custom("BentonSans Cond Regular", size: 21))
                        .frame(width: 226, height: 58)
                        .multilineTextAlignment(.center)
                    HStack {
                        Image("Left swirls")
                        Image(item.age)
                            .padding(.horizontal, 22)
                        Image("Right swirls")
                        
                    }
                    .padding(.top, 13)
                    .padding(.bottom, 14)
                    
                    Text(item.isAgeInYears ? "YEARS OLD!" : "MONTH OLD!")
                        .font(.custom("BentonSans Cond Regular", size: 21))
                        .padding(.bottom, 60)
                    
                    if let imageData = item.imageData,
                    let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width:218, height: 218)
                            .clipShape(Circle())
                    }
                }
                .foregroundStyle(Color(red:57/255, green: 69/255, blue:98/255))
                .padding(.bottom, 150)
                Image(designKit.bgImage)
                    .resizable()
                    .allowsHitTesting(false)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
            .background(designKit.bgColor)
            
        
    
            VStack {
                Image("Nanit logo")
                    .padding(.top, 10)
                    .zIndex(1)
            }
            .padding(.bottom, 80)
            .frame(maxHeight: .infinity, alignment: .bottom)
            
        }
    }
    
    @MainActor func snapshot() -> Image {
        let imagerenderer = ImageRenderer(
            content: self)
        return Image(uiImage: imagerenderer.uiImage!)
    }
}

#Preview {
    SharedBirthdayView(item: ChildItem(name: "Itay", birthDate: Date.now, imageData: nil))
}
