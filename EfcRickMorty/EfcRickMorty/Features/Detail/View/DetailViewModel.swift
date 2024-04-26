//
//  DetailViewModel.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var viewModelState: ViewModelState = ViewModelState.loadingView
    var character: DetailModel = DetailModel()
    
    @Published var alertItem: AlertItem?
    
    private var detailUseCase: DetailUseCase
    private var task: Cancellable?
    
    init(detailUseCase: DetailUseCase = .live) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetail(id: Int) {
        task = detailUseCase.getCharacter(id).sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure( _):
                    DispatchQueue.main.async {
                        self.alertItem = AlertContext.errorAPI
                    }
                }
            },
            receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.character.data = response.data
                    self?.viewModelState = ViewModelState.loadedView
                }
            })
    }
}
