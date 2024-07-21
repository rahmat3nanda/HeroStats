//
//  HeroView.swift
//  HeroStats
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit
import Shared
import Hero

fileprivate enum HeroCollectionViewSection: Int {
    case role = 0
    case hero = 1
    
    static let count: Int = {
        var max: Int = 0
        while let _ = HeroCollectionViewSection(rawValue: max) { max += 1 }
        return max
    }()
}

protocol HeroViewDelegate: AnyObject {
    func didSelectRole(_ role: HeroRole)
    func didSelectHero(_ hero: HeroItem)
}

class HeroView: UIView {
    
    weak var delegate: HeroViewDelegate?
    
    var data: [HeroItem] = [] {
        didSet {
            collectionView.reloadSections(IndexSet(integer: HeroCollectionViewSection.hero.rawValue))
        }
    }
    
    var role: [HeroRole] = [] {
        didSet {
            collectionView.reloadSections(IndexSet(integer: HeroCollectionViewSection.role.rawValue))
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .red
        view.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = refreshControl
        
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

// MARK: - Open Helper
extension HeroView {
    func orientationChanged() {
        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: HeroCollectionViewSection.hero.rawValue)) as? HeroCollectionCell {
            cell.refreshCollection()
        }
    }
}

// MARK: - Private Helper
private extension HeroView {
    func configUI() {
        backgroundColor = .white
        
        configCollectionView()
        
        addSubview(collectionView)
        collectionView.anchors.edges.pin(to: safeAreaLayoutGuide, insets: .zero)
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createContentLayout()
        collectionView.registerCustomCell(HeroCollectionCell.self)
        collectionView.registerCustomCell(HeroRoleCollectionCell.self)
    }
    
    @objc private func handleRefresh() {
        refreshControl.endRefreshing()
    }
    
    private func createContentLayout() -> UICollectionViewCompositionalLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, environtent) -> NSCollectionLayoutSection? in
            let screenWidth = self.safeAreaLayoutGuide.layoutFrame.width
            let width: NSCollectionLayoutDimension = sectionIndex == HeroCollectionViewSection.role.rawValue ? .estimated(130) : .estimated(screenWidth - 130)
            let itemSize = NSCollectionLayoutSize(widthDimension: width , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = .zero
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
    }
}

extension HeroView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HeroCollectionViewSection(rawValue: indexPath.section) {
        case .hero:
            let cell = collectionView.dequeueReusableCustomCell(with: HeroCollectionCell.self, indexPath: indexPath)
            cell.data = data
            return cell
        case .role:
            let cell = collectionView.dequeueReusableCustomCell(with: HeroRoleCollectionCell.self, indexPath: indexPath)
            cell.data = role
            cell.delegate = self
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        HeroCollectionViewSection.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HeroCollectionViewSection(rawValue: section) {
        case .role: 1
        case .hero: 1
        default: 0
        }
    }
}

extension HeroView: UICollectionViewDelegate {}

extension HeroView: HeroCollectionCellDelegate {
    func didSelect(_ hero: HeroItem) {
        delegate?.didSelectHero(hero)
    }
}

extension HeroView: HeroRoleCollectionCellDelegate {
    func didSelect(_ role: HeroRole) {
        delegate?.didSelectRole(role)
    }
}
