//
//  SearchViewController.swift
//  ParkValley
//
//  Created by Robbe on 03/11/2020.
//

import UIKit

class SearchViewController: UIViewController  {
    
    @IBOutlet var ivFindNearby: UIImageView!
    @IBOutlet var tvRescentlyVisited: UITableView!
    @IBOutlet var sbFind: UISearchBar!
    private var recentlyVisited : [String] = []
    
    public var searchResult : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        
    }
    
    private func createUI() {
        
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ivFindNearby.frame.size.width, height: ivFindNearby.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        ivFindNearby.addSubview(overlay)
        
        recentlyVisited.append("New York")
        recentlyVisited.append("Japan")
        
        tvRescentlyVisited.delegate = self
        tvRescentlyVisited.dataSource = self
        
        if recentlyVisited.isEmpty {
            let label : UILabel = UILabel()
            label.text = "Nothing found"
            label.textAlignment = .center
            label.textColor = .gray
            
            tvRescentlyVisited.backgroundView = label
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableView data source and delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recentlyVisited.count
        } else {
            return 0
        }

    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Recently visited"
//        } else {
//            return ""
//        }
//    }
//
//    /**
//     SOURCE:  https://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
//     */
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let myLabel = UILabel()
//        let font : UIFontDescriptor = UIFontDescriptor(name: "PingFang SC", size: 20)
//
//        myLabel.frame = CGRect(x: 20, y:8, width: 320, height: 20)
//        myLabel.font = UIFont.init(descriptor: font, size: 20)
//        myLabel.textAlignment = .center
//        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
//
//        let headerView = UIView()
//        headerView.addSubview(myLabel)
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "garage", for: indexPath)
        cell.textLabel?.text = recentlyVisited[indexPath.row]
        
        return cell
    
    }
    
}



