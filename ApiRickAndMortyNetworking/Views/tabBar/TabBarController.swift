//
//  TabBarControllerViewController.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 17/06/23.
//

import UIKit

final class RMNavigationController: UINavigationController {
    
    init(for viewController: UIViewController, tabBar item: UITabBarItem) {
        super.init(rootViewController: viewController)
        tabBarItem = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        // Do any additional setup after loading the view.
    }
   
    func setupVCs() {
        
        let charactersVC = CharactersViewController()
        let charactersTabBarItem = UITabBarItem(title: NSLocalizedString("Characters", comment: ""), image: UIImage(systemName: "person"), tag: 0)
        
        let locationsVC = LocationsViewController()
        let locationsTabBarItem = UITabBarItem(title: NSLocalizedString("Locations", comment: ""), image: UIImage(systemName: "location"), tag: 1)
        
        let episodesVC = EpisodesViewController()
        let episodesTabBarItem = UITabBarItem(title: NSLocalizedString("Episodes", comment: ""), image: UIImage(systemName: "tv"), tag: 2)
        
        let viewControllers = [
            createNavigationController(for: charactersVC, item: charactersTabBarItem),
            createNavigationController(for: locationsVC, item: locationsTabBarItem),
            createNavigationController(for: episodesVC, item: episodesTabBarItem)
        ]
        
        setViewControllers(viewControllers, animated: true)
        
    }
    
    private func createNavigationController(for viewController: UIViewController, item: UITabBarItem) -> RMNavigationController {
        
        let navigationController = RMNavigationController(for: viewController, tabBar: item)
        
        return navigationController
        
    }

}
