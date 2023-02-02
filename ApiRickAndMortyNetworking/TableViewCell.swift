//
//  TableViewCell.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 27/12/22.
//

import UIKit

class TableViewCell: UITableViewCell {
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
    
}
