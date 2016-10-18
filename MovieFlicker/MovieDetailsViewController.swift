//
//  MovieDetailsViewController.swift
//  MovieFlicker
//
//  Created by Patrick Yoon on 10/15/16.
//  Copyright © 2016 patyoon. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {


  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var infoView: UIView!

  var movie: NSDictionary!

  override func viewDidLoad() {
    super.viewDidLoad()

    let title = movie["title"] as? String
    titleLabel.text = title
    overviewLabel.text = movie["overview"] as? String
    overviewLabel.sizeToFit()
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
                                    height: infoView.frame.origin.y + infoView.frame.size.height)
    
    let baseUrl = "http://image.tmdb.org/t/p/w500"
    if let posterPath = movie["poster_path"] as? String {
      let imageUrl = URL(string:baseUrl + posterPath)
      posterImageView.setImageWith(imageUrl!)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
