//
//  HeroView.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit
import Shared

class HeroView: UIView {
    
    lazy var roleCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    lazy var dataCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
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

private extension HeroView {
    func configUI() {
        backgroundColor = .white
        
        addSubview(roleCollectionView)
        roleCollectionView.anchors.top.equal(safeAreaLayoutGuide.anchors.top)
        roleCollectionView.anchors.bottom.equal(safeAreaLayoutGuide.anchors.bottom)
        roleCollectionView.anchors.leading.equal(safeAreaLayoutGuide.anchors.leading)
        roleCollectionView.anchors.width.lessThanOrEqual(120)
        
        addSubview(dataCollectionView)
        dataCollectionView.anchors.top.equal(safeAreaLayoutGuide.anchors.top)
        dataCollectionView.anchors.bottom.equal(safeAreaLayoutGuide.anchors.bottom)
        dataCollectionView.anchors.leading.equal(roleCollectionView.anchors.trailing)
        dataCollectionView.anchors.trailing.equal(safeAreaLayoutGuide.anchors.trailing)
    }
}

//#Preview { HeroView() }
