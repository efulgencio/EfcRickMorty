//
//  LoadingView.swift
//  EfcRickMorty
//
//  Created by efulgencio on 20/4/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                Text("Cargando ....")
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    LoadingView()
}
