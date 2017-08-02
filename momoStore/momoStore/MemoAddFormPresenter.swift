//


import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemoAddFormPresenter` and referenced by `MemoAddFormViewController`
protocol MemoAddFormViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `MemoAddFormPresenter` and referenced by `MemoAddFormInteractor`
protocol MemoAddFormInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the MemoAddForm module
final class MemoAddFormPresenter {

	// MARK: - Constants

	let router: MemoAddFormPresenterRouterProtocol
	let interactor: MemoAddFormPresenterInteractorProtocol

	// MARK: Variables

	weak var view: MemoAddFormPresenterViewProtocol?

	// MARK: Inits

	init(router: MemoAddFormPresenterRouterProtocol, interactor: MemoAddFormPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - MemoAddForm View to Presenter Protocol

extension MemoAddFormPresenter: MemoAddFormViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: MemoAddForm Interactor to Presenter Protocol

extension MemoAddFormPresenter: MemoAddFormInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
