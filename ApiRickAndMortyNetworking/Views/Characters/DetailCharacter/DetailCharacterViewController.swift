//
//  DetailCharacterViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 8/06/23.
//

import UIKit
import CoreData

final class DetailCharacterViewController: UIViewController {
  
    
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var CharacterImage: UIImageView!
    private var viewModel: DetailViewModelProtocol?
    var idToSearch: Int!
    private var characterGet: RMCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel()
        searchCharacter()
        viewModel?.characterById = { [weak self] (update) in
            DispatchQueue.main.async {
                self?.characterGet = update
                self?.updateUI(to: update)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("Murio")
    }
    
    
    func searchCharacter() {
        viewModel?.getCharacterForDetail(id: idToSearch)
    }
    
    // MARK: - Actions
    @IBAction func close() {
      dismiss(animated: true, completion: nil)
    }
    
    //MARK: CoreData
    @IBAction func saveData() {
        viewModel?.saveContext()
    }
    
    func updateUI(to: RMCharacter) {
        characterGet = to
        nameLabel.text = to.name
        statusLabel.text = to.status.rawValue
        typeLabel.text = to.type
        speciesLabel.text = to.species
        guard let url = URL(string: to.image) else {
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.CharacterImage.image = image
            }

        }
        
    }

}
