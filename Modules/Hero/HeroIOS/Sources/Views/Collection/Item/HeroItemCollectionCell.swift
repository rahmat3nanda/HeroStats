//
//  HeroItemCollectionCell.swift
//  HeroIOS
//
//  Created by Rahmat Trinanda Pramudya Amar on 21/07/24.
//

import UIKit
import Shared
import Networking
import Kingfisher

protocol HeroItemCollectionCellDelegate: AnyObject {
    func didSelect(_ cell: HeroItemCollectionCell)
}

class HeroItemCollectionCell: UICollectionViewCell {
    
    weak var delegate: HeroItemCollectionCellDelegate?
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.tintColor = .black
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
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

extension HeroItemCollectionCell {
    func setHero(name: String, image: String) {
        label.text = name
        if let url = URL(string: "\(APIConstants.instance.imageBaseUrl)\(image)") {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo")?.withTintColor(.black, renderingMode: .alwaysTemplate)
            )
        }
    }
}

private extension HeroItemCollectionCell {
    func configUI() {        
        contentView.addSubview(label)
        label.anchors.leading.equal(contentView.anchors.leading)
        label.anchors.trailing.equal(contentView.anchors.trailing)
        label.anchors.bottom.equal(contentView.anchors.bottom)
        
        contentView.addSubview(imageView)
        imageView.anchors.leading.equal(contentView.anchors.leading)
        imageView.anchors.trailing.equal(contentView.anchors.trailing)
        imageView.anchors.top.equal(contentView.anchors.top)
        imageView.anchors.bottom.equal(label.anchors.top, constant: -4)
        
        contentView.onTap { [weak self] in
            guard let self = self else { return }
            self.delegate?.didSelect(self)
        }
    }
}
