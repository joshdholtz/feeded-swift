//
//  MainViewModel.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import Foundation

struct MainViewModel {
	
	enum Action {
		case Logout
		case Reset
		
		case ShowOptions
		case ShowLogoutConfirmation
		case ShowResetConfirmation
	}
	
	typealias OnAction = (MainViewModel, Action) -> ()
	var onAction: OnAction
	var navigationItem: UINavigationItem

	// MARK: Public
	
	init(onAction: OnAction, navigationItem: UINavigationItem) {
		self.onAction = onAction
		self.navigationItem = navigationItem
	}
	
	// MARK: Private
	
	func logout() {
		onAction(self, .Logout)
	}
	
	func showLogoutConfirmation() {
		onAction(self, .ShowLogoutConfirmation)
	}
	
	func showOptions() {
		onAction(self, .ShowOptions)
	}
	
	func showResetConfirmation() {
		onAction(self, .ShowResetConfirmation)
	}
	
	func updateBadgeCount() {
		if let name = AppDelegate.shared().getName() {
			let query = PFQuery(className: "Feeder")
			query.whereKey("name", equalTo: name)
			query.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
				if let objects = objects {
					UIApplication.sharedApplication().applicationIconBadgeNumber = count(objects)
				} else {
					UIApplication.sharedApplication().applicationIconBadgeNumber = 0
				}
			}
		} else {
			UIApplication.sharedApplication().applicationIconBadgeNumber = 0
		}
	}
	
	func reset() {
		if let name = AppDelegate.shared().getName() {
			let query = PFQuery(className: "Feeder")
			query.whereKey("name", equalTo: name)
			query.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
				PFObject.deleteAllInBackground(objects) { (success, error) -> Void in
					self.updateBadgeCount()
				}
			}
			
			onAction(self, .Reset)
		}
	}
	
}