//
//  DogBreedsResponse.swift
//  DoggoGuide
//
//  Created by Daniel Puente on 9/7/24.
//
import Foundation

// Modelo para la lista de razas
struct DogBreedsResponse: Codable {
    let message: [String: [String]]
    let status: String
}


// Modelo para la imagen de una raza
struct BreedImage: Codable {
    let message: String  // URL de la imagen de la raza
    let status: String
}
