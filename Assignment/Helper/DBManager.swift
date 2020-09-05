//
//  DBManager.swift
//  Assignment
//
//  Created by Angelos Staboulis on 4/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import SQLite
protocol DBManagerDelegate:AnyObject{
    func getDB() -> Connection
    func insertRecord(titleField:String,urlField:String,imageField:String,pubdateField:String)
    func fetchRecord()->[OnTopStories]
}
class DBManager:DBManagerDelegate{
    var connection:Connection?
    static let shared = DBManager()
    private init(){}
    func getDB() -> Connection{
        do{
            let path =  Bundle.main.path(forResource: "topstories", ofType: "sqlite3")
            connection = try Connection(path!)
        }
        catch{
            debugPrint("database error")
        }
        return connection!
    }
    func insertRecord(titleField:String,urlField:String,imageField:String,pubdateField:String){
        do{
            let db = getDB()
            let topstories = Table("topstories")
            let title = Expression<String>("title")
            let image = Expression<String>("image")
            let url = Expression<String>("url")
            let pubdate = Expression<String>("pubdate")
            try db.run(topstories.insert(title <- titleField,image <- imageField, url <- urlField,pubdate <- pubdateField))
            
        }
        catch{
            
        }
    }
    func fetchRecord()->[OnTopStories]{
        var stories:[OnTopStories]=[OnTopStories]()
        do{
            let db = getDB()
            let topstories = Table("topstories")
            let title = Expression<String>("title")
            let image = Expression<String>("image")
            let url = Expression<String>("url")
            let pubdate = Expression<String>("pubdate")
            for story in try db.prepare(topstories){
                let model = OnTopStories(title: story[title], url: story[url], image: story[image], pubdate: story[pubdate])
                stories.append(model)
            }
        }
        catch{
            
        }
        return stories
    }
}
