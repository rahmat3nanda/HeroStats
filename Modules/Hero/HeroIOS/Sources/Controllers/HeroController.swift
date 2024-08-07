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
    func showRecomendations(for hero: HeroItem, data: [HeroItem])
}

public protocol HeroControllerDelegate: AnyObject {
    func didSelect(_ hero: HeroItem, recomendations: [HeroItem])
}

public class HeroController: UIViewController {
    
    public var presenter: HeroPresenterProtocol?
    public weak var delegate: HeroControllerDelegate?
    
    private var viewType: HeroControllerViewType = .hero {
        didSet {
            updateView()
        }
    }
    
    private lazy var heroView: HeroView = {
        let view = HeroView()
        view.delegate = self
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
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        view = heroView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hero Stat"
        presenter?.loadData(skipCache: false)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        heroView.orientationChanged()
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
        heroView.data = data
        heroView.role = role
        title = "Hero Stat: All"
    }
    
    public func showRecomendations(for hero: HeroItem, data: [HeroItem]) {
        delegate?.didSelect(hero, recomendations: data)
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

extension HeroController: HeroViewDelegate {
    func didRefresh() {
        presenter?.loadData()
    }
    
    func didSelectHero(_ hero: HeroItem) {
        print("Select", hero.localizedName)
        presenter?.recommendations(for: hero)
    }
    
    func didSelectRole(_ role: HeroRole) {
        title = "Hero Stat: \(role.rawValue)"
        presenter?.filter(role: role)
    }
}
