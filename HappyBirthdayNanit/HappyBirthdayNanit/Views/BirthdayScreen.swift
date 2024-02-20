//
//  BirthdayScreen.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 15/02/2024.
//

import SwiftUI
import PhotosUI
import SwiftData

enum DesignKit: CaseIterable {
    case Elephant
    case Fox
    case Pelican
    
    var bgColor: Color {
        switch self {
        case .Elephant:
            Color(red: 252/255, green: 239/255, blue: 207/255)
        case .Fox:
            Color(red: 204/255, green: 231/255, blue: 223/255)
        case .Pelican:
            Color(red: 222/255, green: 240/255, blue: 245/255)
        }
    }
    
    var bgImage: String {
        switch self {
        case .Elephant:
            "iOS - BG_Elephant"
        case .Fox:
            "iOS - BG_Fox"
        case .Pelican:
            "iOS - BG_Pelican"
        }
    }
    
    var defaultImage: String {
        switch self {
        case .Elephant:
            "Default_Image_Elephant"
        case .Fox:
            "Default_Image_Fox"
        case .Pelican:
            "Default_Image_Pelican"
        }
    }
    
    var cameraIcon: String {
        switch self {
        case .Elephant:
            "Camera_icon_yellow"
        case .Fox:
            "Camera_icon_green"
        case .Pelican:
            "Camera_icon_blue"
        }
    }
    
    static var randomDesign: DesignKit {
        return DesignKit.allCases.randomElement() ?? .Elephant
    }
}


struct BirthdayScreen: View {
    
    @State var designKit: DesignKit = .Pelican
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @State var item: ChildItem
    @State private var selectedItem: PhotosPickerItem?
    @State var image: UIImage?
    @State var displayImageSelectionSourceBottomSheet: Bool = false
    @State private var isImagePickerDisplay = false
    @State private var isProfilePhotoAlertPreseneted = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var sharedImage: Image = Image("")
    var body: some View {
        ZStack {
            ZStack {
                Group {
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
                    }
                    .padding(.top, 50)
                }
                .ignoresSafeArea(.all)
                .frame(maxHeight: .infinity, alignment: .top)
                VStack {
                    Image(uiImage: getProfileImageFrom(item, designKit: designKit))
                        .resizable()
                        .scaledToFill()
                        .frame(width:218, height: 218)
                        .clipShape(Circle())
                        .overlay {
                            Button {
                                displayImageSelectionSourceBottomSheet.toggle()
                            } label: {
                                Image(designKit.cameraIcon)
                            }
                            .offset(CGSize(width: sqrt(109 * 109 / 2), height: -sqrt(109 * 109 / 2)))
                        }
                }
                .foregroundStyle(Color(red:57/255, green: 69/255, blue:98/255))
                .padding(.top, 150)
                .frame(maxHeight: .infinity, alignment: .center)
                Image(designKit.bgImage)
                    .resizable()
                    .allowsHitTesting(false)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
            .background(designKit.bgColor)
            .confirmationDialog("Select your baby's photo", isPresented: $displayImageSelectionSourceBottomSheet) {
                Button("Camera", action: {
                    self.sourceType = .camera
                    isImagePickerDisplay.toggle()
                })
                Button("Library", action: {
                    self.sourceType = .photoLibrary
                    isImagePickerDisplay.toggle()
                })
            } message: {
                Text("Select your baby's photo")
            }
            .sheet(isPresented: $isImagePickerDisplay, content: {
                ImagePickerView(selectedImage: $image, sourceType: self.sourceType)
            })
    
            VStack {
                Image("Nanit logo")
                    .padding(.top, 10)
                    .zIndex(1)
                ShareLink(item: sharedImage, preview: SharePreview("nanit Happy Birthday Celebration", image: sharedImage)) {
                    HStack {
                        Text("Share the news")
                            .font(.custom("BentonSans Cond Regular", size: 16).weight(.medium))
                            .padding(.all, 10)
                        Image("ic_share_pink_small")
                            .offset(CGSize(width: -10, height: 0))
                    }
                    .foregroundColor(.white)
                    .background(Color(red: 239 / 255, green: 123 / 255, blue: 123 / 255, opacity: item.name.isEmpty ? 0.5 : 1))
                    .cornerRadius(21)
                    .frame(width: 179, height: 42)
                    .padding()
                }
            }
            .padding(.bottom, 80)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if self.image != nil {
                        self.isProfilePhotoAlertPreseneted = true
                    } else {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image("back_button_blue")
                }
            }
        }
        .onAppear {
            designKit = DesignKit.randomDesign
            sharedImage = SharedBirthdayView(item: item, designKit: designKit).snapshot()
        }
        .alert("Profile Photo Updated", isPresented: $isProfilePhotoAlertPreseneted) {
            Button("Save") {
                do {
                    item.imageData = self.image?.heicData()
                    try context.save()
                    self.presentationMode.wrappedValue.dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            }
            Button("Cancel", role: .cancel) {
                self.presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("The profile photo has been updated, would you like to save the change?")
        }

    }
    
    private func getProfileImageFrom(_ item: ChildItem, designKit: DesignKit) -> UIImage {
        
        if let image = self.image {
            return image
        }
        
        if let data = item.imageData,
           let uiImage = UIImage(data: data) {
            return uiImage
        }
        
        return UIImage(named: designKit.defaultImage) ?? UIImage()
    }
}

#Preview {
    BirthdayScreen(item: ChildItem(name: "Itey Algawi", birthDate: Date.now, imageData: nil))
}
