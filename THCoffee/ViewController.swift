//
//  ViewController.swift
//  THCoffee
//
//  Created by yan on 2/3/23.
//
import FirebaseAuth
import GoogleSignIn
import UIKit
import AuthenticationServices

class ViewController: UIViewController, GIDSignInDelegate, ASAuthorizationControllerDelegate {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var appleSigninButton: ASAuthorizationAppleIDButton!
    
   
    
    // google sign in
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "afterSignedController") as! afterSignedController
                self.present(nextViewController, animated:true, completion:nil)
                
                //This is where you should add the functionality of successful login
                //i.e. dismissing this view or push the home view controller etc
            }
        }
    }
    
    

    @IBAction func googleSigninTapped(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // google signin
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
         
        //apple signin
        appleSigninButton.addTarget(self, action: #selector(appleSigninTapped), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }

   
    
    
    @objc func appleSigninTapped(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    


    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("sicces")
       
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let userIdentifier = credentials.user
            let fullName = credentials.fullName
            let email = credentials.email
            print("apple signed in\(userIdentifier)\(String(describing: fullName))\(String(describing: email) )")
            
        case let credentials as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = credentials.user
            let password = credentials.password
            
            print("apple signed in\(username)\(password)")
        default:
            break
        }
       
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}

