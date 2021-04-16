//
//  DogDetailsCollectionViewCell.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 15/04/2021.
//

import UIKit
import Kingfisher

class DogDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dogImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Public Methods
    
    func configure(with dogImage: String) {
        if let url = URL(string: dogImage) {
            dogImageView.kf.setImage(with: url)
        }
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.random.cgColor
    }
}
