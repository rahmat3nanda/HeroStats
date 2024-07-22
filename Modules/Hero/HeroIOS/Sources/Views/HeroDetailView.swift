//
//  HeroDetailView.swift
//  HeroIOS
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/07/24.
//

import UIKit
import Networking
import Shared
import Hero
import Kingfisher

class HeroDetailView: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        view.image = UIImage(systemName: "wifi.slash")
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private lazy var primaryAttrLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    private lazy var attackTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    private lazy var rolesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
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
        nameLabel.text = hero.localizedName
        primaryAttrLabel.text = "Attribute: \(hero.primaryAttr.rawValue)"
        attackTypeLabel.text = "Attack Type: \(hero.attackType.rawValue)"
        rolesLabel.text = "Roles: \(hero.roles.map({ $0.rawValue }).joined(separator: ", "))"
        
        if let url = URL(string: "\(APIConstants.instance.imageBaseUrl)\(hero.img)") {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo")?.withTintColor(.black, renderingMode: .alwaysTemplate)
            )
        }
    }
    
    func setupConstraints() {
        for subview in subviews {
            subview.removeAllConstraints()
        }
        
        let orientation = UIDevice.current.orientation
        if orientation == .portrait || orientation == .unknown {
            imageView.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            imageView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            imageView.anchors.top.equal(safeAreaLayoutGuide.anchors.top, constant: 12)
            imageView.anchors.height.equal(200)
            
            nameLabel.textAlignment = .center
            nameLabel.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            nameLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            nameLabel.anchors.top.equal(imageView.anchors.bottom, constant: 12)
            
            primaryAttrLabel.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            primaryAttrLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            primaryAttrLabel.anchors.top.equal(nameLabel.anchors.bottom, constant: 32)
            
            attackTypeLabel.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            attackTypeLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            attackTypeLabel.anchors.top.equal(primaryAttrLabel.anchors.bottom, constant: 4)
            
            rolesLabel.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            rolesLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            rolesLabel.anchors.top.equal(attackTypeLabel.anchors.bottom, constant: 4)
            
            return
        }
        
        imageView.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
        imageView.anchors.top.equal(safeAreaLayoutGuide.anchors.top, constant: 12)
        imageView.anchors.width.equal(120)
        imageView.anchors.height.equal(150)
        
        nameLabel.textAlignment = .left
        nameLabel.anchors.leading.equal(imageView.anchors.trailing, constant: 12)
        nameLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        nameLabel.anchors.top.equal(safeAreaLayoutGuide.anchors.top, constant: 12)
        
        primaryAttrLabel.anchors.leading.equal(imageView.anchors.trailing, constant: 12)
        primaryAttrLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        primaryAttrLabel.anchors.top.equal(nameLabel.anchors.bottom, constant: 32)
        
        attackTypeLabel.anchors.leading.equal(imageView.anchors.trailing, constant: 12)
        attackTypeLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        attackTypeLabel.anchors.top.equal(primaryAttrLabel.anchors.bottom, constant: 4)
        
        rolesLabel.anchors.leading.equal(imageView.anchors.trailing, constant: 12)
        rolesLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        rolesLabel.anchors.top.equal(attackTypeLabel.anchors.bottom, constant: 4)
    }
}

// MARK: - Private Helper
private extension HeroDetailView {
    func configUI() {
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(primaryAttrLabel)
        addSubview(attackTypeLabel)
        addSubview(rolesLabel)
        setupConstraints()
    }
}

//#Preview { HeroDetailView() }
