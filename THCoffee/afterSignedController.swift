//
//  afterSignedController.swift
//  THCoffee
//
//  Created by yan on 2/20/23.
//
//
import FirebaseAuth
import GoogleSignIn
import UIKit

class afterSignedController: UIViewController, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
    @IBOutlet weak var Infos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        Infos.text = "user name is \(currentUser?.displayName ?? "") and email is \(currentUser?.email ?? "")"
        Infos.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
