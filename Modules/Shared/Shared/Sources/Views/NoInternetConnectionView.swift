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
    
    private lazy var mainView: WarningView = {
        let view = WarningView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.image = UIImage(systemName: "wifi.slash")?.withRenderingMode(.alwaysTemplate)
        view.message = "Uppsss...\nTidak ada koneksi internet"
        view.titleButton = "Retry"
        
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
        
        addSubview(mainView)
        mainView.anchors.center.align()
        mainView.onAction = { [weak self] in
            self?.delegate?.didRetry()
        }
    }
}


#Preview {
    NoInternetConnectionView()
}
