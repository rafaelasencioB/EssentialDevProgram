//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by RafaelAsencio on 16/06/2021.
//

import Foundation

public enum HTTPClientResult {
    case sucess(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping(HTTPClientResult) -> Void)
}
