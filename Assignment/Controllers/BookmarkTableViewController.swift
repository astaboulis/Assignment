//
//  BookmarkTableViewController.swift
//  Assignment
//
//  Created by Angelos Staboulis on 3/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import UIKit

class BookmarkTableViewController: UITableViewController {
    var offtopStories:[OnTopStories] = [OnTopStories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Bookmarks"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Load List", style: .done, target: self, action: #selector(reloadData))
        setupView()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return offtopStories.count
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
extension BookmarkTableViewController{
    @objc func reloadData(){
        tableView.reloadData()
    }
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        offtopStories = DBManager.shared.fetchRecord()
       
        
    }
    //with this function we load remote image
    func setImage(cell:TopStoriesCell,indexPath:IndexPath){
        if indexPath.row < self.offtopStories.count {
            if self.offtopStories[indexPath.row].image!.isEmpty {
                cell.img.image = UIImage(named: "logo")
            }
            else{
                cell.img.frame = CGRect(x: 10, y: 0, width: 100, height: 100)
                cell.img.sd_setImage(with:URL(string:self.offtopStories[indexPath.row].image!), completed:nil)
            }
        }
    }
    // with this function we create cell for tableview
    func setupCell(indexPath:IndexPath,cell:TopStoriesCell){
        cell.title.numberOfLines = 0
        cell.btnDetailsPage.tag = indexPath.row
        cell.btnAddBookmark.isHidden = true
        if indexPath.row < self.offtopStories.count {
            cell.title.text = self.offtopStories[indexPath.row].title
            cell.pubdate.text = self.offtopStories[indexPath.row].pubdate
            cell.btnDetailsPage.addTarget(self, action:#selector(detailsPage(sender:)), for: .touchDown)
            setImage(cell: cell, indexPath: indexPath)
        }
    }
    @objc func detailsPage(sender:UIButton){
        let details = UIStoryboard(name: "Main", bundle: nil)
        let model =  self.offtopStories[sender.tag]
        let detailsForm = details.instantiateViewController(withIdentifier: "DetailsPage") as! DetailsPage
        detailsForm.model = model
        detailsForm.modalPresentationStyle = .fullScreen
        show(detailsForm, sender: self)
    }
}
