//
//  DetailViewController.swift
//  Project16
//
//  Created by Ruslan Dorosh on 14.06.2023.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {


    var selectedCapital:Capital!
    var webView: WKWebView!
        
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://en.wikipedia.org/wiki/" + selectedCapital.title!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
    
