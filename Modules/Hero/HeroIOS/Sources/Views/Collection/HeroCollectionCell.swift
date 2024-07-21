//
//  HeroCollectionCell.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import UIKit
import Shared
import Hero

protocol HeroCollectionCellDelegate: AnyObject {
    func didSelect(_ hero: HeroItem)
}

class HeroCollectionCell: UICollectionViewCell {
    
    weak var delegate: HeroCollectionCellDelegate?
    
    var data: [HeroItem] = [] {
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

extension HeroCollectionCell {
    func refreshCollection() {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Private Helper
private extension HeroCollectionCell {
    func configUI() {
        contentView.addSubview(collectionView)
        
        collectionView.anchors.edges.pin(to: contentView.safeAreaLayoutGuide, insets: .zero)
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCustomCell(HeroItemCollectionCell.self)
    }
}

extension HeroCollectionCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: HeroItemCollectionCell.self, indexPath: indexPath)
        if let item = data[safe: indexPath.item] {
            cell.setHero(name: item.localizedName, image: item.img)
        }
        cell.delegate = self
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
}

extension HeroCollectionCell: UICollectionViewDelegate {}

extension HeroCollectionCell: UICollectionViewDelegateFlowLayout {
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


extension HeroCollectionCell: HeroItemCollectionCellDelegate {
    func didSelect(_ cell: HeroItemCollectionCell) {
        guard let indexPath = collectionView.indexPath(for: cell), let item = data[safe: indexPath.item] else { return }
        self.delegate?.didSelect(item)
    }
}
