//
//  LoginViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 20/11/2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var isHaveAccount = true
    
    var userIDUpdateHandler: ((String?) -> Void)?
    
    
    let appLogoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let changeLoginModeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let appIconUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "F1_LS")
        return imageView
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "F1 Explorer"
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 18)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.emailAddress
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        textField.textColor = .label
        textField.font = .systemFont(ofSize: 18)
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SIGN IN", for: .normal)
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let loginErrorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = ""
        label.numberOfLines = 2
        return label
    }()
    
    let accountExistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Don't have an account?"
        return label
    }()
    
    let changeSignButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signModeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.addSubview(appLogoStackView)
        view.addSubview(changeLoginModeStackView)
        
        appLogoStackView.addArrangedSubview(appIconUIImageView)
        appLogoStackView.addArrangedSubview(appNameLabel)
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(loginErrorLabel)
        
        changeLoginModeStackView.addArrangedSubview(accountExistLabel)
        changeLoginModeStackView.addArrangedSubview(changeSignButton)
        
        applyConstraints()
    }
    
    @objc private func loginButtonTapped() {
        if isHaveAccount {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error == nil {
                    self.dismiss(animated: true) {
                        self.userIDUpdateHandler?(authResult?.user.uid)
                    }
                } else {
                    self.loginErrorLabel.text = error?.localizedDescription
                }
            }
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.loginErrorLabel.text = error?.localizedDescription
                }
            }
        }
    }
    
    @objc private func signModeButtonTapped() {
        loginButton.setTitle(isHaveAccount ? "SIGN UP" : "SIGN IN", for: .normal)
        accountExistLabel.text = isHaveAccount ? "Already have an account?" : "Don't have an account?"
        changeSignButton.setTitle(isHaveAccount ? "Sign In" : "Sign Up", for: .normal)
        isHaveAccount.toggle()
    }
    
    @objc private func closeVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func applyConstraints(){
        let appLogoStackViewConstraints = [
            appLogoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appLogoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogoStackView.widthAnchor.constraint(equalToConstant: 200),
            appLogoStackView.heightAnchor.constraint(equalToConstant: 55)
        ]
        let loginErrorLabelConstraints = [
            loginErrorLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -15),
            loginErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            loginErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ]
        let emailTextFieldConstraints = [
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -15),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ]
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            passwordTextField.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        let loginButtonConstraints = [
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        let changeLoginModeStackViewConstraints = [
            changeLoginModeStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            changeLoginModeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(appLogoStackViewConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(loginErrorLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
        NSLayoutConstraint.activate(changeLoginModeStackViewConstraints)
        
        if view.frame.width > view.frame.height {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .done, target: self, action: #selector(closeVC))
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .done, target: self, action: #selector(closeVC))
        }
    }
    
}
