//
//  DefaultRouter.swift
//  ApiRickAndMortyNetworking
//
//  Created by Juan Camilo Fonseca Gomez on 29/06/23.
//

import Foundation
import UIKit

protocol Router {
    func getRootViewController() -> UIViewController
}

final class RMDefaultRouter: Router {
    
    private let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController = TabBarController()) {
        self.tabBarController = tabBarController
    }
    
    func getRootViewController() -> UIViewController {
        return tabBarController
    }
    
    
}
