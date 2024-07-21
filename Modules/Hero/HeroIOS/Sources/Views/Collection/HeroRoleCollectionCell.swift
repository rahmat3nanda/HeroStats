//
//  HeroRoleCollectionCell.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 20/07/24.
//

import UIKit
import Shared
import Hero

protocol HeroRoleCollectionCellDelegate: AnyObject {
    func didSelect(_ role: HeroRole)
}

class HeroRoleCollectionCell: UICollectionViewCell {
    
    weak var delegate: HeroRoleCollectionCellDelegate?
    
    var data: [HeroRole] = [] {
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
private extension HeroRoleCollectionCell {
    func configUI() {
        contentView.addSubview(collectionView)
        
        collectionView.anchors.edges.pin(to: contentView.safeAreaLayoutGuide, insets: .zero)
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCustomCell(HeroRoleItemCollectionCell.self)
    }
}

extension HeroRoleCollectionCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCustomCell(with: HeroRoleItemCollectionCell.self, indexPath: indexPath)
        if let item = data[safe: indexPath.item] {
            cell.setTitle(item.rawValue)
        }
        cell.delegate = self
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
}

extension HeroRoleCollectionCell: UICollectionViewDelegate {}

extension HeroRoleCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 16, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top:12, left: 8, bottom: 12, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 12 }
}


extension HeroRoleCollectionCell: HeroRoleItemCollectionCellDelegate {
    func didSelect(_ cell: HeroRoleItemCollectionCell) {
        guard let indexPath = collectionView.indexPath(for: cell), let role = data[safe: indexPath.item] else { return }
        delegate?.didSelect(role)
    }
}
