//
//  AddUpdateChildView.swift
//  HappyBirthdayNanit
//
//  Created by Shauli Algawi on 18/02/2024.
//

import SwiftUI
import SwiftData

struct AddUpdateChildView: View, PhotoDisplable {
    
    ///Environment variables
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    @State var childItem: ChildItem = ChildItem(name: "", birthDate: Date.now)
    
    /// State variables
    @State private var isImagePickerDisplay = false
    @State private var image: UIImage?
    @State private var displayImageSelectionSourceBottomSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var name: String = ""
    @State var onUpdateMode: Bool = false
    @State private var birthDate = Date.now
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .focused($keyboardFocused)
            
            DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                            Text("Birthday")
                        }
            .focused($keyboardFocused)
            
            
            VStack {
                Text("Profile Image")
                Image(uiImage: getProfileImageFrom(childItem, designKit: nil, image: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .onTapGesture {
                        displayImageSelectionSourceBottomSheet.toggle()
                    }
            }
            Button(onUpdateMode ? "Update" : "Save") {
                childItem.name = name
                childItem.birthDate = birthDate
                if let imageData = self.image?.heicData() {
                    childItem.imageData = imageData
                }
                if !onUpdateMode {
                    context.insert(childItem)
                }
                
                do {
                    try context.save()
                    self.presentationMode.wrappedValue.dismiss()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .disabled(!isValidForm())
            .opacity(isValidForm() ? 1 : 0.5)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(action: {
                    keyboardFocused = false
                }, label: {
                    Text("Done")
                })
            }
        }
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
        .onAppear {
            onUpdateMode = !childItem.name.isEmpty 
            name = childItem.name
            birthDate = childItem.birthDate
        }
    }
    
    private func isValidForm() -> Bool {
        return !name.isEmpty
    }
    
    private func getProfileImageFrom(_ item: ChildItem) -> UIImage {
        
        if let image = self.image {
            return image
        }
        
        if let data = item.imageData,
           let uiImage = UIImage(data: data) {
            return uiImage
        }
        
        return self.image ?? UIImage()
    }
}

#Preview {
    AddUpdateChildView()
}
