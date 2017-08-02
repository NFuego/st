// MARK: Imports
import UIKit
import SwiftyVIPER
import SwiftyTimer

// MARK: Protocols

/// Should be conformed to by the `MonthPresenter` and referenced by `MonthViewController`
protocol MonthViewPresenterProtocol: ViewPresenterProtocol {
}

/// Should be conformed to by the `MonthPresenter` and referenced by `MonthInteractor`
protocol MonthInteractorPresenterProtocol: class {
	/** Sets the title for the presenter
	- parameters:
		- title The title to set
	*/
	func setup()
}

// MARK: -

/// The Presenter for the Month module
final class MonthPresenter {

	// MARK: - Constants

	let router: MonthPresenterRouterProtocol
	let interactor: MonthPresenterInteractorProtocol


	// MARK: Variables
	weak var view: MonthPresenterViewProtocol?

	// MARK: Inits
	init(router: MonthPresenterRouterProtocol, interactor: MonthPresenterInteractorProtocol) {
		self.router = router
		self.interactor = interactor
	}
}

// MARK: - Month View to Presenter Protocol
extension MonthPresenter: MonthViewPresenterProtocol {

	func viewLoaded() {
//        Timer.every(1.seconds) {
//            print("Timer p:\(self.interactor.pre())")
//        }
		interactor.loadStoreSchedule()
	}

	func viewAppearing() {

	}

	func viewAppeared() {

	}

	func viewDisappeared() {

	}
}

// MARK: Month Interactor to Presenter Protocol
extension MonthPresenter: MonthInteractorPresenterProtocol {
	func setup() {
        print("Interactor called \(view)")
		view?.setup()
	}
}
