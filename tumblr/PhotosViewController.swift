
//
//  ViewController.swift
//  tumblr
//
//  Created by Raj Sathyaseelan on 10/8/16.
//  Copyright © 2016 Token. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTableView: UITableView!
    var tumblePosts = [TumblePost]()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(refreshControl:)), for: UIControlEvents.valueChanged)
        
        refreshTableView(refreshControl: refreshControl)

        self.movieTableView.rowHeight = 200
        self.movieTableView.delegate = self
        
        
    }
    
    func refreshTableView(refreshControl: UIRefreshControl) {
        
        let clientId = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let baseURL = "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(clientId)"
        
        print(baseURL)
        let url = URL(string: baseURL)!
        
        let request = URLRequest(url: url)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                print("error")
            }
            
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    
                    if let responseOnlyDict = responseDictionary.value(forKey: "response") as? NSDictionary {
                        
                        if let postsDict = responseOnlyDict.value(forKey: "posts") as? [NSDictionary]{
                            
                            for post in postsDict {
                                
                                let postSummary = post.value(forKey: "summary") as? String
                                let blogName = post.value(forKey: "blog_name") as? String
                                //let ID = post.value(forKey: "id") as? String
                                var selectedURL = ""
                                
                                if let photo = post.value(forKey: "photos") as? [NSDictionary] {
                                    
                                    for photoInd in photo {
                                        
                                        if let altsizes = photoInd.value(forKey: "alt_sizes") as? [NSDictionary] {
                                            
                                            for altsize in altsizes {
                                                
                                                let widthSize = altsize.value(forKey: "width") as? Int
                                                
                                                if widthSize == 400 {
                                                    selectedURL = (altsize.value(forKey: "url") as? String)!
                                                    print("urls : \(selectedURL)")
                                                    break
                                                }
                                            }
                                            
                                            break
                                        }
                                    }
                                    
                                }
                                
                                let postObject = TumblePost(postid: "123", summary: postSummary!, blogName: blogName!, photoURL: selectedURL)
                                
                                self.tumblePosts.append(postObject)
                            }
                            
                            
                        }
                    }
                    
                    
                }
                
            }
            
            self.movieTableView.reloadData()
            refreshControl.endRefreshing()
            
        });
        
        
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tumblePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        
        print("print index :: \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        let tumblePost = tumblePosts[indexPath.row]
        
        //cell.mycustomLabel?.text = "Row \(indexPath.row)"
        //cell.tumblrImageView.setImageWith(url: )
        cell.summaryTextView?.text = tumblePost.summary
        cell.tumblrImageView.setImageWith(
            URL(string: tumblePost.photoURL)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vc = DetailViewController(nibName: nil, bundle: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! PhotosDetailViewController
        let index = movieTableView.indexPath(for: sender as! UITableViewCell)
        
        if let row = index?.row {
        
            //to fix the row path
            //let photoIV = UIImageView()
            
            vc.post = tumblePosts[(row)]
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class TableCell: UITableViewCell {

    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var tumblrImageView: UIImageView!
}

/*
class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dv = UIView(frame: CGRect.zero)
        dv.backgroundColor = UIColor.brown
        self.view = dv
        
    }
}
 */
