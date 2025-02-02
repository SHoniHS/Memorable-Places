//
//  PlacesViewController.swift
//  Memorable Places
//
//  Created by SHS on 9/1/19.
//  Copyright © 2019 SHS. All rights reserved.
//

import UIKit

var places = [Dictionary<String, String>()]
var activePlace = -1

class PlacesViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated:Bool) {
        
        if let tempPlaces = UserDefaults.standard.object(forKey: "places") as? [Dictionary<String, String>] {
            
            places = tempPlaces
            
        } // This restores places saved before.
        
        if places.count == 1 && places[0].count == 0 {
            
            places.remove(at: 0)
            
            places.append(["name":"Taj Mahal","lat":"27.175277","lon":"78.042128"])
            
            UserDefaults.standard.set(places, forKey: "places") //This creates a permament storage to keep always the places selected. This saves places permanently.
            
        }
        
        activePlace = -1
        
        table.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true //This way you allow the user to edit the rows.
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            places.remove(at: indexPath.row)
            
            UserDefaults.standard.set(places, forKey: "places") //This creates a permament storage to keep always the places selected. This saves places permanently.
            
            table.reloadData()
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default , reuseIdentifier: "Cell")
        
        if places[indexPath.row]["name"] != nil {
            
            cell.textLabel?.text = places[indexPath.row]["name"]
            
        }
        
        // cell.textLabel?.text = "Row \(indexPath.row)"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activePlace = indexPath.row
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
