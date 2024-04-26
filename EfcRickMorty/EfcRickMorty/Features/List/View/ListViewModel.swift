//
//  ListViewModel.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import Foundation
import Combine

final class ListViewModel: ObservableObject {
    
    @Published var viewModelState: ViewModelState = ViewModelState.loadingView
    @Published var alertItem: AlertItem?
    @Published var searchText: String = ""
    @Published var clearSearchText: Bool = false
    
    private var listUseCase: ListUseCase
    private var task: Cancellable?
    private var cancellables = Set<AnyCancellable>()
    
    var characters: ListModel? = nil
    var charactersFiltered: ListModel? = nil
    var numberPage = 0
    var numberPagesForNavigate = 0

    init(listUseCase: ListUseCase = .live) {
        self.listUseCase = listUseCase
        addSubscriberForComponents()
        getList()
    }
    
    
    private func addSubscriberForComponents() {
        $clearSearchText
            .sink { [weak self] (clearSearch) in
                if clearSearch {
                    self?.getList()
                }
            }
            .store(in: &cancellables)
    }
    
    
    func getList() {
        self.numberPage = 0 // es una búsqueda no paginacion
        task = listUseCase.getList(searchText).sink(
            receiveCompletion: { completion in
                self.handleCompletion(completion: completion)
            },
            receiveValue: { [weak self] response in
                if self?.numberPagesForNavigate == 0 {
                    self?.numberPagesForNavigate = response.numberPages
                }
                DispatchQueue.main.async {
                    self?.characters = response
                    self?.charactersFiltered = response
                    self?.viewModelState = ViewModelState.loadedView
                }
            })
    }
    
    func getListByPage(page: String) {
        self.numberPage = Int(page) ?? 1
        task = listUseCase.getListByPage(page).sink(
            receiveCompletion: { completion in
                self.handleCompletion(completion: completion)
            },
            receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.characters = response
                    self?.charactersFiltered = response
                    self?.viewModelState = ViewModelState.loadedView
                }
            })
    }
    
    private func handleCompletion(completion: Subscribers.Completion<NetworkError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            DispatchQueue.main.async {
                self.alertItem = AlertContext.errorAPI
            }
            print(error.localizedDescription)
        }
    }
}
