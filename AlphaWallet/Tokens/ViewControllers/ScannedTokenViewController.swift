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

class ScannedTokenViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: ScannedTokenViewControllerDelegate?
    private var urlTextField =  UITextField()
    private var addressTextField =  UITextField()
    private var codeTextField =  UITextField()
    private var connectButton = UIButton()
    private var approveButton = UIButton()

    override func loadView() {
        //main view
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.applyTintAdjustment()
        navigationController?.navigationBar.prefersLargeTitles = false
        hidesBottomBarWhenPushed = true
        navigationItem.title = "Scanned QR Data"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.rightBarButtonItem = UIBarButtonItem.closeBarButton(self, selector: #selector(dismiss))
        
        //text fields
        urlTextField(width: Int(view.bounds.size.width-40))
        addressTextField(width: Int(view.bounds.size.width-40))
        codeTextField(width: Int(view.bounds.size.width-40))
        connectButtonRender(midX: Int(view.frame.midX/1.4))
        approveButtonRender(midX: Int(view.frame.midX/1.4))
    }
    
    @objc private func dismiss(_ sender: UIBarButtonItem) {
        delegate?.controller(self, didCancelSelected: sender)
    }
    
    func labelRender(labelText: String, yCoordinate: Int) {
        let label = UILabel(frame: CGRect(x: 20, y: yCoordinate, width: 230, height: 21))
        label.text = labelText
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        view.addSubview(label)
    }
    
    func urlTextField(width: Int) {
        
        labelRender(labelText: "Url", yCoordinate: 170)
        urlTextField =  UITextField(frame: CGRect(x: 20, y: 195, width: width, height: 40))
        
        urlTextField.placeholder = "Enter url here"
        urlTextField.font = UIFont.systemFont(ofSize: 15)
        urlTextField.borderStyle = UITextField.BorderStyle.roundedRect
        urlTextField.autocorrectionType = UITextAutocorrectionType.no
        urlTextField.keyboardType = UIKeyboardType.default
        urlTextField.returnKeyType = UIReturnKeyType.done
        urlTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        urlTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        urlTextField.delegate = self
        
        view.addSubview(urlTextField)
    }
    
    func addressTextField(width: Int) {
        
        labelRender(labelText: "Address", yCoordinate: 250)
        addressTextField =  UITextField(frame: CGRect(x: 20, y: 275, width: width, height: 40))
        
        addressTextField.placeholder = "Enter address here"
        addressTextField.font = UIFont.systemFont(ofSize: 15)
        addressTextField.borderStyle = UITextField.BorderStyle.roundedRect
        addressTextField.autocorrectionType = UITextAutocorrectionType.no
        addressTextField.keyboardType = UIKeyboardType.default
        addressTextField.returnKeyType = UIReturnKeyType.done
        addressTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        addressTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        addressTextField.delegate = self
        view.addSubview(addressTextField)
    }
    
    func codeTextField(width: Int) {
        labelRender(labelText: "Code", yCoordinate: 330)
        codeTextField =  UITextField(frame: CGRect(x: 20, y: 355, width: width, height: 40))
        
        codeTextField.placeholder = "Enter code here"
        codeTextField.font = UIFont.systemFont(ofSize: 15)
        codeTextField.borderStyle = UITextField.BorderStyle.roundedRect
        codeTextField.autocorrectionType = UITextAutocorrectionType.no
        codeTextField.keyboardType = UIKeyboardType.default
        codeTextField.returnKeyType = UIReturnKeyType.done
        codeTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        codeTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        codeTextField.delegate = self
        view.addSubview(codeTextField)
    }
    
    func connectButtonRender(midX: Int) {
        connectButton = UIButton(frame: CGRect(x: midX, y: 400, width: 100, height: 50))
        connectButton.setTitle("Connect", for: .normal)
        connectButton.setTitleColor(UIColor.blue, for: .normal)
        connectButton.addTarget(self, action: #selector(connectButtonPressed), for: .touchUpInside)
        view.addSubview(connectButton)
    }
    
    func approveButtonRender(midX: Int) {
        approveButton = UIButton(frame: CGRect(x: midX, y: 430, width: 100, height: 50))
        approveButton.setTitle("Approve", for: .normal)
        approveButton.setTitleColor(UIColor.lightGray, for: .normal)
        approveButton.addTarget(self, action: #selector(approveButtonPressed), for: .touchUpInside)
        view.addSubview(approveButton)
    }
    
    @objc func connectButtonPressed() {
        print(urlTextField.text!, "url")
        print(addressTextField.text!, "address")
        print(codeTextField.text!, "code")
    }
    
    @objc func approveButtonPressed() {
        //ToDo
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
}

