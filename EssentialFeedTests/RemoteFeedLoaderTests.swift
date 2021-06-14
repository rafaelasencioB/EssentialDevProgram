//
//  RemoteFeedLoaderTests.swift
//  RemoteFeedLoaderTests
//
//  Created by RafaelAsencio on 14/06/2021.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
 
    func test_load_requestsDataFromURL() {
        let url = URL(string: "anotherURL.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        XCTAssertNotNil(client.requestedURL)
        XCTAssertEqual(client.requestedURL, url)
    }
    
    func test_loadTwice_requestsDataFromURL() {
        let url = URL(string: "anotherURL.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    //MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "defaultURL.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient { //testing purposes class
        var requestedURL: URL?
        var requestedURLs = [URL]()
        func get(from url: URL){
            self.requestedURL = url
            requestedURLs.append(url)
        }
    }
}
