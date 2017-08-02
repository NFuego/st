

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemoAddFormInteractor` and referenced by `MemoAddFormPresenter`
protocol MemoAddFormPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the MemoAddForm module
final class MemoAddFormInteractor {

	// MARK: - Variables

	weak var presenter: MemoAddFormInteractorPresenterProtocol?
}

// MARK: - MemoAddForm Presenter to Interactor Protocol

extension MemoAddFormInteractor: MemoAddFormPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "MemoAddForm")
	}
}
