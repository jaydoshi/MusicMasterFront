//
//  FirstViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
// EXPLORE

import UIKit

class ExploreViewController: UIViewController {

    let serverButton = UIButton(frame: CGRect(x: 190, y: 480, width: 105, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let betterBlue = UIColor(red: 0/255.0, green: 94/255.0, blue: 255/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        let exploreTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        exploreTitle.center.x = self.view.center.x
        exploreTitle.center.y = 170
        exploreTitle.textAlignment = .center
        exploreTitle.text = "Explore"
        exploreTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 50.0)!
        exploreTitle.font = sfont
        
        self.view.addSubview(exploreTitle)
        
        
        
        serverButton.titleLabel?.textColor = UIColor.white
        let tfont = UIFont(name: "HelveticaNeue", size: 15.0)!
        serverButton.titleLabel?.font = tfont
        serverButton.layer.cornerRadius = 5
        serverButton.layer.borderWidth = 1
        serverButton.layer.borderColor = UIColor.white.cgColor
        serverButton.setTitle("Test", for: .normal)
        serverButton.backgroundColor = betterBlue;
        serverButton.addTarget(self, action: #selector(serverAction), for: .touchUpInside)
        serverButton.center = view.center
        self.view.addSubview(serverButton)
        
        
        
        
        
        
        
    }
    
    
    @objc func serverAction(sender: UIButton!) {

        print("server button")
        var request = URLRequest(url: URL(string: "http://localhost:8080/SwiftServletTest/FirstServlet?test=Bad+Blood+by+Taylor+Swift")!)
        request.httpMethod = "GET"
        //let session = URLSession.shared
        //let testString = "/?test=Bad+Blood+by+Taylor+Swift"
        //let somedata = testString.data(using: String.Encoding.utf8)
        
        //request.httpBody = somedata
        print(request)
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            if err != nil {
                
                //handle error
            }
            else {
                
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Parsed JSON: '\(String(describing: jsonStr))'")
            }
            print("Entered the completionHandler")
            
        }
        task.resume()
        
        //let session = URLSession.shared
        
    }
    

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    

}

