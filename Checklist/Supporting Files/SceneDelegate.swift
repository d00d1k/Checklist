//
//  SceneDelegate.swift
//  Checklist
//
//  Created by Nikita Kalyuzhniy on 2/13/20.
//  Copyright © 2020 Nikita Kalyuzhniy. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataModel = DataModel()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navigationController = window!.rootViewController as! UINavigationController

        let controller = navigationController.viewControllers[0] as! AllListsViewController

        controller.dataModel = dataModel
        // Override point for customization after application launch.
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        saveData()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        saveData()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        saveData()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        saveData()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        saveData()
    }
    
    func saveData() {
        dataModel.saveChecklists()
    }


}

