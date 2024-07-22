//
//  HeroPresenter.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import Networking
import Hero

public protocol HeroPresenterProtocol: AnyObject {
    func loadData(skipCache: Bool)
    func filter(role: HeroRole)
    func recommendations(for hero: HeroItem)
}

extension HeroPresenterProtocol {
    func loadData(_skipCache: Bool = true) {
        loadData(skipCache: _skipCache)
    }
}

public class HeroPresenter: HeroPresenterProtocol {
    
    weak var view: HeroControllerProtocol?
    let loader: HeroLoader
    
    private var data: [HeroItem] = []
    private var role: [HeroRole] = []
    
    public init(view: HeroControllerProtocol, loader: HeroLoader) {
        self.view = view
        self.loader = loader
    }
    
    public func loadData(skipCache: Bool) {
        guard ReachabilityNetwork.isConnectedToNetwork() else {
            view?.showNoInternet()
            return
        }
        
        loader.load(skipCache: skipCache) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.data = data
                self.role = data.getRole()
                self.view?.showData(data: data, role: data.getRole())
            case let .failure(error): self.view?.showError(with: error.localizedDescription)
            }
        }
    }
    
    public func filter(role: HeroRole) {
        if role == .all {
            view?.showData(data: data, role: self.role)
            return
        }
        
        view?.showData(data: data.filter({$0.roles.contains(where: {$0.rawValue == role.rawValue})}), role: self.role)
    }
    
    public func recommendations(for hero: HeroItem) {
        if hero.primaryAttr == .agi {
            let sorted = data.sorted(by: { $0.moveSpeed > $1.moveSpeed })
            let highest3 = Array(sorted.prefix(3))
            view?.showRecomendations(for: hero, data: highest3)
            return
        }
        
        if hero.primaryAttr == .str {
            let sorted = data.sorted(by: { $0.baseAttackMax > $1.baseAttackMax })
            let highest3 = Array(sorted.prefix(3))
            view?.showRecomendations(for: hero, data: highest3)
            return
        }
        
        if hero.primaryAttr == .int {
            let sorted = data.sorted(by: { $0.baseMana > $1.baseMana })
            let highest3 = Array(sorted.prefix(3))
            view?.showRecomendations(for: hero, data: highest3)
            return
        }
        
        view?.showRecomendations(for: hero, data: [])
    }
}

fileprivate extension Array where Element == HeroItem {
    func getRole() -> [HeroRole] {
        var data: [HeroRole] = []
        for hero in self {
            for role in hero.roles {
                if !data.contains(where: {$0.rawValue == role.rawValue}) {
                    data.append(role)
                }
            }
        }
        
        data.append(HeroRole(rawValue: "All")!)
        
        return data
    }
}
