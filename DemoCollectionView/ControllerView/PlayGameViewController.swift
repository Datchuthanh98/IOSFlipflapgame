//
//  PlayGameViewController.swift
//  DemoCollectionView
//
//  Created by Chu Thanh Dat on 8/27/20.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

class PlayGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    
    @IBAction func btnPlay(_ sender: Any) {
        let vc = (UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "navigation") as? MainNavigationController)!
        self.present(vc, animated: true, completion: nil)
    
    }
    
}
