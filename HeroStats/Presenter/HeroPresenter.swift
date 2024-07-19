//
//  HeroPresenter.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Networking

protocol HeroPresenterProtocol: AnyObject {
    func loadData()
}

class HeroPresenter: HeroPresenterProtocol {
    
    weak var view: HeroControllerProtocol?
    let loader: HeroLoader
    
    init(view: HeroControllerProtocol, loader: HeroLoader) {
        self.view = view
        self.loader = loader
    }
    
    func loadData() {
        guard ReachabilityNetwork.isConnectedToNetwork() else {
            view?.showNoInternet()
            return
        }
        
        loader.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data): self.view?.showData(with: data)
            case let .failure(error): self.view?.showError(with: error.localizedDescription)
            }
        }
    }
}
