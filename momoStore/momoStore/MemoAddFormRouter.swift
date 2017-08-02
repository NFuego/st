

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemoAddFormRouter` and referenced by `MemoAddFormPresenter`
protocol MemoAddFormPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the MemoAddForm module
final class MemoAddFormRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension MemoAddFormRouter: RouterProtocol {

}

// MARK: MemoAddForm Presenter to Router Protocol

extension MemoAddFormRouter: MemoAddFormPresenterRouterProtocol {

}
