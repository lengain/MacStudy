//
//  URLSessionManager.swift
//  MacStudy
//
//  Created by 童玉龙 on 2023/3/14.
//

import Cocoa

class URLSessionManager: NSObject , URLSessionDelegate {
    static let shared = URLSessionManager()
    
    lazy var session : URLSession = {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }()
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
}
