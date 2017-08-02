
// MARK: Imports
import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactViewPresenter` and referenced by `ContactViewViewController`
protocol ContactViewViewPresenterProtocol: ViewPresenterProtocol {
    func viewAppeared() 
}

/// Should be conformed to by the `ContactViewPresenter` and referenced by `ContactViewInteractor`
protocol ContactViewInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func set(title: String?)
}

// MARK: -

/// The Presenter for the ContactView module
final class ContactViewPresenter {
	// MARK: - Constants
	let router: ContactViewPresenterRouterProtocol
	let interactor: ContactViewPresenterInteractorProtocol

	// MARK: Variables
	weak var view: ContactViewPresenterViewProtocol?

	// MARK: Inits
	init(router: ContactViewPresenterRouterProtocol, interactor: ContactViewPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - ContactView View to Presenter Protocol

extension ContactViewPresenter: ContactViewViewPresenterProtocol {
	func viewLoaded() {
		interactor.requestTitle()
	}


}

// MARK: ContactView Interactor to Presenter Protocol

extension ContactViewPresenter: ContactViewInteractorPresenterProtocol {

	func set(title: String?) {
		view?.set(title: title)
	}
}


