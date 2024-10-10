//
//  ContentView.swift
//  DoggoGuide
//
//  Created by Daniel Puente on 9/7/24.
//

import SwiftUI

struct DogBreedsView: View {
    @StateObject private var viewModel = DogBreedsViewModel()  // Instanciamos el ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Mostrar un mensaje de error si ocurre alguno
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    // Mostrar la lista de razas
                    List(viewModel.breeds, id: \.self) { breed in
                        Button(action: {
                            viewModel.loadBreedImage(for: breed)  // Cargar imagen al seleccionar raza
                        }) {
                            Text(breed.capitalized)  // Mostrar el nombre de la raza
                        }
                    }
                }
                
                // Mostrar la imagen de la raza seleccionada
                if let selectedImageUrl = viewModel.selectedBreedImage {
                    AsyncImage(url: URL(string: selectedImageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .cornerRadius(80)
                        case .failure:
                            Image(systemName: "xmark.octagon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .cornerRadius(80)

                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
            .navigationTitle("Dog Breeds")
            .onAppear {
                viewModel.loadBreeds()  
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        DogBreedsView()
    }
}
