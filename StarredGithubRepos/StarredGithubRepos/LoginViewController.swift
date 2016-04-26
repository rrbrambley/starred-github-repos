//
//  LoginViewController.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/25/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import OctoKit
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var submitButton: UIBarButtonItem!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubmitButton()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TwoFactor" {
            let controller: TwoFactorViewController = segue.destinationViewController as! TwoFactorViewController;
            controller.username = self.usernameTextField.text
            controller.password = self.passwordTextField.text
        }
    }
    
    //MARK: Actions
    
    func didTapSubmitButton() {
        signIn(nil)
    }
    
    //MARK: Internal
    
    private func addSubmitButton() {
        submitButton = UIBarButtonItem(title: "login:submit".localized, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(didTapSubmitButton))
        navigationItem.rightBarButtonItem = submitButton
    }
    
    private func signIn(oneTimePassword: String?) {
        let user:OCTUser = OCTUser(rawLogin: usernameTextField.text, server: OCTServer.dotComServer())
        let (clientID, clientSecret) = GithubClientUtility.clientIDAndSecret()
        
        OCTClient.setClientID(clientID, clientSecret: clientSecret)
        OCTClient.signInAsUser(user, password: passwordTextField.text, oneTimePassword: oneTimePassword, scopes:OCTClientAuthorizationScopes.PublicRepository, note: nil, noteURL: nil, fingerprint: nil).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext(
            { (client: AnyObject!) -> Void in
                self.didAuthenticateWithClient(client as! OCTClient)
            },
            error: { (error: NSError!) -> Void in
                print(error.localizedDescription)
                if error.domain == OCTClientErrorDomain &&
                    error.code == OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired {
                    self.performSegueWithIdentifier("TwoFactor", sender: self)
                } else {
                    self.showError(error)
                }
            }
        )
    }
    
    private func didAuthenticateWithClient(client: OCTClient) {
        GithubAuthParams.save(client.token, username: client.user.rawLogin)
        GithubDataManager.sharedInstance.initClient()
        AppDelegate.sharedDelegate().updateApplicationState()
    }
    
    private func showError(error: NSError) {
        //TODO
    }

}