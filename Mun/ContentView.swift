//
//  ContentView.swift
//  Mun
//
//  Created by Tomás García Gobet on 15.09.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NearbyView()
        }
    }
}

#Preview {
    ContentView()
}
