//
//  ErrorView.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/24.
//

import UIKit

public protocol ErrorViewDelegate: AnyObject {
    func didRetry()
}

public class ErrorView: UIView {
    public weak var delegate: ErrorViewDelegate?
    
    private lazy var mainView: WarningView = {
        let view = WarningView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        view.message = "Terjadi kesalahan"
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

private extension ErrorView {
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
    ErrorView()
}
