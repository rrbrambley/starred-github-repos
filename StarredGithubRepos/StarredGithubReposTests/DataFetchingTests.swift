//
//  DataFetchingTests.swift
//  StarredGithubRepos
//
//  Created by Robert Brambley on 4/27/16.
//  Copyright © 2016 AATT. All rights reserved.
//

import OctoKit
import Swinject
import SwiftyJSON
import XCTest
@testable import StarredGithubRepos

class DataFetchingTests: XCTestCase {
    
    struct StubDataFetching: DataFetching {
//        private static let repositoriesJson = ""
        
        func fetchStarredRepositories(completion: (Array<OCTRepository> -> Void)!) {
            let bundle = NSBundle(forClass: DataFetchingTests.self)
            let path = bundle.pathForResource("repositories", ofType: "json")
            var repositoriesJson: String?
            do {
              repositoriesJson = try NSString(contentsOfURL: NSURL(fileURLWithPath: path!), encoding: NSUTF8StringEncoding) as String
            } catch {
                print(error)
            }
            var repositories: Array<OCTRepository> = Array()
            
            if let dataFromString = repositoriesJson!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                let items = json["items"]
                for repoJson in items {
                    do {
                        print(repoJson.1.description)
                        let dictionary: [String: AnyObject] = repoJson.1.dictionaryObject!
                        
                        
                        
                        //
                        //TODO: this line below is crashing!
                        
                        
                        try repositories.append(OCTRepository(dictionary: dictionary, error:()))
                    } catch {
                        print(error)
                    }
                }
            }
            
            completion(repositories)
        }
        
        func fetchContributors(repository: OCTRepository, completion: (Array<OCTContributor> -> Void)!) {
            
        }
    }
    
    let container = Container()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        container.register(DataFetching.self, name: "stub") { _ in
            StubDataFetching()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFetchStarredRepositories() {
        let dataFetcher = container.resolve(DataFetching.self, name: "stub")
        dataFetcher?.fetchStarredRepositories({ (repositories: Array<OCTRepository>) in
            XCTAssert(repositories.count > 0)
        })
    }
    
    func testFetchContributors() {
        
    }
}
