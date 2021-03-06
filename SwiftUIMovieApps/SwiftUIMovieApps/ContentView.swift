//
//  ContentView.swift
//  SwiftUIMovieApps
//
//  Created by Didik on 02/07/20.
//  Copyright © 2020 Codingtive. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieListView().tabItem {
                VStack {
                    Image(systemName: "tv")
                    Text("Movies")
                }
            }.tag(0)
            MovieSearchView().tabItem {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
