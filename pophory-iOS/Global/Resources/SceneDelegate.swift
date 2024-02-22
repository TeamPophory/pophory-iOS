//
//  SceneDelegate.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

import FirebaseDynamicLinks
import UniformTypeIdentifiers

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var errorWindow: UIWindow?
    private var networkMonitor: NetworkMonitor = NetworkMonitor()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let userActivity = connectionOptions.userActivities.first {
            self.scene(scene, continue: userActivity)
        }
        
        startMonitoringNetwork(on: scene)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
            
            let appleLoginManager = AppleLoginManager()
            let rootVC = OnboardingViewController(appleLoginManager: appleLoginManager)
            
            appleLoginManager.delegate = rootVC
            
            let navigationController = PophoryNavigationController(rootViewController: rootVC)
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window
        }
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if let url = userActivity.webpageURL {
            let handled = DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
                if let shareID = self.handleDynamicLink(dynamicLink) {
                    guard let _ = (scene as? UIWindowScene) else { return }
                    
                    if let windowScene = scene as? UIWindowScene {
                        let window = UIWindow(windowScene: windowScene)
                        window.overrideUserInterfaceStyle = UIUserInterfaceStyle.light
                        let rootVC = ShareViewController()
                        rootVC.setupShareID(forShareID: shareID)
                        rootVC.rootView.shareButton.addTarget(self, action: #selector(self.setupRoot), for: .touchUpInside)
                        
                        window.rootViewController = rootVC
                        window.makeKeyAndVisible()
                        self.window = window
                    }
                }
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        
        // shareExtension 받았을 때
        if let range = url.absoluteString.range(of: "//") {
            let substring = url.absoluteString[range.upperBound...]
            
            if substring == "share" {
                
                self.isAlbumFull { isAlbumFull in
                    
                    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                    
                    if isLoggedIn {
                        if isAlbumFull {
                            self.setupAlbumFullViewController()
                        } else {
                            self.setupAddphotoViewcontroller()
                        }
                    } else {
                        self.setupRootViewController()
                    }
                }
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    @objc func setupRoot() {
        setupRootViewController()
    }
    
    func setupRootViewController() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        var rootViewController: UIViewController
        
        if isLoggedIn {
            let tabBarViewController = TabBarController()
            rootViewController = tabBarViewController
        } else {
            let appleLoginManager = AppleLoginManager()
            let rootVC = OnboardingViewController(appleLoginManager: appleLoginManager)
            
            appleLoginManager.delegate = rootVC
            rootViewController = rootVC
        }
        let navigationController = PophoryNavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func handleDynamicLink(_ dynamicLink: DynamicLink?) -> String? {
        guard let dynamicLink = dynamicLink, let link = dynamicLink.url else { return nil }
        
        if let components = URLComponents(url: link, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems {
            for item in queryItems {
                if item.name == "u", let value = item.value {
                    return value
                }
            }
        }
        return nil
    }
    
    private func isAlbumFull(completion: @escaping (Bool) -> ()) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isLoggedIn {
            var maxPhotoCount: Int?
            var maxPhotoLimit: Int?
            var albumList: FetchAlbumListResponseDTO? {
                didSet {
                    if let albums = albumList?.albums {
                        if albums.count != 0 {
                            maxPhotoCount = albums[0].photoCount
                            maxPhotoLimit = albums[0].photoLimit
                        }
                    }
                }
            }
            
            NetworkService.shared.albumRepository.fetchAlbumList() { result in
                switch result {
                case .success(let response):
                    albumList = response
                    if let maxCount = maxPhotoCount, let maxLimit = maxPhotoLimit {
                        if maxCount >= maxLimit { completion(true) }
                        else { completion(false) }
                    }
                    else { completion(false) }
                default: completion(false)
                }
            }
        }
    }
    
    private func setupAlbumFullViewController() {
        let tabBarController = TabBarController()
        self.window?.rootViewController = PophoryNavigationController(rootViewController: tabBarController)
        self.window?.rootViewController?.showPopup(popupType: .simple,
                                                   image: ImageLiterals.img_albumfull,
                                                   primaryText: "포포리 앨범이 가득찼어요",
                                                   secondaryText: "아쉽지만,\n다음 업데이트에서 만나요!")
        self.window?.makeKeyAndVisible()
        
    }
    
    private func setupAddphotoViewcontroller() {
        let tabBarController = TabBarController()
        let addPhotoViewController = AddPhotoViewController()
        
        var imageType: PhotoCellType = .vertical
        guard let image = UIPasteboard.general.image else { return }
        if image.size.width > image.size.height {
            imageType = .horizontal
        } else {
            imageType = .vertical
        }
        
        addPhotoViewController.setupRootViewImage(forImage: image , forType: imageType)
        
        let navigationController = PophoryNavigationController(rootViewController: tabBarController)
        navigationController.pushViewController(addPhotoViewController, animated: false)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

// MARK: network

private extension SceneDelegate {
    func startMonitoringNetwork(on scene: UIScene) {
        networkMonitor.startMonitoring(statusUpdateHandler: { [weak self] connectionStatus in
            switch connectionStatus {
            case .satisfied: self?.removeNetworkErrorWindow()
            case .unsatisfied: self?.loadNetworkErrorWindow(on: scene)
            default: break
            }
        })
    }
    
    func removeNetworkErrorWindow() {
        DispatchQueue.main.async { [weak self] in
            self?.errorWindow?.resignKey()
            self?.errorWindow?.isHidden = true
            self?.errorWindow = nil
        }
    }
    
    func loadNetworkErrorWindow(on scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            DispatchQueue.main.async { [weak self] in
                let window = UIWindow(windowScene: windowScene)
                window.windowLevel = .statusBar
                window.makeKeyAndVisible()
                let noNetworkView = NoNetworkView(frame: window.bounds)
                window.addSubview(noNetworkView)
                self?.errorWindow = window
            }
        }
    }
}
