//
//  HeroDetailView.swift
//  HeroIOS
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/07/24.
//

import UIKit
import Shared
import Hero

class HeroDetailView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
}

extension HeroDetailView {
    func setData(_ hero: HeroItem, recommendations: [HeroItem]) {
        
    }
}

// MARK: - Private Helper
private extension HeroDetailView {
    func configUI() {
        addSubview(imageView)
        imageView.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
        imageView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        imageView.anchors.top.equal(safeAreaLayoutGuide.anchors.top, constant: 12)
        imageView.anchors.height.equal(100)
    }
}

//#Preview { HeroDetailView() }
