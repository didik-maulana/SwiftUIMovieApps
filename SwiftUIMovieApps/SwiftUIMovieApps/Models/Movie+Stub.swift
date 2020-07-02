//
//  Movie+Stub.swift
//  SwiftUIMovieApps
//
//  Created by Didik on 02/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = Bundle.main.loadDecodedJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        return stubbedMovies[0]
    }
    
}

extension Bundle {
    
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
    
    func loadDecodedJSON<D: Decodable>(filename: String) -> D? {
        var result: D?
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        if let data = try? Data(contentsOf: url) {
            let jsondecoder = Utils.jsonDecoder
            do {
                result = try jsondecoder.decode(D.self, from: data)
            } catch {
                print("error trying parse json")
            }
        }
        return result
    }
}
