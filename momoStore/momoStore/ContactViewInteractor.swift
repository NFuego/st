

// MARK: Imports

import Foundation

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactViewInteractor` and referenced by `ContactViewPresenter`
protocol ContactViewPresenterInteractorProtocol {
	/// Requests the title for the presenter
	func requestTitle()
}

// MARK: -

/// The Interactor for the ContactView module
final class ContactViewInteractor {

	// MARK: - Variables

	weak var presenter: ContactViewInteractorPresenterProtocol?
}

// MARK: - ContactView Presenter to Interactor Protocol

extension ContactViewInteractor: ContactViewPresenterInteractorProtocol {

	func requestTitle() {
		presenter?.set(title: "ContactView")
	}
}
