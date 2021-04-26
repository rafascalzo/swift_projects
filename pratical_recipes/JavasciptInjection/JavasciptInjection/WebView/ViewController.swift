//
//  ViewController.swift
//  JavasciptInjection
//
//  Created by Rafael Scalzo on 31/12/19.
//  Copyright © 2019 Rafael Scalzo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        let source = Bundle.main
        guard let htmlURL = source.url(forResource: "JavasciptInjection", withExtension: "html") else
        { return }
        let javascript = getScript()
        
        let config = WKWebViewConfiguration()
        
        let script = WKUserScript(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        
        config.userContentController.addUserScript(script)
        config.userContentController.add(self,name: "clickListener")
        
        webView = WKWebView(frame: .zero, configuration: config)
        view.addSubview(webView)
        webView.frame = view.frame
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL)
        // Do any additional setup after loading the view.
    }
    
    func getScript() -> String {
        if let filePath = Bundle.main.path(forResource: "injection", ofType: "js") {
            do {
                return try String.init(contentsOfFile: filePath)
            } catch let error {
                print(error.localizedDescription)
                return ""
            }
        } else {
            return ""
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            completionHandler()
        }))
        present(ac, animated: true)
    }
    //    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
    //        completionHandler(true)
    //    }
    //    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
    //        completionHandler(prompt)
    //    }
}

