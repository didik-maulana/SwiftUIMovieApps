//
//  Movie.swift
//  SwiftUIMovieApps
//
//  Created by Mamikos on 27/06/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let title: String
    let backdopPath: String?
    let posterPath: String?
    let overview: String
    let average: Double
    let voteCount: Int
    let runtime: Int?
}
