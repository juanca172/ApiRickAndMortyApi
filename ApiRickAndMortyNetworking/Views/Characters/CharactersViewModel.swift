//
//  CharactersViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 4/02/23.
//

import Foundation
import UIKit

protocol CharacterViewModelProtocol: AnyObject {
    
    func start()
    func getNumberOfSections() -> Int
    func getNumberOfRows(_ section: Int) -> Int
    func getCellViewModel(indexPath: IndexPath) -> RMTableViewCellModelProtocol
    func updateData()
    func updateFilterData(search name: String)
    func getId(indexPath: IndexPath) -> Int
    var reloadData: (() -> ())? { get set }
    func vaciarFiltro()
    var characterById: (( _ characterUI: RMCharacter) -> ())? {get set}
}


final class CharactersViewModel: CharacterViewModelProtocol {
    
    var characterById: ((RMCharacter) -> ())?
        
    private var characterSections : [[RMCharacter]] = []
    private var filteredData : [[RMCharacter]] = []
    private var page = 1
    private var isPaginating = false
    private let dataManager: RMCharacterDatamanager
    private var characterObtained: RMCharacter?
    
    var reloadData: (() -> ())?
    
    init(dataManager: RMCharacterDatamanager = RMDefaultCharacterDataManager(networkProvider: NetworkProvider())) {
        self.dataManager = dataManager
    }
    
    func loadData(page: Int) {
        if isPaginating == false {
            dataManager.getCharacterByPage(pageNumber: page) {[weak self] (result: Result<[RMCharacter], Error>) in
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case .success(let page):
                    weakSelf.isPaginating = true
                    weakSelf.characterSections.append(page)
                    weakSelf.reloadData?()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func filterCharacter(for name: String) {
        filteredData  = []
        let filter = RMNameCharacter(name: name)
        dataManager.filterParams(filter: [filter]) {[weak self] (result: Result<[RMCharacter], Error>) in
            guard let weakSelf = self else {
                return
            }
            switch result {
            case .success(let characters):
                weakSelf.filteredData.append(characters)
                weakSelf.reloadData?()
                print(weakSelf.filteredData.count)

            case.failure(let error):
                print(error)
            }
        }
    }

    
}

//MARK: Conformacion protocolos
extension CharactersViewModel {
    
    func vaciarFiltro() {
        self.filteredData = []
    }
    func updateData() {
        if self.isPaginating == true {
            self.page += 1
            self.isPaginating = false
            self.loadData(page: self.page)
        } else {
            print("paginando")
        }
    }
    
    
    func updateFilterData(search name: String) {
        self.filterCharacter(for: name)
    }
    
    func start() {
        loadData(page: page)
    }
    
    func getNumberOfSections() -> Int {
        if filteredData.count != 0 {
            return self.filteredData.count
        } else {
            return self.characterSections.count
        }
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        if filteredData.count != 0 {
            return self.filteredData[section].count
        } else {
            return self.characterSections[section].count
        }
    }
    
    func getCellViewModel(indexPath: IndexPath) -> RMTableViewCellModelProtocol {
        if filteredData.count != 0 {
            let character = filteredData[indexPath.section][indexPath.row]
            let viewModel = CharacterViewCellViewModel(character: character)
            return viewModel
            
        } else {
            let character = characterSections[indexPath.section][indexPath.row]
            let viewModel = CharacterViewCellViewModel(character: character)
            return viewModel
        }
    }
    
    func getId(indexPath: IndexPath) -> Int {
        if filteredData.count != 0 {
            return filteredData[indexPath.section][indexPath.row].id
        } else {
            return characterSections[indexPath.section][indexPath.row].id
        }
    }
}
