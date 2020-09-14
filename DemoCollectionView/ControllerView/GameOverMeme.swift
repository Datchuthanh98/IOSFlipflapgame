//
//  GameOverMeme.swift
//  DemoCollectionView
//
//  Created by Chu Thanh Dat on 8/28/20.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

class GameOverMeme: UIViewController {
    let timeCompleteSave =  UserDefaults.standard.integer(forKey: "timeCompleteSave") ?? 0
    
      var timeComplete :Int = 0
    @IBOutlet weak var txtTitle: UILabel!
    var tagCheck : Int = 0;
   
    @IBOutlet weak var txtTimeComplete: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTimeComplete.text =  String(timeComplete)
        
        if(tagCheck == 0){
            txtTitle.text = "Thua cuộc"
        }else if( self.timeComplete  < timeCompleteSave){
            txtTitle.text = " Phá kỉ lục"
            UserDefaults.standard.set( timeComplete , forKey: "timeCompleteSave")
            
        }else {
              txtTitle.text = "Chiến Thắng"
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func binPlayAgain(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainGame") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)    }

}
