//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by RafaelAsencio on 14/06/2021.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
