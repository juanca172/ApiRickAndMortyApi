//
//  ViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 28/06/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let RMCharacterRequest = RMCharacterRoute.getPageCharacter(pageNumber: 0).URLRequestComplete
        let linkEpisodes = ApiRickAndMortyGeneric()
        linkEpisodes.getData(urlRequest: RMCharacterRequest) { (result: Result<DatosCharacter, RMError> )in
            switch result {
                case .success(let valor):
                    print(valor)
                case .failure(let error):
                    print(error)
            }
        }
    }


}

