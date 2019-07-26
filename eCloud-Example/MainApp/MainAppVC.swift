//
//  MainAppVC.swift
//  eCloud-Example
//
//  Created by Jesus Santiago Carrasco Campa on 7/25/19.
//  Copyright © 2019 Techson. All rights reserved.
//

import UIKit
import SVProgressHUD
import FittedSheets
import Alamofire

class MainAppVC: UIViewController {

    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var btnMandar: UIButton! {
        didSet{
            btnMandar.layer.cornerRadius = 5
            btnMandar.layer.borderWidth = 1
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMandarAction(_ sender: Any) {
        SVProgressHUD.show()
        
        if messageTF.text != "" {
            let message = messageTF.text
            let body = ["message":message]
            let url = "http://localhost:3000/users/message" //Esto funcionara que el simulador agarre el localhost
            Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).response { (response) in
                guard let statusCode = response.response?.statusCode else {return}
                if statusCode == 200{
                    SVProgressHUD.showSuccess(withStatus: "Mensaje enviado!")
                    self.messageTF.text = ""
                }else{
                    SVProgressHUD.showError(withStatus: "Error en mandar mensaje")
                }
            }
        } else {SVProgressHUD.showError(withStatus: "Escribir un mensaje")}
    }
    
    @IBAction func btnMostrarMapa(_ sender: Any) {
        let mapaVC = MapaVC()
        let sheetController = SheetViewController(controller: mapaVC, sizes: [.halfScreen])
        self.present(sheetController, animated: false, completion: nil)
    }
    
    
}
