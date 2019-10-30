//
//  ViewController.swift
//  DemoApp
//
//  Created by Monica Rondón on 10/30/19.
//  Copyright © 2019 Monica Rondón. All rights reserved.
//

import UIKit
import RestAPIManager

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var requestButton: UIButton!

    let restManager = RestAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activityIndicator.alpha = 0
        
        urlField.text = "https://api.exchangeratesapi.io/latest"
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let urlString = urlField.text else { return }
        request(urlString: urlString)
    }
    
    @IBAction func didTapRequest(_ sender: UIButton) {
        guard let urlString = urlField.text else { return }
        
        request(urlString: urlString)
    }
        
    func request(urlString: String) {
                
        startLoading()
        
        guard let url = URL(string: urlString) else { return showError(msg: "Failed to set URL", urlString) }
        
        restManager.makeRequest(to: url, using: .get) { results in
            
            guard let response = results.response else { DispatchQueue.main.async { self.showError(msg: "Results == nil", urlString) }; return }
            
            guard response.httpStatusCode == 200 else { DispatchQueue.main.async { self.showError(msg: "statusCode = \(response.httpStatusCode)", urlString) }; return }
            
            guard let data = results.data else { DispatchQueue.main.async { self.showError(msg: "data == nil", urlString) }; return }
            
            guard let dataString = String(data: data, encoding: .utf8) else { DispatchQueue.main.async { self.showError(msg: "Failed data -> string", urlString) }; return }
            
            DispatchQueue.main.async {
                
                self.stopLoading()
                self.responseTextView.text = dataString
                
            }
                
            
        }
        
    }
    
    
    func showError(msg: String, _ urlString: String) {
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
        let output = """
        ERROR-\(urlString)
        \(msg)
        """
        
        responseTextView.text = output
    }
    
    func showError(_ error: Error, _ urlString: String) {
        let output = """
        ERROR-\(urlString)
        \(error.localizedDescription)
        """
    
        responseTextView.text = output
    }
    
    func startLoading() {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        requestButton.isEnabled = false
    }
    
    func stopLoading() {
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
        requestButton.isEnabled = true
    }
    
    

}


public extension UITextView {
    
    func scrollToBottom() {
        guard text.isEmpty == false else { return }
        scrollRangeToVisible(NSMakeRange(text.count - 1, 1))
    }
}

