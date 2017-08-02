

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `ContactViewRouter` and referenced by `ContactViewPresenter`
protocol ContactViewPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the ContactView module
final class ContactViewRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension ContactViewRouter: RouterProtocol {

}

// MARK: ContactView Presenter to Router Protocol

extension ContactViewRouter: ContactViewPresenterRouterProtocol {

}
