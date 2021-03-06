//
//  AppDelegate.swift
//  Carros
//
//  Created by Andre Furquin on 12/20/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var listaController: ListaCarrosViewController!
    var detalhesController: DetalhesCarroViewController!
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds);
        self.window!.backgroundColor = UIColor.whiteColor();
        let iPad = Utils.isIpad()
        if (iPad) {
            self.initIpad()
        } else {
            self.initIphone()
        }
        
        let db = CarroDB()
        db.createTable()
        db.close()
        self.window!.makeKeyAndVisible();
        return true
    }
    
    // Tab Bar
    func initIphone(){
        
        // Cria os controllers
        let listaController = ListaCarrosViewController(nibName: "ListaCarrosViewController", bundle: nil);
        let sobreController = SobreViewController(nibName: "SobreViewController", bundle: nil);
        let nav1 = MyNavigationController()
        let nav2 = MyNavigationController()
        // Insere ambos os view controller em navigations contorller
        nav1.pushViewController(listaController, animated: false)
        nav2.pushViewController(sobreController, animated: false)
        // Cria o TabBar
        let tabBarController = MyTabBarController()
        tabBarController.viewControllers = [nav1, nav2]
        nav1.tabBarItem.title = "Carros"
        nav1.tabBarItem.image = UIImage(named: "tab_carros.png")
        nav2.tabBarItem.title = "Sobre"
        nav2.tabBarItem.image = UIImage(named: "tab_sobre.png")
        // Configura o UITabBarController como o view controller principal
        self.window!.rootViewController = tabBarController
    }
    
    // Split View
    func initIpad(){
        // Cria os controllers da esquerda e da direita
        self.detalhesController = DetalhesCarroViewController(nibName: "DetalhesCarroViewController", bundle: nil)
        self.listaController = ListaCarrosViewController(nibName: "ListaCarrosViewController", bundle: nil)
        
        let nav1  = MyNavigationController()
        let nav2 = MyNavigationController()
        nav1.pushViewController(listaController, animated: false)
        nav2.pushViewController(detalhesController, animated: false)
        // Cria o UISplitController
        let split = UISplitViewController()
        // Para compilar precisa fazer DetalhesCarroViewController implementar UISplitViewControllerDelegate
        split.delegate = detalhesController
        split.viewControllers = [nav1, nav2]
        // Deixa o UISplitViewController como o controller principal
        self.window!.rootViewController = split
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

