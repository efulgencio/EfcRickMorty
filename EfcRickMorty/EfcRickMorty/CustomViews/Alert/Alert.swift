//
//  Alert.swift
//  EFCoinCap
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let errorAPI = AlertItem(title: Text("Error"), message: Text("EfcRickMorty ERROR"), dismissButton: .default(Text("Accept")))
}
