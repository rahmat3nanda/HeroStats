//
//  HeroDetailController.swift
//  HeroIOS
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/07/24.
//

import UIKit
import Hero

public class HeroDetailController: UIViewController {
    private let hero: HeroItem
    private let recommendations: [HeroItem]
    
    private lazy var mainView: HeroDetailView = {
        let view = HeroDetailView()
        return view
    }()
    
    public init(hero: HeroItem, recommendations: [HeroItem]) {
        self.hero = hero
        self.recommendations = recommendations
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        view = mainView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = hero.localizedName
        mainView.setData(hero, recommendations: recommendations)
    }
}
