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
import AppTrackingTransparency

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
        requestTrackingAuthorization()
        
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
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    private func requestTrackingAuthorization() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { (status) in
                    switch status {
                    case .notDetermined:
                        print("notDetermined") // 결정되지 않음
                    case .restricted:
                        print("restricted") // 제한됨
                    case .denied:
                        print("denied") // 거부됨
                    case .authorized:
                        print("authorized") // 허용됨
                    @unknown default:
                        print("error") // 알려지지 않음
                    }
                }
            }
        }
        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
                    // Initialize the Google Mobile Ads SDK.
                    // TODO: 배포 후 실제 admobID로 변경
                    //        GADMobileAds.sharedInstance().start(completionHandler: nil)
                    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers =
                    [ "89ad6e2f5e35327a7987a9a5dc2a1149" ]      // testID
                })
            }
        }
    }
}

