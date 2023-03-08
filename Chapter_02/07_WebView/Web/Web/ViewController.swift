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
    
    // 홈페이지 주소를 문자열로 받고, 프로토콜 처리 후 반환하는 함수
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }

    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
//        loadWebPage("http://fallinmac.tistory.com")
        loadWebPage("http://kybeen.tistory.com")
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://blog.2sam.net")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p> <p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading() // 웹 페이지 로딩 중지
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload() // 웹 페이지 재로딩
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack() // 이전 웹 페이지로 이동
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward() // 다음 웹 페이지로 이동
    }
}

