//  Created by Klaus Waiss on 28.05.16.
//  Copyright © 2016 Zuningo e.U. All rights reserved.

import Alamofire

class Network {
    private let queue = dispatch_queue_create("com.zuningo.bggtest.Network.Queue", DISPATCH_QUEUE_SERIAL)
    
    func doRequest() {
        Alamofire.request(.GET, Constants.bggThingURL, parameters: parameters("170216"), encoding: ParameterEncoding.URL, headers: nil)
            .response(queue: self.queue, responseSerializer: Alamofire.Request.dataResponseSerializer()) { response in
                switch response.result {
                case .Success(let value):
                    if let resultStr = String(data: value, encoding: NSUTF8StringEncoding) {
                        print(resultStr)
                        NSNotificationCenter.defaultCenter().postNotificationName("bgg", object: resultStr)
                    }
                case .Failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    private func parameters(id: String) -> [String: String] {
        return ["id": id]
    }
}