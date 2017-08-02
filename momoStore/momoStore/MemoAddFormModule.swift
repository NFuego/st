
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the MemoAddForm VIPER module
final class MemoAddFormModule {

	// MARK: - Variables

	private(set) lazy var interactor: MemoAddFormInteractor = {
		return MemoAddFormInteractor()
	}()

	private(set) lazy var router: MemoAddFormRouter = {
		return MemoAddFormRouter()
	}()

	private(set) lazy var presenter: MemoAddFormPresenter = {
		return MemoAddFormPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MemoAddFormViewController = {
		return MemoAddFormViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension MemoAddFormModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
