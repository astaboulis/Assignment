//
//  TopStories.swift
//  Assignment
//
//  Created by Angelos Staboulis on 4/9/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
protocol TopStoriesDelegate:AnyObject{
    func fetchTopStories(completion:@escaping (([OnTopStories])->()))
}

class TopStories:TopStoriesDelegate{
    private let topStories:TopStoriesNetwork
    var topStoriesArray:[OnTopStories] = [OnTopStories]()
    init(){
        topStories = TopStoriesNetwork.shared
    }
    
    func fetchTopStories(completion:@escaping (([OnTopStories])->())){
        topStories.fetchTopStories { (array) in
            self.topStoriesArray.append(contentsOf: array)
            completion(self.topStoriesArray)
        }
    }
    
    
    
}
