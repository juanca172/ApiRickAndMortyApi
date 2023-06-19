//
//  DetailCharacterViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 8/06/23.
//

import UIKit
import CoreData

final class DetailCharacterViewController: UIViewController {

    @IBOutlet private weak var pop_upView: UIView!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var CharacterImage: UIImageView!
    var managedObjectContext: NSManagedObjectContext!
    private var viewModel: CharacterViewModelProtocol?
    var idToSearch : Int!
    private var characterGet: RMCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersViewModel()
        searchCharacter()
        viewModel?.characterById = { [weak self] (update) in
            DispatchQueue.main.async {
                self?.updateUI(to: update)
            }
        }
        // Do any additional setup after loading the view.
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

        let characterToSave = Character(context: managedObjectContext)
        characterToSave.characterName = nameLabel.text
        characterToSave.characterSpecie = speciesLabel.text
        characterToSave.characterStatus = statusLabel.text
        characterToSave.characterType = typeLabel.text
        characterToSave.characterImage = characterGet?.image
        
        do {
            try managedObjectContext.save()
            dismiss(animated: true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateUI(to: RMCharacter) {
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
