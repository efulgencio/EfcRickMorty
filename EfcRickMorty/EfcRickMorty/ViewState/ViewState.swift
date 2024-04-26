//
//  ViewState.swift
//  EfcRickMorty
//
//  Created by efulgencio on 18/4/24.
//

import Foundation

enum ViewModelState {
    case loadingView
    case loadedView
    case filteredView
    case errorView(errorMessage:String)
}
