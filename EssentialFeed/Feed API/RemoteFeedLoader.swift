//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by RafaelAsencio on 14/06/2021.
//

import Foundation



public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias Result = LoadFeedResult<Error>
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load(completion: @escaping(Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .sucess(data, response):
                let result = FeedItemsMapper.map(data, from: response)
                completion(result)
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

