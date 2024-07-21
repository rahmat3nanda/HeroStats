//
//  HeroController.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit
import Shared
import Hero

enum HeroControllerViewType {
    case hero
    case noInternet
    case error
}

protocol HeroControllerProtocol: AnyObject {
    func showNoInternet()
    func showError(with message: String)
    func showData(data: [HeroItem], role: [HeroRole])
}

class HeroController: UIViewController {
    
    var presenter: HeroPresenterProtocol?
    
    var viewType: HeroControllerViewType = .hero {
        didSet {
            updateView()
        }
    }
    
    lazy var heroView: HeroView = {
        let view = HeroView()
        return view
    }()
    
    lazy var noInternetView: NoInternetConnectionView = {
        let view = NoInternetConnectionView()
        return view
    }()
    
    lazy var errorView: ErrorView = {
        let view = ErrorView()
        return view
    }()
    
    var data: [HeroItem]?
    var role: [HeroRole]?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = heroView
        title = "Hero Stat"
        presenter?.loadData(skipCache: false)
    }
}

extension HeroController: HeroControllerProtocol {
    func showNoInternet() {
        viewType = .noInternet
    }
    
    func showError(with message: String) {
        viewType = .error
    }
    
    func showData(data: [HeroItem], role: [HeroRole]) {
        viewType = .hero
        self.data = data
        self.role = role
    }
}

// MARK: - Private Helper
private extension HeroController {
    func updateView() {
        func setViewIfNeeded(_ newView: UIView) {
            if view != newView {
                view = newView
            }
        }
        
        switch viewType {
        case .hero:
            setViewIfNeeded(heroView)
        case .noInternet:
            setViewIfNeeded(noInternetView)
        case .error:
            setViewIfNeeded(errorView)
        }
    }
}
