//
//  SceneDelegate+Hero.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/07/24.
//

import UIKit
import Hero
import HeroIOS
import Networking
import Shared

// MARK: - Hero Page
extension SceneDelegate {
    func makeHeroController() -> UIViewController {
        let controller = HeroController()
        let loader = MainQueueDispatchDecorator(decoratee: HeroLoaderFactory.create())
        let presenter = HeroPresenter(view: controller, loader: loader)
        controller.presenter = presenter
        controller.delegate = self
        
        return controller
    }
}

extension SceneDelegate: HeroControllerDelegate {
    func didSelect(_ hero: HeroItem, recomendations: [HeroItem]) {
        let target = HeroDetailController(hero: hero, recommendations: recomendations)
        target.bindNavigationBar()
        navigationController.pushViewController(target, animated: true)
    }
}

extension MainQueueDispatchDecorator: HeroLoader where T == HeroLoader {
    public func load(skipCache: Bool, completion: @escaping (HeroLoader.Result) -> Void) {
        decoratee.load(skipCache: skipCache) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
