//
//  HeroController.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit
import Shared

enum HeroControllerViewType {
    case hero
    case noInternet
    case error
}

protocol HeroControllerProtocol: AnyObject {
    func showNoInternet()
    func showError(with message: String)
    func showData(with data: [Hero])
}

class HeroController: UIViewController {
    
    var viewType: HeroControllerViewType = .hero {
        didSet {
            updateView()
        }
    }
    
    let loader: HeroLoader
    
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
    
    init(loader: HeroLoader) {
        self.loader = loader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = heroView
    }
}

extension HeroController: HeroControllerProtocol {
    func showNoInternet() {
        viewType = .noInternet
    }
    
    func showError(with message: String) {
        viewType = .error
    }
    
    func showData(with data: [Hero]) {
        viewType = .hero
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
