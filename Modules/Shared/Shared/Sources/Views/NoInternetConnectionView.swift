//
//  NoInternetConnectionView.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit

public protocol NoInternetConnectionViewDelegate: AnyObject {
    func didRetry()
}

public class NoInternetConnectionView: UIView {
    public weak var delegate: NoInternetConnectionViewDelegate?
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "wifi.slash")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Uppsss...\nTidak ada koneksi internet"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .white
        configuration.background.cornerRadius = 8
        configuration.baseForegroundColor = .black
        configuration.background.strokeColor = .black
        configuration.background.strokeWidth = 1
        configuration.title = "Retry"
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [iconImageView, messageLabel, retryButton])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        
        iconImageView.anchors.height.equal(64)
        iconImageView.anchors.width.equal(64)
        retryButton.anchors.width.greaterThanOrEqual(150)
        
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

private extension NoInternetConnectionView {
    func configUI() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.anchors.center.align()
        containerView.anchors.width.lessThanOrEqual(UIScreen.main.bounds.width * 0.8)
    }
}


#Preview {
    NoInternetConnectionView()
}
