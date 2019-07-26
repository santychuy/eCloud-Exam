//
//  ViewController.swift
//  eCloud-Example
//
//  Created by Jesus Santiago Carrasco Campa on 7/25/19.
//  Copyright © 2019 Techson. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField! {
        didSet{
            usernameTF.placeholder = "Username"
        }
    }
    
    @IBOutlet weak var passwordTF: UITextField! {
        didSet{
            passwordTF.placeholder = "Password"
            passwordTF.textContentType = .password
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var btnIniciar: UIButton! {
        didSet{
            btnIniciar.layer.cornerRadius = 5
            btnIniciar.layer.borderWidth = 1
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnIniciarAction(_ sender: Any) {
        SVProgressHUD.show()
        
        guard let username = usernameTF.text else {return}
        guard let password = passwordTF.text else {return}
        
        if username != "" && password != ""{
            validateUser(username: username, password: password)
        }else{
            SVProgressHUD.showError(withStatus: "Falta llevar campos requeridos")
            usernameTF.text = ""
            passwordTF.text = ""
            usernameTF.becomeFirstResponder()
        }
    }
    
    private func validateUser(username:String, password: String){
        let body = ["username":username, "password":password]
        let url = "http://localhost:3000/users/login" //Esto funcionara que el simulador agarre el localhost
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).response { (response) in
            guard let statusCode = response.response?.statusCode else {return}
            if statusCode == 200{
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "segueUserValidated", sender: nil)
            }else{
                SVProgressHUD.showError(withStatus: "Usuario no valido, volver a intentar")
                self.usernameTF.text = ""
                self.passwordTF.text = ""
            }
        }
    }
    
}

