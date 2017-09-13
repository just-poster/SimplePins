//
//  LoginViewController.swift
//  vitaliy_yarkun_SimplePins
//
//  Created by Vitaliy Yarkun on 9/12/17.
//  Copyright © 2017 Vitaliy Yarkun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - Properties
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        var request: URLRequest?
        
        do {
            request = try Router.login(client_id: Global.facebookClientID, redirect_uri: Global.facebookRedirectURI).asURLRequest()
        } catch {
           print("Error")
        }
        guard let lRequest = request else { return }
        webView.loadRequest(lRequest)
    }

    fileprivate func getCodeParameter(from urlString: String?) {
        
        guard let urlString = urlString else { return }
        
        let separator = "code="
        guard (urlString.range(of:Global.facebookRedirectURI) != nil) &&  (urlString.range(of:separator) != nil) else { return }
        
        var array: Array<String>?
        array  = urlString.components(separatedBy: separator)
        
        if let codeString = array?.last {
            LocalStore().loginCode = codeString
        }
    }   
}

//MARK: - UIWebViewDelegate
extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        getCodeParameter(from: request.url?.absoluteString)
        return true
    }
}









