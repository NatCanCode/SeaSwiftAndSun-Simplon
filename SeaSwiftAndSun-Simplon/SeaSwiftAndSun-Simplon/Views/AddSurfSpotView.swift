//
//  AddSurfSpotView.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Esteban SEMELLIER on 14/12/2023.
//

import SwiftUI

struct AddSurfSpotView: View {
    
    // MARK: - Injected properties
    @StateObject var viewModel = AddSurfSpotViewModel()
    
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    
    var body: some View {
        VStack {
            AddSurfSpotForm(viewModel: viewModel, showingImagePicker: $showingImagePicker, showingCamera: $showingCamera, inputImage: $inputImage, image: $image)
            
            Button {
                viewModel.postData()
            } label: {
                Text("Add")
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        Color.black
                            .cornerRadius(15)
                    }
            }
            
        }
        .sheet(isPresented: $showingCamera) {
            CameraView(image: self.$inputImage)
        }
        
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage, sourceType: .photoLibrary)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct AddSurfSpotView_Previews: PreviewProvider {
    static var previews: some View {
        AddSurfSpotView()
    }
}
