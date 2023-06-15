//
//  DetailCharacterViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 8/06/23.
//

import UIKit
import CoreData

class DetailCharacterViewController: UIViewController {

    @IBOutlet weak var pop_upView: UIView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var CharacterImage: UIImageView!
    var managedObjectContext: NSManagedObjectContext!

    
    var character: RMCharacter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if character != nil {
            updateUI()
            
        }

        // Do any additional setup after loading the view.
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
        characterToSave.characterImage = character.image
        
        do {
            try managedObjectContext.save()
            dismiss(animated: true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func updateUI() {
        nameLabel.text = character.name
        statusLabel.text = character.status.rawValue
        typeLabel.text = character.type
        speciesLabel.text = character.species
        guard let url = URL(string: character.image) else {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
