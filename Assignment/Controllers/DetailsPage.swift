//
//  DetailsPage.swift
//  Assignment
//
//  Created by Angelos Staboulis on 5/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit
import SDWebImage
class DetailsPage: UIViewController {
    var model = OnTopStories()
    @IBOutlet var lblpubDate: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOpenArticle(_ sender: Any) {
        let details = UIStoryboard(name: "Main", bundle: nil)
        let detailsForm = details.instantiateViewController(withIdentifier: "ReadArticle") as! ReadArticle
        detailsForm.url = model.url
        detailsForm.modalPresentationStyle = .fullScreen
        show(detailsForm, sender: self)
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
extension DetailsPage{
    func setupView(){
        lblTitle.text = model.title
        lblpubDate.text = model.pubdate
        if self.model.image!.isEmpty {
            img.image = UIImage(named: "logo")
        }
        else{
            img.sd_setImage(with:URL(string:model.image!), completed:nil)
        }
    }
}
