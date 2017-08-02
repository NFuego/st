//  RootModule.swift
//  Project: momoStore
//
//  Module: Root
//  MomoDidi 2016年

// MARK: Imports
import UIKit
import SwiftyVIPER

// MARK: -
/// Used to initialize the Root VIPER module
final class RootModule {

	// MARK: - Variables

	private(set) lazy var interactor: RootInteractor = {
		return RootInteractor()
	}()

	private(set) lazy var router: RootRouter = {
		return RootRouter()
	}()

	private(set) lazy var presenter: RootPresenter = {
		return RootPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: RootViewController = {
        let rootVC = RootViewController(presenter: self.presenter)
        rootVC.setViewControllers([ UINavigationController(rootViewController:MonthModule().view),
//                                    UINavigationController(rootViewController: WeekModule().view),
                                    UINavigationController(rootViewController: CustomerDayModule().view),
                                    UINavigationController(rootViewController: PetListModule().view),
                                    UINavigationController(rootViewController: ContactsModule().view),
                                    UINavigationController(rootViewController: PlanModule().view)
                                    ],animated: true)
        rootVC.selectedIndex = 2
		return rootVC
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol
extension RootModule: ModuleProtocol {
	var viewController: UIViewController {return view}
}
