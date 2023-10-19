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
    
    // MARK: - Properties
    
    var webView: WKWebView?
    var loadedURLs = Set<URL>()
    var isMovingToSafari = false
    var urlString: String?
    var fullUrlString: String?
    
    var onImageURLsExtracted: (([String]) -> Void)?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        addDidBecomeActiveObserver()
    }
    
    deinit {
        removeDidBecomeActiveObserver()
    }
}

// MARK: - Extensions

extension QRDownLoadWebViewController {
    
    // MARK: - Settings
    
    private func setupWebView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        
        if let urlString = self.urlString {
            loadURL(urlString)
        }
        
        if let webView = webView {
            view.addSubview(webView)
            webView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func addDidBecomeActiveObserver() {
        // 앱이 포어그라운드로 전환되고 활성화될 때
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func removeDidBecomeActiveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
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
        
        if isSupportedPhotoService(url.host) {
            // Full URL
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    DispatchQueue.main.async {
                        guard let finalUrl = httpResponse.url else { return }
                        self.fullUrlString = finalUrl.absoluteString
                        let request = URLRequest(url: finalUrl)
                        self.webView?.load(request)
                    }
                }
            }
            task.resume()
        } else {
            loadUnsupportedPage(url)
        }
    }
    
    
    private func createURL(from urlString: String) -> URL? {
        return URL(string: urlString.trimmingCharacters(in:.whitespacesAndNewlines))
    }
    
    // 서비스 지원 여부 확인
    func isSupportedPhotoService(_ inputHost: String?) -> Bool {
        guard let host = inputHost?.lowercased() else { return false }
        
        let suppertedDomains = [
            // 인생네컷
            "life4cut",
            "3.37.14.138",
            "photoqr3.kr",
            "haru1.mx2.co.kr",
            "haru3.mx2.co.kr",
            "photoone.download"
        ]
        
        for domain in suppertedDomains {
            if host.contains(domain) {
                return true
            }
        }
        return false
    }
    
    private func loadUnsupportedPage(_ url: URL) {
        UIApplication.shared.open(url)
        isMovingToSafari = true
        //        self.dismiss(animated: true)
    }
    
    // 현재 웹 페이지에서 이미지 링크를 추출하고 처리
    private func extractAndProcessImageLinks() {
        webView?.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
            if let htmlString = html as? String {
                let extractedImageLinks = self.extractImageLinks(html: htmlString)
                self.onImageURLsExtracted?(extractedImageLinks)
                self.processImageLinks(extractedImageLinks)
            } else if let error = error {
                print("Error evaluating JavaScript: \(error)")
            }
        }
    }
    
    // 추출된 이미지 링크 처리
    private func processImageLinks(_ imageLinks: [String]) {
        var longestImage: UIImage? = nil
        var longestImageLink: String? = nil
        var longestImageType: PhotoCellType = .horizontal
        var longestImageData: (image: UIImage?, link: String?, type: PhotoCellType)? = nil
        
        let dispatchGroup = DispatchGroup()
        
        for imageName in imageLinks {
            // life4cut 도메인에서 오는 이미지 파일일 때
            if fullUrlString?.contains("life4cut") == true {
                let baseUrlWithoutIndex = fullUrlString?.replacingOccurrences(of: "/index.html", with: "")
                let fullImageUrlString = "\(baseUrlWithoutIndex ?? "")/\(imageName)"
                
                if !fullImageUrlString.contains("jpg") { continue }
                
                guard let url = URL(string: fullImageUrlString) else { continue }
                
                dispatchGroup.enter()
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    defer { dispatchGroup.leave() }
                    
                    if let data = data,
                       let image = UIImage(data: data) {
                        longestImage = image
                        longestImageLink = fullImageUrlString
                    }
                }.resume()
            }
            // 다른 도메인에서 오는 이미지 링크일 때 일반적인 처리
            else {
                guard let url = URL(string: imageName) else { continue }
                dispatchGroup.enter()
                
                URLSession.shared.dataTask(with:url) { data, response, error in
                    defer { dispatchGroup.leave() }
                    
                    if let data = data,
                       let image = UIImage(data:data),
                       image.size.height > longestImage?.size.height ?? 0 {
                        longestImage = image
                        longestImageLink = imageName
                        
                        if image.size.width > image.size.height {
                            longestImageType = .horizontal
                        } else {
                            longestImageType = .vertical
                        }
                    }
                }
                .resume()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if !imageLinks.isEmpty && longestImage != nil {
                print("Longest Image Link is : \(longestImageLink)")
                
                let addphotoVC = AddPhotoViewController()
                // Longest Image를 활용하는 코드.
                DispatchQueue.main.async {
                    addphotoVC.setupRootViewImage(forImage: longestImage, forType: longestImageType)
                }
                self.navigationController?.pushViewController(addphotoVC, animated: true)
            }
        }
    }
    
    // HTML에서 이미지 링크 추출
    private func extractImageLinks(html: String) -> [String] {
        do {
            // 이미지 링크 추출을 위한 정규식
            let imgPattern = try NSRegularExpression(pattern:"<img[^>]*src=\"([^\"]*)\"", options:[ ])
            
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
    
    // MARK: - Navigation
    
    func moveToAddPhotoViewController() {
        print("Move to Photo Registration Screen")
    }
    
    func moveToHomeScreen() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - WKNavigationDelegate

extension QRDownLoadWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isSupportedPhotoService(webView.url?.host) {
            extractAndProcessImageLinks()
        }
    }
}
