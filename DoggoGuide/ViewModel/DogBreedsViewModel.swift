//
//  DogBreedsViewModel.swift
//  DoggoGuide
//
//  Created by Daniel Puente on 9/27/24.
//


import Combine
import Foundation

class DogBreedsViewModel: ObservableObject {
    @Published var breeds: [String] = []              // Lista de razas obtenida de la API
    @Published var selectedBreedImage: String?        // Imagen de la raza seleccionada
    @Published var errorMessage: String?              // Mensajes de error, si ocurre algún problema
    
    private var cancellables = Set<AnyCancellable>()  // Para almacenar las suscripciones
    private let dogAPIService = DogAPIService()       // Instancia del servicio de red
    
    // Función para cargar la lista de razas
    func loadBreeds() {
        dogAPIService.fetchBreeds()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Error loading breeds: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { breeds in
                self.breeds = breeds
            }
            .store(in: &cancellables)
    }
    
    // Función para cargar una imagen aleatoria de una raza
    func loadBreedImage(for breed: String) {
        dogAPIService.fetchBreedImage(breed: breed)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Error loading breed image: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { imageUrl in
                self.selectedBreedImage = imageUrl
            }
            .store(in: &cancellables)
    }
}
