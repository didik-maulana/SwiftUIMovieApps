//
//  MovieDetailView.swift
//  SwiftUIMovieApps
//
//  Created by Didik on 03/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: movieDetailState.isLoading, error: movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if self.movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    private let imageLoader = ImageLoader()
    @State private var selectedTrailer: MovieVideo?
    
    var body: some View {
        List {
            if self.movie.backdropURL != nil {
                MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.backdropURL!)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            
            HStack {
                Text(movie.genreText)
                Text("•")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            Text(movie.overview)
            
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText)
                        .foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
            Divider()
            
            MovieDetailCreditsView(movie: movie)
            
            if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                Text("Trailers")
                    .font(.headline)
                ForEach(movie.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }.sheet(item: self.$selectedTrailer) { trailer in
            if trailer.youtubeURL != nil {
                SafariView(url: trailer.youtubeURL!)
            }
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetailCreditsView: View {
    
    let movie: Movie
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 4) {
                if movie.cast != nil {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring")
                            .font(.headline)
                        ForEach(movie.cast!.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Director(s)")
                                .font(.headline)
                            ForEach(movie.directors!.prefix(2)) { director in
                                Text(director.name)
                            }
                        }
                        
                        if movie.producers != nil && movie.producers!.count > 0 {
                            Text("Producer(s)")
                                .font(.headline)
                                .padding(.top)
                            ForEach(movie.producers!.prefix(2)) { producer in
                                Text(producer.name)
                            }
                        }
                        
                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            Text("Screen Writer(s)")
                                .font(.headline)
                                .padding(.top)
                            ForEach(movie.screenWriters!.prefix(2)) { screenWriter in
                                Text(screenWriter.name)
                            }
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Divider()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieId: Movie.stubbedMovie.id)
    }
}
