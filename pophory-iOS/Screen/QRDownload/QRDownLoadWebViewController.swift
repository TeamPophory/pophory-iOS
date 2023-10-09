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
            
            // QR코드에서 이미지 로드
            guard let url = createURL(from: "https://life4cut-l4c01.s3-accelerate.amazonaws.com/web/web/QRImage/20230904/SEL.YSN.MYUNG02/202003232/index.html") else { return }
            
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // webView에서 url 로드
    func loadURL(_ urlString: String) {
        guard let url = createURL(from: urlString) else { return }
        let request = URLRequest(url: url)
        webView?.load(request)
    }
    
    private func createURL(from urlString: String) -> URL? {
        return URL(string: urlString)
    }
    
    // 서비스 지원 여부 확인
    func isSupportedPhotoService(_ host: String?) -> Bool {
        // TODO: 서비스 지원 여부 확인 로직
        return true
    }
    
    func moveToPhotoRegistrationScreen() {
        print("Move to Photo Registration Screen")
    }
    
    func moveToHomeScreen() {
        print("Move to Home Screen")
    }
}

// MARK: - WKNavigationDelegate

extension QRDownLoadWebViewController: WKNavigationDelegate {
    // 페이지 로드 완료를 처리하는 WKNavigationDelegate 메서드
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isSupportedPhotoService(webView.url?.host) {
            print("Supported Photo Service")
            extractAndProcessImageLinks()
        } else {
            print("Not Supported Photo Service")
            moveToHomeScreen()
        }
    }
    
    // 현재 웹 페이지에서 이미지 링크를 추출하고 처리
    private func extractAndProcessImageLinks() {
        webView?.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
            if let htmlString = html as? String {
                // HTML에서 이미지 링크 추출
//                let extractedImageLinks = self.extractImageLinks(html: htmlString)
                
                let testImageLinks = "<img class=image src=./life4cut-l4c01.s3-accelerate.amazonaws.com_web_web_QRImage_20230904_SEL.YSN.MYUNG02_202003232_index_files/image.jpg>"
                self.extractImageLinks(html: testImageLinks)
                
                // 추출된 이미지 링크 처리
//                self.processImageLinks(testImageLinks)
            }
        }
    }
    
    // 추출된 이미지 링크 처리
    private func processImageLinks(_ imageLinks: [String]) {
        for imageLink in imageLinks {
            print("Extracted Image Link: \(imageLink)")
            
        }
    }
    
    // HTML에서 이미지 링크 추출하는 메서드
    private func extractImageLinks(html: String) -> [String] {
        do {
            // 이미지 링크 추출을 위한 정규식
            let imgPattern = try NSRegularExpression(pattern: "src=([^\\s>]*).*?>", options: [])
            
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
