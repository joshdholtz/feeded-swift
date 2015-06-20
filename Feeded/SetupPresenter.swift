//
//  SetupView.swift
//  Feeded
//
//  Created by Josh Holtz on 6/19/15.
//  Copyright (c) 2015 Josh Holtz. All rights reserved.
//

import Foundation
import Few

struct SetupPresenter {
	
	let view: UIView
	let viewModel: SetupViewModel
	
	func setup() {
		let component = Component<SetupViewModel>(initialState: viewModel, render: SetupPresenter.render)
		component.addToView(view)
	}
	
	private static func render(component: Component<SetupViewModel>, viewModel: SetupViewModel) -> Element {
		return View(backgroundColor: Colors.midnightBlue)
			.justification(.FlexStart)
			.childAlignment(.Center)
			.direction(.Column)
			.children([
				
				// Label
				Label("Welcome to Feeded!",
					textColor: UIColor.whiteColor(),
					font: UIFont.boldSystemFontOfSize(26))
					.margin(Edges(left: 0, right: 0, bottom: 10, top: 100)),
				
				// Input
				{ () -> Input in
					let i = Input(
						textColor: UIColor.whiteColor(),
						placeholder: "Enter your pet's name",
						textChanged: { text in
							component.updateState { _ in
								var updatedViewModel = viewModel
								updatedViewModel.name = text
								return updatedViewModel
							}
						},
						shouldReturn: { text in
							viewModel.finishSetup()
							return true
						}
					)
					i.width(250)
					return i
					}()
				])
	}

	
}