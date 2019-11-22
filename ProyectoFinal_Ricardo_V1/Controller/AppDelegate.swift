//
//  AppDelegate.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 10/4/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userEmail : String = ""
    var allDonations = [Donaccion]()
    var donationsList = DonationsList()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProyectoFinal_Ricardo_V1")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved error: \(error), \(error.userInfo)")
                
            }
        })
        return container
    }()
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let context = self.persistentContainer.viewContext
        do{
            self.allDonations = try context.fetch(Donaccion.fetchRequest()) as! [Donaccion]
            donationsList.allDonations = self.allDonations
        }catch let error as NSError{
            print("could not fetch, \(error)")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.saveContext()
    }


}

