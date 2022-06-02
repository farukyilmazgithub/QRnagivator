//
//  QRScannerViewController.swift
//  tab
//
//  Created by Faruk Yılmaz on 23.05.2022.
//

import UIKit
import SwiftUI

class QRScannerViewController: UIViewController {
    
    @IBOutlet weak var theContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childView = UIHostingController(rootView: QRScanner())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
    }
}
