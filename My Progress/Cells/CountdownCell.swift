//
//  CountdownCell.swift
//  My Progress
//
//  Created by Alexander Petrenko on 28.10.2022.
//

import UIKit

class CountdownCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(progress: Time) {
        
        CountdownView().configure(progress: progress, frameView: self.contentView)
    }
    
}
