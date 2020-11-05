//
//  ScannedTokenViewController.swift
//  AlphaWallet
//
//  Created by Famil Samadli on 11/4/20.
//

import UIKit
import StatefulViewController

protocol ScannedTokenViewControllerDelegate: class {
    func controller(_ controller: ScannedTokenViewController, didSelectToken token: TokenObject)
    func controller(_ controller: ScannedTokenViewController, didCancelSelected sender: UIBarButtonItem)
}

class ScannedTokenViewController: UIViewController {
    weak var delegate: ScannedTokenViewControllerDelegate?

    override func loadView() {
       view = UIView()
       view.backgroundColor = .white
        
        let button = UIButton(type: .custom)
        button.setTitle("Hello", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = UIColor.red.cgColor
        button.frame = CGRect(x: 50, y: 300, width: 100, height: 50)
        self.view.addSubview(button)
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.applyTintAdjustment()
        navigationController?.navigationBar.prefersLargeTitles = false
        hidesBottomBarWhenPushed = true
        navigationItem.title = "Empty label"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem.closeBarButton(self, selector: #selector(dismiss))
    }
    
    @objc private func dismiss(_ sender: UIBarButtonItem) {
        delegate?.controller(self, didCancelSelected: sender)
    }
}

