//
//  ScannedTokenCoordinator.swift
//  AlphaWallet
//
//  Created by Famil Samadli on 11/4/20.
//

import UIKit

protocol ScannedTokenCoordinatorDelegate: class {
    func coordinator(_ coordinator: ScannedTokenCoordinator, didSelectToken token: TokenObject)
    func selectAssetDidCancel(in coordinator: ScannedTokenCoordinator)
}

class ScannedTokenCoordinator: Coordinator {

    private let parentsNavigationController: UINavigationController
    private lazy var viewController = ScannedTokenViewController()

    lazy var navigationController = UINavigationController(rootViewController: viewController)
    var coordinators: [Coordinator] = []
    weak var delegate: ScannedTokenCoordinatorDelegate?

    //NOTE: `filter: WalletFilter` parameter allow us to to filter tokens we need
    init(navigationController: UINavigationController) {
        self.parentsNavigationController = navigationController

        self.navigationController.hidesBottomBarWhenPushed = true
        viewController.delegate = self
    }

    func start() {
        navigationController.makePresentationFullScreenForiOS13Migration()
        parentsNavigationController.present(navigationController, animated: true)
    }
}

extension ScannedTokenCoordinator: ScannedTokenViewControllerDelegate {

    func controller(_ controller: ScannedTokenViewController, didSelectToken token: TokenObject) {
        //NOTE: for now we dismiss assets vc because then we will not able to close it, after payment flow.
        //first needs to update payment flow, make it push to navigation stack
        navigationController.dismiss(animated: true) {
            self.delegate?.coordinator(self, didSelectToken: token)
        }
    }

    func controller(_ controller: ScannedTokenViewController, didCancelSelected sender: UIBarButtonItem) {
        navigationController.dismiss(animated: true) {
            self.delegate?.selectAssetDidCancel(in: self)
        }
    }
}

