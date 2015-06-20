//
//  SetupViewModel.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import Foundation

struct SetupViewModel {
	
	enum Action {
		case SetupFinished
	}
	
	typealias OnAction = (SetupViewModel, Action) -> ()
	
	var name: String?
	var onAction: OnAction
	
	// MARK: Public
	
	init(onAction: OnAction) {
		self.onAction = onAction
		
		unregisterForPushNotifications()
		AppDelegate.shared().setName(nil)
	}
	
	func finishSetup() {
		if let name = name {
			saveName(name)
			registerForPushNotifications(name)
			
			onAction(self, .SetupFinished)
		}
	}
	
	// MARK: Private
	
	private func saveName(name: String) {
		AppDelegate.shared().setName(name)
	}
	
	private func unregisterForPushNotifications() {
		let currentInstallation = PFInstallation.currentInstallation()
		if let channels = currentInstallation.channels {
			currentInstallation.removeObjectsInArray(channels, forKey: "channels")
			currentInstallation.saveInBackgroundWithBlock(nil)
		}
	}
	
	private func registerForPushNotifications(name: String) {
		
		// Register for remote notifications
		let notificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
		let settings = UIUserNotificationSettings(forTypes: notificationType, categories: nil)
		
		let application = UIApplication.sharedApplication()
		application.registerUserNotificationSettings(settings)
		application.registerForRemoteNotifications()
		
		// Add channel
		let currentInstallation = PFInstallation.currentInstallation()
		currentInstallation.addUniqueObject(name, forKey: "channels")
		currentInstallation.saveInBackgroundWithBlock(nil)
	}
	
}