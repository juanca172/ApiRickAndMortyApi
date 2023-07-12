//
//  LocationViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 5/06/23.
//

import Foundation

protocol LocationViewModelProtocol: AnyObject {
    func start()
    func getNumberOfSections() -> Int
    func getNumberOfRows(_ section: Int) -> Int
    func getCellViewModel(indexPath: IndexPath) -> RMTableViewCellModelProtocol
    //func updateData()

    var reloadData: (() -> ())? { get set }
}

final class LocationViewModel {
    private var locationSections : [[RMLocation]] = []
    private var page = 7
    private var isCharging = false
    private let dataManager: RMLocationDataManagerProtocol
    
    var reloadData: (() -> ())?
    
    init(dataManager: RMLocationDataManagerProtocol = RMDefaultDataManagerLocation(networKProvider: NetworkProvider())) {
        self.dataManager = dataManager
    }
    
    func loadData(newPage: Int) {
        if isCharging == false {
            dataManager.getPageLocation(page: page) { [weak self] (result:Result<[RMLocation], Error>) in
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case .success(let locations):
                    weakSelf.isCharging = true
                    weakSelf.locationSections.append(locations)
                    print(locations)
                    weakSelf.reloadData?()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

//MARK: -DataMethods
extension LocationViewModel: LocationViewModelProtocol {
    
    /*func updateData() {
        if self.isCharging == false {
            self.page += 1
            self.isCharging = false
            self.loadData(newPage: self.page)
        } else {
            print("paginando")
        }
    }*/
    
    func start() {
        loadData(newPage: self.page)
    }
    
    func getNumberOfSections() -> Int {
        return self.locationSections.count
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        return self.locationSections[section].count
    }
    
    func getCellViewModel(indexPath: IndexPath) -> RMTableViewCellModelProtocol {
        let location = self.locationSections[indexPath.section][indexPath.row]
        let viewModel = LocationCellViewModel(location: location)
        return viewModel
    }
    
    
}
