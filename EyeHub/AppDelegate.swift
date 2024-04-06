//
//  AppDelegate.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = HearingTestViewController(nibName: "HearingTestViewController", bundle: Bundle.main)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.interactivePopGestureRecognizer?.delegate = nil
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
