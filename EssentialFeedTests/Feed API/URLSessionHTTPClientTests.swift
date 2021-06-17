//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by RafaelAsencio on 17/06/2021.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { (_, _, _) in
        }.resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        let url = URL(string: "any-URL.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(from: url, task: task)
        
        let sut = URLSessionHTTPClient(session: session)
        sut.get(from: url)
        
        XCTAssertEqual(task.resumeCallCount, 1)
    }
    
    //MARK: - Helpers
    
    class URLSessionSpy: URLSession {
        private var stubs = [URL: URLSessionDataTask]()
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return stubs[url] ?? FakeURLSessionDataTask()
        }
        
        func stub(from url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
    }
    
    class FakeURLSessionDataTask: URLSessionDataTask {
//        override func resume() {
//        }
    }
    
    class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }
}


