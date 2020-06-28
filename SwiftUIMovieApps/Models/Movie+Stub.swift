//
//  Movie+Stack.swift
//  SwiftUIMovieApps
//
//  Created by Mamikos on 27/06/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponse? = Bundle.main.loadDecodedJSON(filename: "movie_list")
        return response!.results
    }
    
    static var stubbedMovie: Movie {
        return Movie(
            id: 338762,
            title: "Bloodshot",
            backdopPath: "/ocUrMYbdjknu2TwzMHKT9PBBQRw.jpg",
            posterPath: "/8WUVHemHFH2ZIP6NWkwlHWsyrEL.jpg",
            overview: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'. As Ray first trains with fellow super-soldiers, he cannot recall anything from his former life. But when his memories flood back and he remembers the man that killed both him and his wife, he breaks out of the facility to get revenge, only to discover that there's more to the conspiracy than he thought.",
            voteAverage: 7.1,
            voteCount: 2324,
            runtime: 0
        )
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
