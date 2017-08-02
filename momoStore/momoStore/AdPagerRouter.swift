//
//  AdPagerRouter.swift
//  Project: T2
//
//  Module: AdPager
//
//  By zcon 2017/3/14
//  test 2017年
//

// MARK: Imports

import UIKit

import SwiftyVIPER

// MARK: Protocols

/// Should be conformed to by the `AdPagerRouter` and referenced by `AdPagerPresenter`
protocol AdPagerPresenterRouterProtocol: PresenterRouterProtocol {

}

// MARK: -

/// The Router for the AdPager module
final class AdPagerRouter {

	// MARK: - Variables

	weak var viewController: UIViewController?
}

// MARK: - Router Protocol

extension AdPagerRouter: RouterProtocol {

}

// MARK: AdPager Presenter to Router Protocol

extension AdPagerRouter: AdPagerPresenterRouterProtocol {

}
