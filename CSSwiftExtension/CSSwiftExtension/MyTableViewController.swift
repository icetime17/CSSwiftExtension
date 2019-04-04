//
//  MyTableViewController.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 17/01/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit


class MyTableViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //        tableView.cs.registerNib(MyTableViewCell.self)
        tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        tableView.rowHeight = 100
    }
    
}

extension MyTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.cs.dequeueReusableCell(forIndexPath: indexPath) as MyTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.myImageView.image = UIImage(named: "Model.jpg")
        cell.myLabel.text = "cell - \(indexPath.row)"
        CS_Print(cell.myLabel.text!)
        
        return cell
    }
}

extension MyTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

