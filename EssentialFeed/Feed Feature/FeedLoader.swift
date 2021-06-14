//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by RafaelAsencio on 14/06/2021.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping(LoadFeedResult) -> Void)
}
