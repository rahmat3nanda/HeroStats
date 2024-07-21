//
//  SceneDelegate.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit
import Networking
import Shared
import Hero

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private(set) lazy var navigationController = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
//        navigationController.setViewControllers([makeHeroController()], animated: true)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

// MARK: - Hero Page
//extension SceneDelegate {
//    func makeHeroController() -> UIViewController {
//        let controller = HeroController()
//        let loader = MainQueueDispatchDecorator(decoratee: HeroLoaderFactory.create())
//        let presenter = HeroPresenter(view: controller, loader: loader)
//        controller.presenter = presenter
//        
//        return controller
//    }
//}

//extension MainQueueDispatchDecorator: HeroLoader where T == HeroLoader {
//    func load(skipCache: Bool, completion: @escaping (HeroLoader.Result) -> Void) {
//        decoratee.load(skipCache: skipCache) { [weak self] result in
//            self?.dispatch { completion(result) }
//        }
//    }
//}
