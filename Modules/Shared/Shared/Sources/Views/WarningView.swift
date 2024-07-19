//
//  WarningView.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit

public class WarningView: UIView {
    
    public var onAction: (() -> Void)?
    
    public var image: UIImage? {
        didSet {
            iconImageView.image = image
        }
    }
    
    public var message: String = "" {
        didSet {
            messageLabel.text = message
        }
    }
    
    public var titleButton: String = "" {
        didSet {
            actionButton.configuration?.title = titleButton
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = image
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .white
        configuration.background.cornerRadius = 8
        configuration.baseForegroundColor = .black
        configuration.background.strokeColor = .black
        configuration.background.strokeWidth = 1
        configuration.title = titleButton
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [iconImageView, messageLabel, actionButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        
        iconImageView.anchors.height.equal(64)
        iconImageView.anchors.width.equal(64)
        actionButton.anchors.width.greaterThanOrEqual(150)
        
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
}

private extension WarningView {
    func configUI() {
        //        backgroundColor = .white
        
        addSubview(containerView)
        containerView.anchors.center.align()
        containerView.anchors.width.lessThanOrEqual(UIScreen.main.bounds.width * 0.8)
        
        actionButton.onTap { [weak self] in
            self?.onAction?()
        }
    }
}


#Preview {
    WarningView()
}
