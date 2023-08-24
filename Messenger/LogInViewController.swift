//
//  ViewController.swift
//  Messenger
//
//  Created by K Praveen Kumar on 18/08/23.
//

import UIKit

class LogInViewController: UIViewController {
    
    //Label Outlet
    @IBOutlet weak var emailLabelOutlet: UILabel!
    
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    
    @IBOutlet weak var repeatPasswordLabelOutlet: UILabel!
    
    @IBOutlet weak var signupLabelOutlet: UILabel!

    //TextField Outlet
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    // Button Outlet
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    
    @IBOutlet weak var forgotPasswordButtonOutlet: UIButton!
    
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    //View Outlet
    
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    var isLogin: Bool = true
    
    //view Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIFor(logIn: true )
        setupTextFieldDelegates()
        setupBackgroundTap()
    }
    
    //Button action
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        if isDataInputedFor(type: isLogin ? "login" : "register") {
            
        }else {
            myAlertPopUp(myTitle: "Alert", myMessage: "All fields are required")
        }
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: UIButton) {
        
        if isDataInputedFor(type: "Password") {
            
        }else {
            myAlertPopUp(myTitle: "Alert", myMessage: "Email is required")
        }
        
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        
        if isDataInputedFor(type: "Password") {
            
        }else {
            myAlertPopUp(myTitle: "Alert", myMessage: "Email is required")
        }
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        updateUIFor(logIn: sender.titleLabel?.text == "Login")
        isLogin.toggle()
        
    }
    
    //Set Up
    private func setupTextFieldDelegates() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField:UITextField) {
        updatePlaceHolderLabel(textField: textField)
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
        self.dismiss(animated: false)
    }
    
    //Animation
    
    private func updateUIFor(logIn: Bool) {
        loginButtonOutlet.setImage(UIImage(named: logIn ? "loginBtn" : "registerBtn"), for: .normal)
        signUpButtonOutlet.setTitle(logIn ? "SignUp": "Login", for: .normal)
        signupLabelOutlet.text = logIn ? "Don't have an account ?": "Have an accont ?"
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordTextField.isHidden = logIn
            self.repeatPasswordLabelOutlet.isHidden = logIn
            self.repeatPasswordLineView.isHidden = logIn
        }
    }
   
    private func updatePlaceHolderLabel(textField:UITextField ) {
        switch textField {
        case emailTextField:
            if emailTextField.hasText {
                emailLabelOutlet.text = "Email"
            }
            else {
                emailLabelOutlet.text = ""
            }
        case passwordTextField:
            if passwordTextField.hasText {
                passwordLabelOutlet.text = "Password"
            }
            else {
                passwordLabelOutlet.text = ""
            }
        default:
            repeatPasswordLabelOutlet.text = textField.hasText ? "Repeat Password" : ""
        }
    }
    // Helper
    private func isDataInputedFor(type: String) -> Bool {
        switch type {
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
        case "registration":
            return emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != ""
        default:
            return emailTextField.text != ""
        }
    }
}

extension LogInViewController{
    func myAlertPopUp(myTitle: String, myMessage: String){
        let alertController = UIAlertController(title: myTitle, message: myMessage, preferredStyle: .alert)
        // Present the alert
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
