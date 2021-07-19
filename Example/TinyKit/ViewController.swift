//
//  ViewController.swift
//  TinyKit
//
//  Created by Changzw on 07/18/2021.
//  Copyright (c) 2021 Changzw. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {
  
  let items = Page.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    view.backgroundColor = .blue
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
    cell.textLabel?.text = items[indexPath.row].rawValue
    return cell
  }
  
}

