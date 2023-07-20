//
//  Utils.swift
//  Homefay
//
//  Created by Agung Saputra on 20/07/23.
//

import Foundation

func generateRandomString(length: Int, includeLoweCase: Bool = true) -> String {
    var characters  = ""
    if includeLoweCase {
        characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    } else {
        characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    }
    
    let randomString = (0..<length).map { _ in
        characters.randomElement()!
    }
    return String(randomString)
}
