//
//  HeroCollectionCell.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import UIKit
import Shared

class HeroCollectionCell: UICollectionViewCell {
    var data: [Hero] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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

// MARK: - Private Helper
private extension HeroCollectionCell {
    func configUI() {
        contentView.addSubview(collectionView)
        
        collectionView.anchors.edges.pin(to: contentView.safeAreaLayoutGuide, insets: .zero)
    }
}
