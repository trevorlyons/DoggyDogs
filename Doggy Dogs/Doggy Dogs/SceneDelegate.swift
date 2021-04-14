//
//  SceneDelegate.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        // TODO: use dogs list view here
        window.rootViewController = UIViewController()
        self.window = window
        window.makeKeyAndVisible()
    }
}

