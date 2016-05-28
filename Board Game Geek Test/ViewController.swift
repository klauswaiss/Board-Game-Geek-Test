//  Created by Klaus Waiss on 28.05.16.
//  Copyright © 2016 Zuningo e.U. All rights reserved.

import UIKit

class ViewController: UIViewController {
    private let network = Network()
    
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        network.doRequest()
    }
}

extension ViewController {
    private func addObserver() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(resultReceived),
            name: "bgg",
            object: nil)
    }
    
    @objc private func resultReceived(notification: NSNotification) {
        if let resultString = notification.object as? String {
            dispatch_async(dispatch_get_main_queue(), {
                self.resultTextView.text = resultString
            });
        }
    }
}