//
//  AppDelegate.swift
//  Feeded
//
//  Created by Josh Holtz on 6/16/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	static func shared() -> AppDelegate {
		return UIApplication.sharedApplication().delegate as! AppDelegate
	}

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

		// Setup Parse
		Parse.setApplicationId(Environment.parseApplicationId, clientKey: Environment.parseClientKey)
		
		// Default styles
		UINavigationBar.appearance().barTintColor = Colors.wetAsphalt
		UINavigationBar.appearance().tintColor = Colors.clouds
		UINavigationBar.appearance().titleTextAttributes = [
			NSForegroundColorAttributeName: Colors.clouds
		]
		
		// Status bar
		UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
		
		return true
	}
	
	func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
		let currentInstallation = PFInstallation.currentInstallation()
		currentInstallation.setDeviceTokenFromData(deviceToken)
		currentInstallation.saveInBackgroundWithBlock(nil)
	}
	
	func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
		// TODO: Need to send notification to update UI
	}

}

private let nameKey = "name"
extension AppDelegate {
	
	func getName() -> String? {
		return NSUserDefaults.standardUserDefaults().stringForKey(nameKey)
	}
	
	func setName(name: String?) {
		if let name = name {
			NSUserDefaults.standardUserDefaults().setObject(name, forKey: nameKey)
		} else {
			NSUserDefaults.standardUserDefaults().removeObjectForKey(nameKey)
		}
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
}