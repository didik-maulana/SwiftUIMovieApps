//
//  MovieDetailState.swift
//  SwiftUIMovieApps
//
//  Created by Didik on 02/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

class MovieDetailState: ObservableObject {
    
    private var movieService: MovieService
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        self.movie = nil
        self.isLoading = true
        self.movieService.fetchMovie(id: id) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}

