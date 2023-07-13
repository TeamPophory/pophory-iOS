//
//  PophoryWebViewController.swift
//  pophory-iOS
//
//  Created by Danna Lee on 2023/07/12.
//

import UIKit
import WebKit

import SnapKit

class PophoryWebViewController: UIViewController {
    
    let urlString: String
    
    var webView: WKWebView!
    
    init(urlString: String, title: String) {
        self.urlString = urlString
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationBar(with: PophoryNavigationConfigurator.shared)
    }
}

extension PophoryWebViewController {
    private func setupLayout() {
        webView = WKWebView()
        
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        if let url = URL(string: self.urlString) {
            let request = URLRequest(url: url)
            
            webView.load(request)
        } else {
            print("Invalid URL")
        }
    }
}

// MARK: - navigation bar

extension PophoryWebViewController: Navigatable {
    var navigationBarTitleText: String? { title }
}
