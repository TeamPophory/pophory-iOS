//
//  QRDownLoadWebViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/10/06.
//

import UIKit
import WebKit

// MARK: - WebViewController

class QRDownLoadWebViewController: UIViewController {
    var webView: WKWebView?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
    }
}

// MARK: - Extensions

extension QRDownLoadWebViewController {

    private func setupWebView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        if let webView = webView {
            view.addSubview(webView)
            
            // Load URL from QR code
            guard let url = createURL(from: "URL주소") else { return }
            
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    private func createURL(from urlString: String) -> URL? {
        return URL(string: urlString)
    }
    
    // Function to load the URL in the web view
    func loadURL(_ urlString: String) {
        guard let url = createURL(from: urlString) else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
    // Function to check if the photo service is supported
    func isSupportedPhotoService(_ host: String?) -> Bool {
        // Your logic to check if the service is supported
        // Example: Check if host matches a supported service
        return true
    }

    // Function to move to the photo registration screen
    func moveToPhotoRegistrationScreen() {
        // Your logic to navigate to the photo registration screen
        print("Move to Photo Registration Screen")
    }

    // Function to move back to the home screen
    func moveToHomeScreen() {
        // Your logic to navigate back to the home screen
        print("Move to Home Screen")
    }
}

// MARK: - WKNavigationDelegate

extension QRDownLoadWebViewController: WKNavigationDelegate {
    // WKNavigationDelegate method to handle page load finish
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Your logic after the webpage has finished loading
        // Example: Check if it's a supported photo service or not
        if isSupportedPhotoService(webView.url?.host) {
            // Move to the photo registration screen
            moveToPhotoRegistrationScreen()
        } else {
            // Move back to the home screen
            moveToHomeScreen()
        }
    }
}
