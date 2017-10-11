//
//  TableViewController.swift
//  tamboonapp
//
//  Created by admin on 10/8/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

class CharityListController: UITableViewController {
    
    class Charity {
        var id: Int?
        var name: String?
        var logoUrl: String?
        
        init(dictionary: [String: Any]) {
            id = dictionary["id"] as? Int
            name = dictionary["name"] as? String
            logoUrl = dictionary["logo_url"] as? String
        }
    }
    
    var globalSelectedIndex:Int = 0
    var charities = [Charity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromUrl(url: "http://localhost:8080/")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.charities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let charity = charities[indexPath.row]
        
        cell.textLabel?.text = charity.name
        cell.imageView?.imageFromServerURL(urlString: charity.logoUrl!)
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    
    func doTableRefresh()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            return
        }
    }
    
    func getImageFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func getDataFromUrl(url:String)
    {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest)
        {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let array = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                //iterate through the array
                self.charities = array.map {
                    return Charity(dictionary: $0)
                }
                
                self.doTableRefresh()
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
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

    
    // MARK: - Navigation
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let destination = CharityDonateController() // Your destination
        //navigationController?.pushViewController(destination, animated: true)
        
        var alertView = UIAlertView()
        alertView.addButton(withTitle: "Ok")
        alertView.title = "Row Selected"
        //alertView.message = self.tableData[indexPath.row]
        alertView.show()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
        //globalSelectedIndex = selectedIndex!.row
        //print("tableView prepareForSegue: " + String(globalSelectedIndex))
    }
 

}
