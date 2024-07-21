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

public protocol HeroControllerProtocol: AnyObject {
    func showNoInternet()
    func showError(with message: String)
    func showData(data: [HeroItem], role: [HeroRole])
}

public class HeroController: UIViewController {
    
    public var presenter: HeroPresenterProtocol?
    
    private var viewType: HeroControllerViewType = .hero {
        didSet {
            updateView()
        }
    }
    
    private lazy var heroView: HeroView = {
        let view = HeroView()
        return view
    }()
    
    private lazy var noInternetView: NoInternetConnectionView = {
        let view = NoInternetConnectionView()
        return view
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        return view
    }()
    
    private var data: [HeroItem]?
    private var role: [HeroRole]?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view = heroView
        title = "Hero Stat"
        presenter?.loadData(skipCache: false)
    }
}

extension HeroController: HeroControllerProtocol {
    public func showNoInternet() {
        viewType = .noInternet
    }
    
    public func showError(with message: String) {
        viewType = .error
    }
    
    public func showData(data: [HeroItem], role: [HeroRole]) {
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
