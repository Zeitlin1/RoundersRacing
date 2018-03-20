//
//  VideoViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import WebKit

class VideoViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonPushed(_ sender: UIButton) {
        
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func makeWinOrLoss(_ sender: UIButton) {
        
        print(SharedBetLogic.shared.determineResult())
        // handle win or loss conditionals here (ie. balance xfer)
        self.dismiss(animated: true) {}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController

        let webView = WKWebView(frame: CGRect.zero, configuration: wkWebConfig)

        webView.backgroundColor = UIColor.red
        
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: webView,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      relatedBy: NSLayoutRelation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutAttribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: webView,
                                                    attribute: NSLayoutAttribute.centerY,
                                                    relatedBy: NSLayoutRelation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutAttribute.centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        let widthConstraint = NSLayoutConstraint(item: webView,
                                                 attribute: NSLayoutAttribute.width,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutAttribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: self.view.frame.width)
        let heightConstraint = NSLayoutConstraint(item: webView,
                                                  attribute: NSLayoutAttribute.height,
                                                  relatedBy: NSLayoutRelation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutAttribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: self.view.frame.height * 0.8)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        webView.uiDelegate = self

        let webAddress = "https://www.youtube.com/watch?v=Uic-mDpjdn8"

        if let url = URL(string: webAddress) {

            let urlRequest = URLRequest(url: url)

            webView.load(urlRequest)

//            webView.scrollView.zoomScale = 1.0
            //            self.topWebView.contentMode = .scaleAspectFit

        }
        

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
