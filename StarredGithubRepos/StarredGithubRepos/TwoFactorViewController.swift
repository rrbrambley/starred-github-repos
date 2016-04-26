//
//  TwoFactorViewController.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/25/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import OctoKit
import UIKit

class TwoFactorViewController: UIViewController {
    
    @IBOutlet weak var codeTextField: UITextField!
    
    var username: String?
    var password: String?
    private var submitButton: UIBarButtonItem!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubmitButton()
    }
    
    //MARK: Actions
    
    func didTapSubmitButton() {
        signIn()
    }
    
    //MARK: Internal
    
    private func addSubmitButton() {
        submitButton = UIBarButtonItem(title: "login:submit".localized, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(didTapSubmitButton))
        self.navigationItem.rightBarButtonItem = submitButton
    }

    private func signIn() {
        let user:OCTUser = OCTUser(rawLogin: username, server: OCTServer.dotComServer())

        OCTClient.signInAsUser(user, password: password, oneTimePassword: codeTextField.text, scopes: OCTClientAuthorizationScopes.PublicRepository, note: nil, noteURL: nil, fingerprint: nil).deliverOn(RACScheduler.mainThreadScheduler()).subscribeNext(
            { (client: AnyObject!) -> Void in
                self.didAuthenticateWithClient(client as! OCTClient)
            },
            error: { (error: NSError!) -> Void in
                print(error.localizedDescription)
                self.showError(error)
            }
        )
    }
    
    private func didAuthenticateWithClient(client: OCTClient) {
        GithubAuthParams.save(client.token, username: client.user.rawLogin)
        AppDelegate.sharedDelegate().updateApplicationState()
    }
    
    private func showError(error: NSError) {
        //TODO
    }
}