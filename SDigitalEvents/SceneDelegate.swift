//
//  SceneDelegate.swift
//  SDigitalEvents
//
//  Created by Rafael on 27/4/20.
//  Copyright © 2020 rmd. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
         private let navigator = UINavigationController()

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            
            makeViewController()
        }

        private func makeViewController() {
            window?.rootViewController = navigator
            window?.makeKeyAndVisible()
            
            let router = EventsRouter(navigator: navigator)
            navigator.pushViewController(router.makeViewController(), animated: true)
        }
    }

    extension UIWindow {
        var rootNavigationController: UINavigationController? {
            return rootViewController as? UINavigationController
        }
    }

