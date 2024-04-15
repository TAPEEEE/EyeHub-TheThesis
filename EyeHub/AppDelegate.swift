//
//  AppDelegate.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        func onboard() -> UIViewController {
            let isFirstLaunch = isFirstTimeOpening()
            let initialViewController: UIViewController
            
            if isFirstLaunch {
                print("First time launching the app!")
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                initialViewController = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: Bundle.main)
            } else {
                initialViewController = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
            }
            
            return initialViewController
        }
        
        let navigationController = UINavigationController(rootViewController: onboard())
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.interactivePopGestureRecognizer?.delegate = nil
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }
    
    func isFirstTimeOpening() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isFirstLaunch")
    }
}
