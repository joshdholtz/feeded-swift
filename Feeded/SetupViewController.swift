//
//  SetupViewController.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
	
	var viewModel: SetupViewModel {
		return SetupViewModel(onAction: onAction)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Creating presenter
		let presenter = SetupPresenter(view: view, viewModel: viewModel)
		presenter.setup()
    }
	
	private func onAction(viewModel: SetupViewModel, action: SetupViewModel.Action) {
		switch action {
		case .SetupFinished:
			self.dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
}