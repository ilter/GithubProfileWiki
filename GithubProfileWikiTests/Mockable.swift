//
//  Mockable.swift
//  GithubProfileWikiTests
//
//  Created by ilter on 2.03.2022.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedObject = try jsonDecoder.decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
