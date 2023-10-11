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
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if let userActivity = connectionOptions.userActivities.first {
            self.scene(scene, continue: userActivity)
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
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
                
                let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                var rootViewController: UIViewController
                
                if isLoggedIn {
                    let addPhotoViewController = AddPhotoViewController()
                    
                    var imageType: PhotoCellType = .vertical
                    guard let image = UIPasteboard.general.image else { return }
                    if image.size.width > image.size.height {
                        imageType = .horizontal
                    } else {
                        imageType = .vertical
                    }
                    
                    addPhotoViewController.setupRootViewImage(forImage: image , forType: imageType)
                    
                    rootViewController = addPhotoViewController
                } else {
                    let appleLoginManager = AppleLoginManager()
                    let rootVC = OnboardingViewController(appleLoginManager: appleLoginManager)
                    appleLoginManager.delegate = rootVC
                    
                    rootViewController = rootVC
                }
                window?.rootViewController = PophoryNavigationController(rootViewController: rootViewController)
                window?.makeKeyAndVisible()
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    @objc func setupRoot() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        var rootViewController: UIViewController
        
        if isLoggedIn {
            rootViewController = TabBarController()
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
    
    func setRootViewController() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        var rootViewController: UIViewController
        
        if isLoggedIn {
            let tabBarViewController = UITabBarController()
            rootViewController = tabBarViewController
        } else {
            let loginViewController = NameInputViewController()
            rootViewController = loginViewController
        }
        
        window?.rootViewController = rootViewController
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
