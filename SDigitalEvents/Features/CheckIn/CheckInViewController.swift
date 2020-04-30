//
//  CheckInViewController.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    private let presenter: CheckInPresenter
    
    init(presenter: CheckInPresenter) {
        self.presenter = presenter

        super.init(nibName: "CheckInViewController", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(self)
        setupKeyboardButton(with: "OK")
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    private func setupKeyboardButton(with title: String) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: title, style: .done, target: self, action: #selector(hideKeyBoard))
        
        let items = [flexSpace, done, flexSpace]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textFieldName.inputAccessoryView = doneToolbar
        textFieldEmail.inputAccessoryView = doneToolbar
        textFieldName.reloadInputViews()
        textFieldEmail.reloadInputViews()
    }
    
    @objc private func hideKeyBoard(sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
    
    @IBAction func checkInTouched(_ sender: Any) {
        presenter.checkInUser(name: textFieldName.text, email: textFieldEmail.text)
    }
}

extension CheckInViewController: CheckInView {
    func setTitle(_ text: String){
        labelTitle.text = text
    }
    
    func setPrice(_ value: String) {
        labelPrice.text = value
    }
    
    func setDiscount(_ value: String) {
        labelDiscount.text = value
    }
    
    func setTotal(_ value: String) {
        labelTotal.text = value
    }
    
    func showLoadingFeedback() {
        Loading.start()
    }
    
    func hideLoadingFeedback() {
        Loading.stop()
    }
    
    func presentMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}
