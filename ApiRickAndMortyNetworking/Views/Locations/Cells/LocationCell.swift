//
//  LocationCellTableViewCell.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 5/06/23.
//

import UIKit

class LocationCell: UITableViewCell, RMTableViewCellProtocol {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    
    
    static var reusedId: String {
        return "LocationReusedId"
    }
    
    static var nib: UINib {
        return UINib(nibName: "LocationCell", bundle: nil)
    }
    
    func setUp(viewModel: RMTableViewCellModelProtocol) {
        guard let viewModel = viewModel as? LocationCellViewModel else {
            return 
        }
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimensionLabel.text = viewModel.dimension
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        typeLabel.text = ""
        dimensionLabel.text = ""
    }
}
