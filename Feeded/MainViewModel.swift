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
		
		case ShowLogout
		case ShowLogoutConfirmation
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
	
	func showConfirmation() {
		onAction(self, .ShowLogoutConfirmation)
	}
	
	func showLogout() {
		onAction(self, .ShowLogout)
	}
	
	func reset() {
		if let name = AppDelegate.shared().getName() {
		
			let query = PFQuery(className: "Feeder")
			query.whereKey("name", equalTo: name)
			query.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
				PFObject.deleteAllInBackground(objects, block: nil)
			}
			
			onAction(self, .Reset)
		}
	}
	
}