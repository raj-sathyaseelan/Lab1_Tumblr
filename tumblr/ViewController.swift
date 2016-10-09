//
//  ViewController.swift
//  tumblr
//
//  Created by Raj Sathyaseelan on 10/8/16.
//  Copyright © 2016 Token. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieTableView.rowHeight = 200.0
        movieTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        cell.mycustomLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

class TableCell: UITableViewCell {
    
    @IBOutlet weak var mycustomLabel: UILabel!
    
}

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dv = UIView(frame: CGRect.zero)
        dv.backgroundColor = UIColor.brown
        self.view = dv
        
    }
}
