//
//  AddSurfSpotForm.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Esteban SEMELLIER on 14/12/2023.
//

import SwiftUI

struct AddSurfSpotForm: View {
    // MARK: - Injected properties
    @ObservedObject var viewModel: AddSurfSpotViewModel
    
    // MARK: - Variables
    @State var influencer: String = ""
    @State var traveller: String = ""
    @Binding var showingImagePicker: Bool
    @Binding var showingCamera: Bool
    @Binding var inputImage: UIImage?
    @Binding var image: Image?
    @State var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    // Action
                    showPopUp = true
                } label: {
                    if image == nil {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .overlay {
                                Text("Photo")
                                    .foregroundColor(.white)
                            }
                    } else {
                        image!
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                    }
                }
                .padding(.top, 50)
                
                Form {
                    Section(header: Text("Surf Spot Details").font(.headline)) {
                        TextField("Destination", text: $viewModel.surfSpot.destination)
                        TextField("State/Country", text: $viewModel.surfSpot.destinationStateCountry)
                        // TODO: - Picker difficulty level
                        TextField("Surf break", text: $viewModel.surfBreak)
//                        TextField("Peak surf season begin", text: $viewModel.surfSpot.peakSurfSeasonBegins)
//                        TextField("Peak surf season end", text: $viewModel.surfSpot.peakSurfSeasonEnds)
//                        TextField("Magic Seaweed link", text: Binding(
//                            get: { viewModel.surfSpot.magicSeaweedLink ?? "" },
//                            set: { viewModel.surfSpot.magicSeaweedLink = $0 }
//                        ))
                    }
                    
                    Section(header: Text("Influencers").font(.headline)) {
                        HStack {
                            TextField("influencers", text: $influencer)
                            Button {
                                // Add infuencer to array
                                if influencer != "" {
                                    viewModel.influencers.append(influencer)
                                    influencer = ""
                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                        ForEach(viewModel.influencers, id: \.self) { influencer in
                            if influencer != "" {
                                Text(influencer)
                            }
                        }
                    }
                    
                    Section(header: Text("Travellers").font(.headline)) {
                        HStack {
                            TextField("Travellers", text: $traveller)
                            Button {
                                if traveller != "" {
                                    // Add traveller to array
                                    viewModel.travellers.append(traveller)
                                    traveller = ""
                                }
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                        ForEach(viewModel.travellers, id: \.self) { traveller in
                            if traveller != "" {
                                Text(traveller)
                            }
                        }
                    }
                    // TODO: - Add influencers & Travellers
                }
            }
            VStack {
                ZStack {
                    if showPopUp {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.accentColor)
                            .frame(width: 100, height: 50)
                        
                        HStack {
                            Button {
                                self.showingCamera = true
                                self.showPopUp = false
                            } label: {
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 15)
                            
                            Button {
                                self.showingImagePicker = true
                                self.showPopUp = false
                            } label: {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 15)
                        }
                    }
                }
                
                Spacer()
            }
            
        }
    }
}

struct AddSurfSpotForm_Previews: PreviewProvider {
    static var previews: some View {
        AddSurfSpotForm(viewModel: AddSurfSpotViewModel(), showingImagePicker: .constant(false), showingCamera: .constant(false), inputImage: .constant(UIImage(named: "")), image: .constant(Image("")))
    }
}
