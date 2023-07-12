//
//  CharacterCell.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 19/04/23.
//

import UIKit

class CharacterCell: UITableViewCell, RMTableViewCellProtocol {
    static var reusedId: String {
            return "CharacterViewCell"
        }
        
        static var nib: UINib {
            return UINib(nibName: "CharacterCell", bundle: nil)
        }
    
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var specie : UILabel!
    @IBOutlet weak var type : UILabel!
    @IBOutlet weak var imageCharacter : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(viewModel: RMTableViewCellModelProtocol) {
            guard var viewModel = viewModel as? CharacterViewCellViewModel else {
                return
            }
            name.text = viewModel.name
            specie.text = viewModel.specie
            type.text = viewModel.type
            viewModel.loadImage = { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.imageCharacter.image = image
                }
            }
        }
        
        override func prepareForReuse() {
            name.text = ""
            specie.text = ""
            type.text = ""
            imageCharacter.image = UIImage(systemName: "square")
        }
    
}
