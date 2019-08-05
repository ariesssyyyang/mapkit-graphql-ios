//
//  AppDelegate.swift
//  MapKitPractice
//
//  Created by Aries Yang on 2019/8/4.
//  Copyright © 2019 Aries Yang. All rights reserved.
//

import UIKit
import Apollo

let apollo: ApolloClient = {
    let configuration = URLSessionConfiguration.default
    let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let configData = FileManager.default.contents(atPath: path)!
    let configDictionary = try! PropertyListSerialization.propertyList(
        from: configData,
        options: .mutableContainersAndLeaves,
        format: nil
    ) as! [String: String]
    configuration.httpAdditionalHeaders = [
        "Authorization": "Bearer \(String(describing: configDictionary["API_KEY"]!))",
        "Accept-Language": "zh_TW"
    ]
    let networkTransport = HTTPNetworkTransport(
        url: URL(string: "https://api.yelp.com/v3/graphql")!,
        configuration: configuration)
    return ApolloClient(networkTransport: networkTransport)
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        apollo.cacheKeyForObject = { $0["id"] }
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
    }


}

