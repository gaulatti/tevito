//
//  HomeView.swift
//  tevito
//
//  Created by Javier Godoy Núñez on 2/27/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home")
            NavigationLink("Go Deeper") {
                Text("Deeper Content")
            }
        }
    }
}

#Preview {
    HomeView()
}
