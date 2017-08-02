

import UIKit

import SwiftyVIPER

// MARK: -

/// Used to initialize the Memo VIPER module
final class MemoModule {

	// MARK: - Variables

	private(set) lazy var interactor: MemoInteractor = {
		return MemoInteractor()
	}()

	private(set) lazy var router: MemoRouter = {
		return MemoRouter()
	}()

	private(set) lazy var presenter: MemoPresenter = {
		return MemoPresenter(router: self.router, interactor: self.interactor)
	}()

	private(set) lazy var view: MemoViewController = {
		return MemoViewController(presenter: self.presenter)
	}()

	init() {
		presenter.view = view
		router.viewController = view
		interactor.presenter = presenter
	}
}

// MARK: - Module Protocol

extension MemoModule: ModuleProtocol {
	var viewController: UIViewController { return view }
}
