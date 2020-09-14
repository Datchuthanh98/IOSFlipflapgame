//
//  CollectionViewCell.swift
//  DemoCollectionView
//
//  Created by Vương Toàn Bắc on 8/27/20.
//  Copyright © 2020 VTB. All rights reserved.
//
import UIKit
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCard: UIImageView!
    var isOpen = false
    var CardBack:UIImageView!
    var CardFront:UIImageView!
    var flopCard = "closeCard"
    var flipCard = ""
    var isFlip = false
    
    override func awakeFromNib() {
         imgCard.image = UIImage(named: flopCard)
    }
    
    func configure(_ imageName: String) {
        flipCard = imageName
    }
    

    func clickFlipCard() {
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
               UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
                                      self.imgCard.image = UIImage(named: self.flopCard)
        })
    }
    
    func clikFlopCard(){
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
               UIView.transition(with: self.contentView, duration: 0.5, options: transitionOptions, animations: {
                                      self.imgCard.image = UIImage(named: self.flipCard)
        })
    }
    
    
    func removeCard() {
        UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseOut, animations: {
            self.imgCard.alpha = 0
                       }, completion: nil)
        
    }

}
