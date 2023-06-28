//
//  EpisodeCellViewModel.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import Foundation

struct EpisodeCellViewModel: RMTableViewCellModelProtocol {
    
    private var episodeInst: RMEpisode
    
    init(episode: RMEpisode) {
        self.episodeInst = episode
    }
     var name: String {
        return episodeInst.name
    }
     var airDate: String {
        return episodeInst.air_date
    }
     var episode: String {
        return episodeInst.episode
    }
    
}
