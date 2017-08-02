

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `MemoRouter` and referenced by `MemoPresenter`
protocol MemoPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the Memo module
final class MemoRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension MemoRouter: RouterProtocol {

}

// MARK: Memo Presenter to Router Protocol

extension MemoRouter: MemoPresenterRouterProtocol {

}
