//
//  RmTableViewCellProtocol.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 9/02/23.
//

import Foundation
import UIKit

protocol RMTableViewCellProtocol: UITableViewCell {
     
    static var reusedId: String { get }
    static var nib: UINib { get }
    
    func setUp(viewModel: RMTableViewCellModelProtocol)
}

extension RMTableViewCellProtocol {
    static func regiterCellInTableView(tableView: UITableView) {
        tableView.register(self.nib, forCellReuseIdentifier: self.reusedId)
    }
}

protocol RMTableViewCellModelProtocol {
    
}
