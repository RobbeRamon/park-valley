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
    private var recentlyVisited : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: ivFindNearby.frame.size.width, height: ivFindNearby.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        ivFindNearby.addSubview(overlay)
        
        recentlyVisited.append("New York")
        recentlyVisited.append("Japan")
        
        tvRescentlyVisited.delegate = self
        tvRescentlyVisited.dataSource = self
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped me!")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentlyVisited.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "garage", for: indexPath)
        let garage = recentlyVisited[indexPath.row]
        
        cell.textLabel?.text = garage
        
        return cell
    
    }
    
}
