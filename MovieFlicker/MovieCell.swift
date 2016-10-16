//
//  MovieCell.swift
//  MovieFlicker
//
//  Created by Patrick Yoon on 10/15/16.
//  Copyright © 2016 patyoon. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var posterView: UIImageView!
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
