//
//  TabbarController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateTabBar()
        self.tabBar.backgroundColor = .darkGray
        self.tabBar.tintColor = .green
        self.tabBar.layer.opacity = 0.6
    }
    
    private func configurateTabBar() {
        let mapVC = MapController(nibName: String(describing: MapController.self), bundle: nil)
        let gemsVC = GemsController(nibName: String(describing: GemsController.self), bundle: nil)
        let ingotsVC = IngotsController(nibName: String(describing: IngotsController.self), bundle: nil)
        let settingsVC = SettingsController(nibName: String(describing: SettingsController.self), bundle: nil)
        
        self.viewControllers = [mapVC, gemsVC, ingotsVC, settingsVC]
        mapVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map"), tag: 0)
        gemsVC.tabBarItem = UITabBarItem(title: "Алмазы", image: UIImage(systemName: "pentagon"), tag: 1)
        ingotsVC.tabBarItem = UITabBarItem(title: "Слитки", image: UIImage(systemName: "rectangle.center.inset.fill"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), tag: 3)
    }
    
}
