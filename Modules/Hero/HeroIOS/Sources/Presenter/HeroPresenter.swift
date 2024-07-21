//
//  HeroPresenter.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Networking

protocol HeroPresenterProtocol: AnyObject {
    func loadData(skipCache: Bool)
}

extension HeroPresenterProtocol {
    func loadData(_skipCache: Bool = true) {
        loadData(skipCache: _skipCache)
    }
}

class HeroPresenter: HeroPresenterProtocol {
    
    weak var view: HeroControllerProtocol?
    let loader: HeroLoader
    
    init(view: HeroControllerProtocol, loader: HeroLoader) {
        self.view = view
        self.loader = loader
    }
    
    func loadData(skipCache: Bool) {
        guard ReachabilityNetwork.isConnectedToNetwork() else {
            view?.showNoInternet()
            return
        }
        
        loader.load(skipCache: skipCache) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data): self.view?.showData(data: data, role: data.getRole())
            case let .failure(error): self.view?.showError(with: error.localizedDescription)
            }
        }
    }
}

fileprivate extension Array where Element == Hero {
    func getRole() -> [HeroRole] {
        var data: [HeroRole] = []
        for hero in self {
            for role in hero.roles {
                data.append(role)
            }
        }
        return data
    }
}