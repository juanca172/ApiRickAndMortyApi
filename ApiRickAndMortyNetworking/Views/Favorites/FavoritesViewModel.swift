//
//  FavoritesViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 10/07/23.
//

import Foundation

protocol FavoritesViewModelProtocol {
    
    var reloadData: (() -> ())? { get set }
    func start()
    func getNumberOfRows() -> Int
    func cellViewModel(indexPath: IndexPath) -> RMTableViewCellModelProtocol
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    
    private var characters: [Character] = []
    private let dataManager: CoreDataManagerProtocol
    var reloadData: (() -> ())?
    
    init(dataManager: CoreDataManagerProtocol = CoreDataManager(coreData: CoreDataStack())) {
        self.dataManager = dataManager
    }
    
    func loadData() {
        dataManager.fetchData { [weak self] (characters) in
            self?.characters = characters
            self?.reloadData?()
        }
    }
}

extension FavoritesViewModel {
    
    func start() {
        loadData()
    }
    
    func getNumberOfRows() -> Int {
        return characters.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> RMTableViewCellModelProtocol {
        let character = characters[indexPath.row]
        let viewModel = FavoritesCellViewModel(character: character)
        return viewModel
    }
    
}
