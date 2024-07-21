//
//  HeroRoleItemCollectionCell.swift
//  HeroIOS
//
//  Created by Rahmat Trinanda Pramudya Amar on 21/07/24.
//

import UIKit
import Shared

protocol HeroRoleItemCollectionCellDelegate: AnyObject {
    func didSelect(_ cell: HeroRoleItemCollectionCell)
}

class HeroRoleItemCollectionCell: UICollectionViewCell {
    
    weak var delegate: HeroRoleItemCollectionCellDelegate?
    
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .black
        configuration.background.cornerRadius = 10
        configuration.baseForegroundColor = .white
        configuration.title = "Button"
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
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

extension HeroRoleItemCollectionCell {
    func setTitle(_ string: String) {
        button.setTitle(string, for: .normal)
    }
}

private extension HeroRoleItemCollectionCell {
    func configUI() {
        contentView.addSubview(button)
        //        button.anchors.center.align()
        button.anchors.edges.pin()
        button.onTap { [weak self] in
            guard let self = self else { return }
            self.delegate?.didSelect(self)
        }
    }
}

//#Preview { HeroRoleItemCollectionCell() }
