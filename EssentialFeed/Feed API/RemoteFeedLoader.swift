//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by RafaelAsencio on 14/06/2021.
//

import Foundation

public enum HTTPClientResult {
    case sucess(HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping(HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    public func load(completion: @escaping(Error) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .sucess:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}
