
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the ContactView VIPER module
final class ContactViewModule {

	// MARK: - Variables

	private(set) lazy var interactor: ContactViewInteractor = {
		return ContactViewInteractor()
	}()

	private(set) lazy var router: ContactViewRouter = {
		return ContactViewRouter()
	}()

	private(set) lazy var presenter: ContactViewPresenter = {
		return ContactViewPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: ContactViewViewController = {
		return ContactViewViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension ContactViewModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
