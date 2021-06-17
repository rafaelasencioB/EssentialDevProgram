//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by RafaelAsencio on 14/06/2021.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping(LoadFeedResult) -> Void)
}
