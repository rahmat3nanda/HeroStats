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
    
    private var recommendations: [HeroItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.tintColor = .black
        
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
    
    private lazy var recomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
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
        recomLabel.text = recommendations.isEmpty ? "" : "Recommendations"
        self.recommendations = recommendations
        
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
            
            recomLabel.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            recomLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            recomLabel.anchors.top.equal(rolesLabel.anchors.bottom, constant: 16)
            
            collectionView.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading, constant: 12)
            collectionView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
            collectionView.anchors.top.equal(recomLabel.anchors.bottom, constant: 12)
            collectionView.anchors.bottom.equal(safeAreaLayoutGuide.anchors.bottom, constant: 16)
            
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
        
        recomLabel.anchors.leading.equal(imageView.anchors.trailing, constant: 12)
        recomLabel.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        recomLabel.anchors.top.equal(rolesLabel.anchors.bottom, constant: 16)
        
        collectionView.anchors.leading.equal(imageView.anchors.trailing, constant: 12)
        collectionView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing, constant: -12)
        collectionView.anchors.top.equal(recomLabel.anchors.bottom, constant: 16)
        collectionView.anchors.bottom.equal(safeAreaLayoutGuide.anchors.bottom, constant: 12)
    }
}

// MARK: - Private Helper
private extension HeroDetailView {
    func configUI() {
        backgroundColor = .white
        
        addSubviews([imageView, nameLabel, primaryAttrLabel, attackTypeLabel, rolesLabel, recomLabel, collectionView])
        setupConstraints()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCustomCell(HeroItemCollectionCell.self)
    }
}

extension HeroDetailView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: HeroItemCollectionCell.self, indexPath: indexPath)
        if let item = recommendations[safe: indexPath.item] {
            cell.setHero(name: item.localizedName, image: item.img)
        }
        cell.delegate = self
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recommendations.count
    }
}

extension HeroDetailView: UICollectionViewDelegate {}

extension HeroDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.safeAreaLayoutGuide.layoutFrame
        let orientation = UIDevice.current.orientation
        let width = (orientation == .portrait || orientation == .unknown) ? (size.width - 16) : (size.width - 40) / 3
        
        return CGSize(width: width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top:12, left: 8, bottom: 12, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 12 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 8 }
}


extension HeroDetailView: HeroItemCollectionCellDelegate {
    func didSelect(_ cell: HeroItemCollectionCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              let item = recommendations[safe: indexPath.item] else { return }
        //        delegate?.didSelect(item)
    }
}

//#Preview { HeroDetailView() }
