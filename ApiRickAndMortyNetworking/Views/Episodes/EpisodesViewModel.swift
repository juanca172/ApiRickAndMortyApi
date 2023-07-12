//
//  RMEpisodesViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import Foundation


protocol EpisodeViewModelProtocol{
    func start()
    func getNumberOfRows(_ section: Int) -> Int
    func getNumberOfSectios() -> Int
    func getCellViewModel(index: IndexPath) -> EpisodeCellViewModel
    var reloadData: (() -> ())? {get set}
    func updateData()
}

class EpisodesViewModel: EpisodeViewModelProtocol {
    
    private var episodeSections: [[RMEpisode]] = []
    private var page: Int = 1
    private var isChargin = false
    private var dataManager: RMEpisodeDatamangerProtocol
    var reloadData: (() -> ())?
    
    init(dataManager: RMEpisodeDatamangerProtocol = RMEpisodeDataManger(networKProvider: NetworkProvider()) ){
        self.dataManager = dataManager
    }
    
    func loadData(newPage: Int) {
        
        if !isChargin {
            dataManager.getPageEpisode(page: page) {  [weak self] (result:Result<[RMEpisode], Error>) in
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case .success(let success):
                    weakSelf.isChargin = true
                    weakSelf.episodeSections.append(success)
                    weakSelf.reloadData?()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
}

extension EpisodesViewModel {
    
    func updateData() {
        if isChargin == false {
            self.page += 1
            self.isChargin = false
            self.loadData(newPage: self.page)
        } else {
        }
    }
    
    func start() {
        loadData(newPage: page)
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        return episodeSections[section].count
    }
    
    func getNumberOfSectios() -> Int {
        return episodeSections.count
    }
    
    func getCellViewModel(index: IndexPath) -> EpisodeCellViewModel {
        
        let episode = episodeSections[index.section][index.row]
        let viewModel = EpisodeCellViewModel(episode: episode)
        return viewModel
        
    }
}
