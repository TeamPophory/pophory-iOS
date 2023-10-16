//
//  QRDownLoadWebViewController.swift
//  pophory-iOS
//
//  Created by Joon Baek on 2023/10/06.
//

import UIKit
import WebKit

import SnapKit

// MARK: - WebViewController

class QRDownLoadWebViewController: UIViewController {
    var webView: WKWebView?
    var loadedURLs = Set<URL>()
    var isMovingToSafari = false
    
    var onImageURLsExtracted: (([String]) -> Void)?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        // 앱이 포어그라운드로 전환되고 활성화될 때 관찰
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

// MARK: - Extensions

extension QRDownLoadWebViewController {
    
    // MARK: - Settings
    
    private func setupWebView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        
        if let webView = webView {
            view.addSubview(webView)
            webView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        // QR코드에서 이미지 로드
        guard let url = createURL(from: "http://14.63.225.67/?qr=2023/0422/hh01_2_V_V4_20230422134610834&S_TYPE=SELPIX&VER=1&LOC=KOR#/") else { return }
        
        let request = URLRequest(url: url)
        webView?.load(request)
        
    }
    
    // MARK: - Action Helpers
    
    // Safari에서 돌아왔을 때 실행
    @objc func didBecomeActive() {
        if isMovingToSafari {
            moveToHomeScreen()
            isMovingToSafari = false
        }
    }
    
    // webView에서 url 로드
    func loadURL(_ urlString: String) {
        guard let url = createURL(from: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        if !loadedURLs.contains(url) {
            loadedURLs.insert(url)
            self.webView?.load(request)
        }
    }
    
    private func createURL(from urlString: String) -> URL? {
        
        // TRIMING CHARACTORS?
        return URL(string: urlString.trimmingCharacters(in:.whitespacesAndNewlines))
    }
    
    // 서비스 지원 여부 확인
    func isSupportedPhotoService(_ inputHost: String?) -> Bool {
        guard let host = inputHost?.lowercased() else { return false }
        
        let suppertedDomains = [
            "life4cut-l4c01.s3-accelerate.amazonaws.com",
            "3.37.14.138",
            "photoqr3.kr",
            "haru1.mx2.co.kr/@HA006XEb7Nh"
        ]
        
        return suppertedDomains.contains(host)
    }
    
    private func loadUnsupportedPage(_ url: URL) {
        UIApplication.shared.open(url)
        isMovingToSafari = true
        //        self.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    func moveToAddPhotoViewController() {
        print("Move to Photo Registration Screen")
    }
    
    func moveToHomeScreen() {
        self.dismiss(animated: true) { [weak self] in
            guard self != nil else { return }
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let tabBarController = scene.windows.first?.rootViewController as? UITabBarController {
                tabBarController.selectedIndex = 0
            }
        }
    }
}

// MARK: - WKNavigationDelegate

extension QRDownLoadWebViewController: WKNavigationDelegate {
    // 페이지 로드 완료를 처리하는 WKNavigationDelegate 메서드
    
    // TODO: 강제언래핑 해제
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isSupportedPhotoService(webView.url?.host) {
            extractAndProcessImageLinks()
        } else {
            if let url = webView.url {
                loadUnsupportedPage(url)
            }
        }
    }
    
    // 현재 웹 페이지에서 이미지 링크를 추출하고 처리
    private func extractAndProcessImageLinks() {
        webView?.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
            if let htmlString = html as? String {
                // HTML에서 이미지 링크 추출
                let extractedImageLinks = self.extractImageLinks(html: htmlString)
                self.onImageURLsExtracted?(extractedImageLinks)
                
                // 추출된 이미지 링크 처리
                self.processImageLinks(extractedImageLinks)
            } else if let error = error {
                print("Error evaluating JavaScript: \(error)")
            }
        }
    }
    
    // 추출된 이미지 링크 처리
    private func processImageLinks(_ imageLinks: [String]) {
        for imageLink in imageLinks {
            if !imageLinks.isEmpty {
                let addphotoVC = AddPhotoViewController()
                self.navigationController?.pushViewController(addphotoVC, animated: true)
            }
        }
    }
    
    // HTML에서 이미지 링크 추출하는 메서드
    private func extractImageLinks(html: String) -> [String] {
        do {
            // 이미지 링크 추출을 위한 정규식
            let imgPattern = try NSRegularExpression(pattern:"img[^>]*src=\"([^\"]*)\"", options:[ ])
            
            // 위 정규식을 사용하여 이미지 링크 추출
            let matches = imgPattern.matches(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count))
            print(">>> \(matches)")
            
            // 일치하는 이미지 링크를 배열에 저장
            let imageLinks = matches.map { (result) -> String in
                let range = result.range(at: 1)
                if let swiftRange = Range(range, in: html) {
                    return String(html[swiftRange])
                }
                return ""
            }
            return imageLinks
        } catch {
            print("Error creating regular expression: \(error)")
            return []
        }
    }
}
