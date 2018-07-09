//
//  ViewController.swift
//  Simple parsing json project
//
//  Created by Ahmet Berkay CALISTI on 09/07/2018.
//  Copyright © 2018 Ahmet Berkay CALISTI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let path = Bundle.main.path(forResource: "jsonData", ofType: "json")
        // print(path ?? "not a real path")
        // have to do some optional chaining because we don't want to optional string. Also we can do force to wrap it but its not a good practice for code
        guard let path = Bundle.main.path(forResource: "jsonData", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        
        // its gonna show the actual bytes. This isnt readable
        do {
            let data = try Data(contentsOf: url)
            // We can't really work with bytes so I'm going to actually do some serialization of that data. After that we actually know what we're working with
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print(data)
            print(json)
            
            // do some optional chaining
            guard let array = json as? [Any] else { return }
            
            for user in array {
                guard let userDict = user as? [String: Any] else { return }
                guard let userId = userDict["id"] as? Int else { print("not an Int"); return }
                guard let name = userDict["name"] as? String else {return}
                // Most likely we're gonna do "Any" in real world situation but we know exactly what we're getting back
                guard let company = userDict["company"] as? [String: String] else { return }
                guard let companyName = company["name"] else {return }
                
                
                print(userId)
                print(name)
                print(companyName)
                print(" ")
            }
            
        } catch  {
            print(error)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

