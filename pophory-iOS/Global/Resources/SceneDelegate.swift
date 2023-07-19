//
//  SceneDelegate.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//

import UIKit

import FirebaseDynamicLinks

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let userActivity = connectionOptions.userActivities.first {
            self.scene(scene, continue: userActivity)
        }
        
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
        // Link 처리
        var shareID: String?
        if let url = userActivity.webpageURL {
            let handled = DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
                // 👉 동적링크에서 파라미터를 다루는 함수. 아래에서 살펴보겠습니다.
                if let cardID = self.handleDynamicLink(dynamicLink) {
                    shareID = cardID
                }
            }
        }
        let rootVC = ShareViewController()
        

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
    
    func extractQueryParameters(from url: URL) -> [String: String]? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters: [String: String] = [:]
        for queryItem in queryItems {
            if let value = queryItem.value {
                parameters[queryItem.name] = value
            }
        }
        
        return parameters
    }
    
    private func handleDynamicLink(_ dynamicLink: DynamicLink?) -> String? {
        // 앱으로 전달되는 url 을 얻을 수 있다.(딥링크)
        guard let dynamicLink = dynamicLink,
              let link = dynamicLink.url else { return nil }
        
        // resolvingAgainstBaseURL : URL 구문을 분석하기 전에 URl 에 대해 확인하는지 여부를 제어.
        // true 이고, url parameter 에 상대적인 URl 이 포함되어 있다면 absoluteURL 메서드를 호출해서 original URl 에 대해서 확인합니다. 그렇지 않으면, 문자열 부분이 자체적으로 사용됩니다.
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
    
