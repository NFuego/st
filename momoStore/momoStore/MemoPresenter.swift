

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemoPresenter` and referenced by `MemoViewController`
protocol MemoViewPresenterProtocol: ViewPresenterProtocol {

}

/// Should be conformed to by the `MemoPresenter` and referenced by `MemoInteractor`
protocol MemoInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the Memo module
final class MemoPresenter {

	// MARK: - Constants

	let router: MemoPresenterRouterProtocol
	let interactor: MemoPresenterInteractorProtocol

	// MARK: Variables

	weak var view: MemoPresenterViewProtocol?

	// MARK: Inits

	init(router: MemoPresenterRouterProtocol, interactor: MemoPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Memo View to Presenter Protocol

extension MemoPresenter: MemoViewPresenterProtocol {

	func viewLoaded() {
		interactor.requestTitle()
	}
}

// MARK: Memo Interactor to Presenter Protocol

extension MemoPresenter: MemoInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}
