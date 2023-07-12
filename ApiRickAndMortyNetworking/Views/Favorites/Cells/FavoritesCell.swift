//
//  FavoritesCellTableViewCell.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 10/07/23.
//

import UIKit

class FavoritesCell: UITableViewCell, RMTableViewCellProtocol {
    
    static var reusedId: String {
        return "favorites"
    }
    
    static var nib: UINib {
        return  UINib(nibName: "FavoritesCell", bundle: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specieLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(viewModel: RMTableViewCellModelProtocol) {
        
        guard var viewModel = viewModel as? FavoritesCellViewModel else {
            return
        }
        
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        specieLabel.text = viewModel.specie
        typeLabel.text = viewModel.type
        viewModel.loadImage = { [weak self] (image) in
            DispatchQueue.main.async {
                self?.characterImage.image = image
            }
        }
    }
    
    
    override func prepareForReuse() {
        nameLabel.text = ""
        statusLabel.text = ""
        specieLabel.text = ""
        typeLabel.text = ""
        characterImage.image = UIImage(systemName: "square")
    }
    
}
