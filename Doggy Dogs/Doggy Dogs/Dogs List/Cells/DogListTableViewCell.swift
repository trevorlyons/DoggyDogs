//
//  DogListTableViewCell.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 15/04/2021.
//

import UIKit

class DogListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dogLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    // MARK: - Public Methods
    
    func configure(with dog: String) {
        dogLabel.text = dog
        dividerView.backgroundColor = .random
    }
}
