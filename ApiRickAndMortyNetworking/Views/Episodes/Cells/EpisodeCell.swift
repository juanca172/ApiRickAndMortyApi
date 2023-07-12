//
//  EpisodeCell.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/06/23.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var airDate_Value: UILabel!
    @IBOutlet weak var EpisodeValue: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        nameValue.text = ""
        airDate_Value.text = ""
        EpisodeValue.text = ""
    }
    
}

extension EpisodeCell: RMTableViewCellProtocol {
    static var reusedId: String {
        return "EpisodeCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: "EpisodeCell", bundle: nil)
    }
    
    func setUp(viewModel: RMTableViewCellModelProtocol) {
        if let episodeViewModel = viewModel as? EpisodeCellViewModel {
            nameValue.text = episodeViewModel.name
            airDate_Value.text = episodeViewModel.airDate
            EpisodeValue.text = episodeViewModel.episode
        }
    }
    
    
}
