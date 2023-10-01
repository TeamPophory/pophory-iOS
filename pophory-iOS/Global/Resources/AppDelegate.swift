//
//  AppDelegate.swift
//  ZKFace
//
//  Created by Danna Lee on 2023/05/19.
//
import AuthenticationServices
import UIKit

import Firebase
import Sentry
import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: - FireBase SDK 초기화
        FirebaseApp.configure()
        
        // MARK: - Sentry SDK 관련
        SentrySDK.start { options in
            if let dsn = Bundle.main.infoDictionary?["SENTRY_DSN"] as? String {
                options.dsn = dsn
            }
            options.debug = true
            options.tracesSampleRate = 1.0
        }
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
//    func showCustomTrackingAuthorizationDialog() {
//        let alertController = UIAlertController(
//            title: "광고 추적 권한 요청",
//            message: "이 앱은 광고 추적을 사용하여 광고를 타겟팅하고 개인 정보를 수집합니다. 광고 추적을 허용하시겠습니까?",
//            preferredStyle: .alert
//        )
//
//        let allowAction = UIAlertAction(title: "허용", style: .default) { _ in
//            // 사용자가 허용을 선택한 경우 처리
//            // 광고 타겟팅 또는 추적 기능을 활성화할 수 있습니다.
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                if #available(iOS 14, *) {
//                    ATTrackingManager.requestTrackingAuthorization { status in
//                        switch status {
//                        case .authorized:           // 허용됨
//                            print("Authorized")
//                            let identifier = ASIdentifierManager.shared().advertisingIdentifier
//                            let idfaString = identifier.uuidString
//
//                            print("IDFA: \(idfaString)")
//                            print("IDFA = \(ASIdentifierManager.shared().advertisingIdentifier)")
//                        case .denied:               // 거부됨
//                            print("Denied")
//                        case .notDetermined:        // 결정되지 않음
//                            print("Not Determined")
//                        case .restricted:           // 제한됨
//                            print("Restricted")
//                        @unknown default:           // 알려지지 않음
//                            print("Unknow")
//                        }
//                    }
//                }
//            }
//        }
//
//        let denyAction = UIAlertAction(title: "거부", style: .destructive) { _ in
//            // 사용자가 거부를 선택한 경우 처리
//            // 광고 타겟팅 또는 추적 기능을 비활성화하거나 대체 로직을 수행할 수 있습니다.
//        }
//
//        alertController.addAction(allowAction)
//        alertController.addAction(denyAction)
//
//        // 다이얼로그를 표시합니다.
//        DispatchQueue.main.async {
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
}

