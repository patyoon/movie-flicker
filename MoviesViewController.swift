
//
//  MoviesViewController.swift
//  MovieFlicker
//
//  Created by Patrick Yoon on 10/15/16.
//  Copyright © 2016 patyoon. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!

  var movies: [NSDictionary]?

  func refreshControlAction(refreshControl: UIRefreshControl) {
    let apiKey = "7bbe2a9e6e9f81468301df8b5bbdf478"
    let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")

    let request = URLRequest(url: url!)
    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate:nil,
      delegateQueue:OperationQueue.main
    )

    let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
      if error != nil {
        MessageView.showInParent(parentView: self.view, text: "Network Error", duration: 10.0)
      }

      if let data = dataOrNil {
        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
          self.movies = responseDictionary["results"] as? [NSDictionary]
          self.tableView.reloadData()
        }
      }
      refreshControl.endRefreshing()
    });
    task.resume()
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self

    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
    tableView.insertSubview(refreshControl, at: 0)

    let apiKey = "7bbe2a9e6e9f81468301df8b5bbdf478"
    let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
    let request = URLRequest(url: url!)

    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate:nil,
      delegateQueue:OperationQueue.main
    )
    MBProgressHUD.showAdded(to: self.view, animated: true)

    let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
      MBProgressHUD.hide(for: self.view, animated: true)

      if error != nil {
        MessageView.showInParent(parentView: self.view, text: "Network Error", duration: 10.0)
      }

      if let data = dataOrNil {
        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
          self.movies = responseDictionary["results"] as? [NSDictionary]
          self.tableView.reloadData()
        }
      } else {
      }
    });
    task.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let movies = movies {
      return movies.count;
    } else {
      return 0;
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
    let movie = movies![indexPath.row]
    let title = movie["title"] as! String
    let overview = movie["overview"] as! String
    let baseUrl = "http://image.tmdb.org/t/p/w500"
    if let posterPath = movie["poster_path"] as? String {
      let imageUrl = URL(string:baseUrl + posterPath)
      cell.posterView.setImageWith(imageUrl!)
    }


    cell.titleLabel.text = title
    cell.overviewLabel.text = overview
    return cell
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let detailsViewController = segue.destination as! MovieDetailsViewController
    var indexPath = tableView.indexPath(for: sender as! UITableViewCell)
    detailsViewController.movie = self.movies![indexPath!.row]
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated:true)
  }
  
}
