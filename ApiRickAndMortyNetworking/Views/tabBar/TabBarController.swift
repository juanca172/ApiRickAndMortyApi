//
//  TabBarControllerViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 17/06/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                      title: String,
                                                      image: UIImage) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            navController.navigationBar.prefersLargeTitles = true
            rootViewController.navigationItem.title = title
            return navController
        }
    
    func setupVCs() {
            setViewControllers([createNavController(for: CharactersViewController(), title: "character", image: UIImage(systemName: "person")!),createNavController(for: LocationsViewController(), title: "Second", image: UIImage(systemName: "location")!)], animated: true)
        }

}
