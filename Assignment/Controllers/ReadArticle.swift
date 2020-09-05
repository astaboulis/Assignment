//
//  ReadArticle.swift
//  Assignment
//
//  Created by Angelos Staboulis on 4/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit
import WebKit
class ReadArticle: UIViewController {
    public var url:String?
    @IBOutlet var loadArticle: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let urlmain = URL(string: url!)
        let request = URLRequest(url: urlmain!)
        loadArticle.load(request)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
