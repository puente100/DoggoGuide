//
//  DogAPIService.swift
//  DoggoGuide
//
//  Created by Daniel Puente on 9/27/24.
//

import Alamofire
import Combine
import Foundation

class DogAPIService {
    // URL base para la API de perros
    private let baseURL = "https://dog.ceo/api"
    
    // Función para obtener la lista de todas las razas
    func fetchBreeds() -> AnyPublisher<[String], Error> {
        let url = "\(baseURL)/breeds/list/all"
        
        // Utilizamos Future para convertir el resultado en un Publisher
        return Future<[String], Error> { promise in
            // Realizamos la solicitud usando Alamofire
            AF.request(url).responseDecodable(of: DogBreedsResponse.self) { response in
                switch response.result {
                case .success(let breedsResponse):
                    // Extraemos las razas del mensaje y las pasamos al publisher
                    let breeds = breedsResponse.message.keys.map { $0 }
                    promise(.success(breeds))
                case .failure(let error):
                    // En caso de error, devolvemos el error
                    promise(.failure(error))
                }
            }
        }
        // Esto asegura que los resultados se reciban en el hilo principal (UI)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    // Función para obtener una imagen aleatoria de una raza
    func fetchBreedImage(breed: String) -> AnyPublisher<String, Error> {
        let url = "\(baseURL)/breed/\(breed)/images/random"
        
        // Similar al anterior, usamos Future para convertir el resultado en un Publisher
        return Future<String, Error> { promise in
            // Realizamos la solicitud con Alamofire
            AF.request(url).responseDecodable(of: BreedImage.self) { response in
                switch response.result {
                case .success(let breedImage):
                    // Devolvemos la URL de la imagen como parte del publisher
                    promise(.success(breedImage.message))
                case .failure(let error):
                    // En caso de error, lo pasamos al publisher
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
