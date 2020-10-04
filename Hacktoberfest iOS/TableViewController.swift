//
//  TableViewController.swift
//  Hacktoberfest iOS
//
//  Created by Aaryan Kothari on 05/10/20.
//

import UIKit
import SafariServices

class TableViewController: UITableViewController {
    
    var cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO initial setup
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datasource.contributors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        let contributor = Datasource.contributors[indexPath.row]
        cell.textLabel?.text = contributor.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.makeContextMenu(for: indexPath.row)
        })
    }
    
    
    func makeContextMenu(for index:Int) -> UIMenu {
        var actions = [UIAction]()
        let contributor = Datasource.contributors[index]
        for item in contributor.socialHandles {
            let action = UIAction(title: item.imageName, image: UIImage(named: item.imageName), identifier: nil, discoverabilityTitle: nil) { _ in
                self.openWebsite(item.urlString)
            }
            actions.append(action)
        }
        let cancel = UIAction(title: "Cancel", attributes: .destructive) { _ in}
        actions.append(cancel)
        return UIMenu(title: "", children: actions)
    }
}


extension UIViewController : SFSafariViewControllerDelegate{
    func openWebsite(_ link : String?){
        if let link = link,let url = URL(string: link) {
            if ["http", "https"].contains(url.scheme?.lowercased() ?? "") {
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true, completion: nil)
                safariVC.delegate = self
            }
        }
    }
}
