//
//  TopStoriesTableViewController.swift
//  Assignment
//
//  Created by Angelos Staboulis on 3/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ToastAlerts
import SDWebImage
class TopStoriesTableViewController: UITableViewController {
    var topStories = TopStories()
    var topStoriesArray:[OnTopStories] = [OnTopStories](){
        didSet{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = "Top Stories New York Times"
        setupView()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topStoriesArray.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TopStoriesCell = tableView.dequeueReusableCell(withIdentifier: "cellNew", for: indexPath) as! TopStoriesCell
        setupCell(indexPath: indexPath, cell: cell)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension TopStoriesTableViewController{
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        topStories.fetchTopStories { (array) in
            self.topStoriesArray.append(contentsOf: array)
        }
       
    }
    //with this function we load remote image
    func setImage(cell:TopStoriesCell,indexPath:IndexPath){
        if indexPath.row < self.topStoriesArray.count {
            if self.topStoriesArray[indexPath.row].image!.isEmpty {
                cell.img.image = UIImage(named: "logo")
            }
            else{
                cell.img.sd_setImage(with:URL(string:self.topStoriesArray[indexPath.row].image!), completed:nil)
            }
        }
    }
    // with this function we create cell for tableview
    func setupCell(indexPath:IndexPath,cell:TopStoriesCell){
        cell.title.numberOfLines = 0
        cell.btnDetailsPage.tag = indexPath.row
        cell.btnAddBookmark.tag = indexPath.row
        if indexPath.row < self.topStoriesArray.count {
            cell.title.text = self.topStoriesArray[indexPath.row].title
            cell.pubdate.text = self.topStoriesArray[indexPath.row].pubdate
            cell.btnAddBookmark.addTarget(self, action: #selector(addBookmark(sender:)), for: .touchDown)
            cell.btnDetailsPage.addTarget(self, action:#selector(detailsPage(sender:)), for: .touchDown)
            setImage(cell: cell, indexPath: indexPath)
        }
    }
    @objc func detailsPage(sender:UIButton){
        let details = UIStoryboard(name: "Main", bundle: nil)
        let model =  self.topStoriesArray[sender.tag]
        let detailsForm = details.instantiateViewController(withIdentifier: "DetailsPage") as! DetailsPage
        detailsForm.model = model
        detailsForm.modalPresentationStyle = .fullScreen
        show(detailsForm, sender: self)
    }
    @objc func addBookmark(sender:UIButton){
        let alert = ToastAlertView(message: "Added to bookmark", image: .checkmark)
        alert.show()
        let model =  self.topStoriesArray[sender.tag]
        DBManager.shared.insertRecord(titleField:model.title!, urlField:model.url!, imageField: model.image!, pubdateField: model.pubdate!)
       
    }
}
