//
//  ViewController.swift
//  AppBackFront
//
//  Created by Victor Nasser on 04/07/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var loginView: LoginView?
    var auth: Auth?
    var alert: AlertController?
    
    override func loadView() {
        loginView = LoginView()
        alert = AlertController(controller: self)
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyBoard()
        auth = Auth.auth()
        loginView?.delegate(delegate: self)
        loginView?.configTextFieldsDelegate(delegate: self)
        isEnabledLoginButton(false)
    }
    
    func validateTextFields() {
        if (loginView?.emailTextField.text ?? "").isValid(validType: .email) && (loginView?.passwordTextField.text ?? "").isValid(validType: .password) {
            // Habilitado
            isEnabledLoginButton(true)
        } else {
            // Desabilitado
            isEnabledLoginButton(false)
        }
    }
    
    func isEnabledLoginButton(_ isEnabled: Bool) {
        if isEnabled {
            loginView?.loginButton.setTitleColor(.white, for: .normal)
            loginView?.loginButton.isEnabled = true
            loginView?.subLoginButtonImageView.alpha = 1
        } else {
            loginView?.loginButton.setTitleColor(.lightGray, for: .normal)
            loginView?.loginButton.isEnabled = false
            loginView?.subLoginButtonImageView.alpha = 0.4
        }
    }
    
    
}

extension LoginViewController: LoginViewProtocol {
    func tappedLoginButton() {
        auth?.signIn(withEmail: loginView?.emailTextField.text ?? "", password: loginView?.passwordTextField.text ?? "", completion: { user, error in
            if error != nil {
                // se erro diferente de nil, logo tem erro
                print(error?.localizedDescription ?? "")
                self.alert?.getAlert(title: "Falha no Login", message: error?.localizedDescription ?? "")
            } else {
                // sucesso
                print("sucesso na autenticação")
            }
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            textField.layer.borderWidth = 1.5
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            switch textField {
            case self.loginView?.emailTextField:
                if (loginView?.emailTextField.text ?? "").isValid(validType: .email) {
                    loginView?.emailTextField.layer.borderWidth = 1
                    loginView?.emailTextField.layer.borderColor = UIColor.white.cgColor
                } else {
                    loginView?.emailTextField.layer.borderWidth = 1.5
                    loginView?.emailTextField.layer.borderColor = UIColor.red.cgColor
                }
            case self.loginView?.passwordTextField:
                if (loginView?.passwordTextField.text ?? "").isValid(validType: .password) {
                    loginView?.passwordTextField.layer.borderWidth = 1
                    loginView?.passwordTextField.layer.borderColor = UIColor.white.cgColor
                } else {
                    loginView?.passwordTextField.layer.borderWidth = 1.5
                    loginView?.passwordTextField.layer.borderColor = UIColor.red.cgColor
                }
            default:
                break
            }
        }
        validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
