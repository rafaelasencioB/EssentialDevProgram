//
//  RemoteFeedLoaderTests.swift
//  RemoteFeedLoaderTests
//
//  Created by RafaelAsencio on 14/06/2021.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    func load() {
        client.get(from: url)
    }
}
protocol HTTPClient {
    func get(from url: URL)
}


class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "anotherURL.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertNotNil(client.requestedURL)
        XCTAssertEqual(client.requestedURL, url)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "defaultURL.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient { //testing purposes class
        var requestedURL: URL?
        
        func get(from url: URL){
            self.requestedURL = url
        }
    }
}
