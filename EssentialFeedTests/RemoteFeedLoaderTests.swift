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
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
 
    func test_load_requestsDataFromURL() {
        let url = URL(string: "anotherURL.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in}

        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURL() {
        let url = URL(string: "anotherURL.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in}
        sut.load { _ in}
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        let clientError = NSError(domain: "Test Error", code: 0)
        
        client.complete(with: clientError)
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    //MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "defaultURL.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient { //testing purposes class
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }
        var messages = [(url: URL, completion: (Error) -> Void)]()
        
        func get(from url: URL, completion: @escaping(Error) -> Void){
            messages.append((url, completion))
        }
        
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(error)
        }
    }
}
