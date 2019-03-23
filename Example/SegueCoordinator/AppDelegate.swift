//
//  AppDelegate.swift
//  SegueCoordinator
//
//  Created by Евгений Сафронов on 01/25/2017.
//  Copyright (c) 2017 Евгений Сафронов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootNavigationController = UINavigationController()
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()

        mainCoordinator = MainCoordinator(rootNavigationController: rootNavigationController)
        mainCoordinator?.start()
        return true
    }
}

