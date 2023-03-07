//
//  ViewController.swift
//  Web
//
//  Created by 김영빈 on 2023/03/08.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url) // url 값을 받아 URL형으로 선언
        let myRequest = URLRequest(url: myUrl!) // 상수 myUrl을 받아 URLRequest형으로 선언
        myWebView.load(myRequest) // WKWebView형의 myWebView 클래스의 load 메서드 호출
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myWebView.navigationDelegate = self
        loadWebPage("http://2sam.net")
    }
    
    // 로딩 중인지를 확인하기 위한 델리게이트 메서드
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // 인디케이터 동작 표시
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    // 로딩이 완료되었을 때 동작하는 델리게이트 메서드
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 인디케이터를 중지하고 숨김
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    // 로딩 실패 시 동작하는 델리게이트 메서드
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 인디케이터를 중지하고 숨김
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }

    @IBAction func btnGotoUrl(_ sender: UIButton) {
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
    }
}

