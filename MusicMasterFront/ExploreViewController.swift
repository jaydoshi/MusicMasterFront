//
//  FirstViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
// EXPLORE

import UIKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    let serverButton = UIButton(frame: CGRect(x: 190, y: 480, width: 105, height: 50))
    let guestFeedMessage = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    var album1View = UIImageView()
    var album2View = UIImageView()
    var album3View = UIImageView()
    var feedStringResponse = ""
    var multiFeed: UITableView!
    private var myArray: Array<String> = []
    var timer = Timer()
    let client = Main().getClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()

       

        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height/2
        
        if(Main().getGuestBool() == false)
        {
            DispatchQueue.main.async {
                self.multiFeed.reloadData()
            }
            multiFeed = UITableView(frame: CGRect(x: 0, y: displayHeight, width: displayWidth, height: displayHeight))
            multiFeed.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            multiFeed.dataSource = self
            multiFeed.delegate = self
            multiFeed.backgroundColor = UIColor.clear
            self.view.addSubview(multiFeed)
        }
        else
        {
            guestFeedMessage.numberOfLines = 2
            guestFeedMessage.center.x = self.view.center.x
            guestFeedMessage.center.y = 400
            guestFeedMessage.textAlignment = .center
            guestFeedMessage.text = "Log in or register to view feed"
            guestFeedMessage.textColor = UIColor.white
            let ifont = UIFont(name: "HelveticaNeue-MediumItalic", size: 18.0)!
            guestFeedMessage.font = ifont
            self.view.addSubview(guestFeedMessage)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        //let betterBlue = UIColor(red: 0/255.0, green: 94/255.0, blue: 255/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        let exploreTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        exploreTitle.center.x = self.view.center.x
        exploreTitle.center.y = 170
        exploreTitle.textAlignment = .center
        exploreTitle.text = "Explore"
        exploreTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Bold", size: 50.0)!
        exploreTitle.font = sfont
        
        self.view.addSubview(exploreTitle)
        
        let defaultAlbum = "mariah1.jpg"
        let albumImage = UIImage(named: defaultAlbum)
        album1View = UIImageView(image: albumImage!)
        //Main().setSearchAlbumArt(art: albumImage!)
        album1View.frame = CGRect(x: 0, y: 220, width: 100, height: 100)
        album1View.center.x = view.center.x

        view.addSubview(album1View)
        
        let overlayAlbum = "album-mask.png"
        let overlayAlbumImage = UIImage(named: overlayAlbum)
        let overlayAlbumView = UIImageView(image: overlayAlbumImage!)
        overlayAlbumView.frame = CGRect(x: 0, y: 220, width: 100, height: 100)
        overlayAlbumView.center.x = view.center.x
        view.addSubview(overlayAlbumView)
        
        /*
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
        */

        

                    print("hello")
                    guard let data = client.read(1024*10, timeout: 2) else { return }

        
                    if let response = String(bytes: data, encoding: .utf8) {
            
                    print("TCPCLIENT "+response)
                    myArray.append(response)
                    multiFeed.reloadData()
                }


        //let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeRefresh), userInfo: nil, repeats: true)

        //timer.fire()
        
        multiFeed.setNeedsDisplay()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("lol")
        
        if(Main().getGuestBool() == false)
        {

                    print("hello")
                    guard let data = client.read(1024*10, timeout: 2) else { return }

                    if let response = String(bytes: data, encoding: .utf8) {
                        
                        print("TCPCLIENT "+response)
                        myArray.append(response)
                        multiFeed.reloadData()
                    }
            self.multiFeed.reloadData()
            multiFeed.setNeedsDisplay()

        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.backgroundColor = UIColor.clear
        cell.textLabel!.textColor = UIColor.white
        cell.textLabel?.numberOfLines = 2
        
        let bgColorView = UIView()
        let bgColor = UIColor(red: 73/255.0, green: 22/255.0, blue: 181/255.0, alpha: 1.0)
        bgColorView.backgroundColor = bgColor
        cell.selectedBackgroundView = bgColorView
        let ifont = UIFont(name: "HelveticaNeue-Medium", size: 16.0)!
        cell.textLabel!.font = ifont
        return cell
    }
    
    
    func getData()
    {


                guard let data = client.read(1024*10, timeout: 2) else { return }
            print(data)
            print("yeet")
            if let response = String(bytes: data, encoding: .utf8) {
            
            print("TCPCLIENT "+response)
            myArray.append(response)
            multiFeed.reloadData()
                multiFeed.setNeedsDisplay()

            }

    }
    
    func refresh()
    {
        getData()
        multiFeed.setNeedsDisplay()

    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeRefresh), userInfo: nil, repeats: true)
    }
    
    @objc func timeRefresh()
    {
        getData()
        multiFeed.setNeedsDisplay()

    }
    
    /*
    func getData()
    {
        myArray.removeAll()
        var request = URLRequest(url: URL(string: "http://localhost:8080/SwiftServletTest/MultiServlet?")!)
        request.httpMethod = "GET"
        
        print(request)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            if err != nil {
                
                //handle error
            }
            else {
                
               12
            }
            print("Entered the completionHandler")
            
            var feedLine = ""
            for index in self.feedStringResponse.indices
            {
                if(self.feedStringResponse[index] == "%")
                {
                    self.myArray.append(feedLine)
                    print(feedLine)
                    feedLine = ""
                }
                else
                {
                    feedLine.append(self.feedStringResponse[index])
                }
            }
            
            self.multiFeed.reloadData()
        }
        task.resume()
    }
    */
    
    
    
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

