
//

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemoInteractor` and referenced by `MemoPresenter`
protocol MemoPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the Memo module
final class MemoInteractor {

	// MARK: - Variables

	weak var presenter: MemoInteractorPresenterProtocol?
}

// MARK: - Memo Presenter to Interactor Protocol

extension MemoInteractor: MemoPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "Memo")
	}
}
