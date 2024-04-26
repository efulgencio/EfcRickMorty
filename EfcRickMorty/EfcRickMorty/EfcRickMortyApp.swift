//
//  EfcRickMortyApp.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import SwiftUI

@main
struct EfcRickMortyApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
