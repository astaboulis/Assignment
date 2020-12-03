//
//  TopStoriesNetwork.swift
//  Assignment
//
//  Created by Angelos Staboulis on 4/12/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
final class TopStoriesNetwork{
    public static let shared = TopStoriesNetwork()
    var topStories:[OnTopStories] = [OnTopStories]()
    func fetchTopStories(completion:@escaping (([OnTopStories])->())){
        let urlMain = URL(string: "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=v7okPRTSrqhs0FZI9oB7AaGIZANkHEdK")
        let request = URLRequest(url: urlMain!)
        AF.request(request).responseJSON { (response) in
            let json = JSON(response.value!)
            for item in 0..<json["results"].count{
                let topStoriesRecord = OnTopStories(title:json["results"][item]["title"].stringValue, url: json["results"][item]["url"].stringValue, image: json["results"][item]["multimedia"][item]["url"].stringValue, pubdate: json["results"][item]["published_date"].stringValue)
                self.topStories.append(topStoriesRecord)
                
                completion(self.topStories)
            }
        }
    }
}
