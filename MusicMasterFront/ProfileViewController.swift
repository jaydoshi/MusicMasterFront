//
//  ProfileViewController.swift
//  MusicMasterFront
//
//  Created by Jay Doshi on 10/29/18.
//  Copyright © 2018 Jay Doshi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let userNameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
    let guestPlaylistMessage = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let playlistTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let playlistCountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let maskView = UIImageView()
    var profilePicView = UIImageView()
    private let myArray: NSArray = ["Daily Drive","Favorites","Relaxing", "Holiday Party Mix", "Straight Bangers", "Awesome Mix Vol. 1"]
    private var playlistSavedTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height/2
        
        if(Main().getGuestBool() == false)
        {
            playlistSavedTable = UITableView(frame: CGRect(x: 0, y: displayHeight, width: displayWidth, height: displayHeight))
            playlistSavedTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
            playlistSavedTable.dataSource = self
            playlistSavedTable.delegate = self
            playlistSavedTable.backgroundColor = UIColor.clear
            self.view.addSubview(playlistSavedTable)
        }
        else
        {
            guestPlaylistMessage.numberOfLines = 2
            guestPlaylistMessage.center.x = self.view.center.x
            guestPlaylistMessage.center.y = 400
            guestPlaylistMessage.textAlignment = .center
            guestPlaylistMessage.text = "Log in or register to save playlists"
            guestPlaylistMessage.textColor = UIColor.white
            let ifont = UIFont(name: "HelveticaNeue-MediumItalic", size: 18.0)!
            guestPlaylistMessage.font = ifont
            self.view.addSubview(guestPlaylistMessage)
        }
        
        playlistTitleLabel.center.x = self.view.center.x
        playlistTitleLabel.center.y = 325
        playlistTitleLabel.textAlignment = .center
        playlistTitleLabel.text = "Playlists"
        playlistTitleLabel.textColor = UIColor.white
        let pfont = UIFont(name: "HelveticaNeue-Medium", size: 21.0)!
        playlistTitleLabel.font = pfont
        self.view.addSubview(playlistTitleLabel)
        
        playlistCountLabel.center.x = self.view.center.x
        playlistCountLabel.center.y = 360
        playlistCountLabel.textAlignment = .center
        playlistCountLabel.text = "0"
        if(Main().getGuestBool() == false)
        {
            playlistCountLabel.text = String(myArray.count)
            playlistCountLabel.font = pfont
        }
        else
        {
            playlistCountLabel.text = "0"
        }
        playlistCountLabel.textColor = UIColor.white
        playlistCountLabel.font = pfont
        self.view.addSubview(playlistCountLabel)
        
        
        maskView.image = UIImage(named: "mask.png")

        var profileDefault = "bigGuest.png"
        if(Main().getGuestBool() == false)
        {
            profileDefault = "jay.png"
        }
        let profilePic = UIImage(named: profileDefault)
        profilePicView = UIImageView(image: profilePic!)
        profilePicView.mask = maskView
        profilePicView.frame = CGRect(x: 0, y: 150, width: 120, height: 120)
        view.addSubview(profilePicView)
        profilePicView.center.x = view.center.x
        
        // Do any additional setup after loading the view.
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        let darkPurple = UIColor(red: 24/255.0, green: 18/255.0, blue: 97/255.0, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.colors = [black.cgColor, darkPurple.cgColor]
        gradient.locations = [0.0, 0.75, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
        userNameTitle.center.x = self.view.center.x
        userNameTitle.center.y = 120
        userNameTitle.textAlignment = .center
        //userNameTitle.text = "f"
        self.setUsernameTitle()
        //userNameTitle.text = "yer"
        userNameTitle.textColor = UIColor.white
        let sfont = UIFont(name: "HelveticaNeue-Medium", size: 30.0)!
        userNameTitle.font = sfont
        
        self.view.addSubview(userNameTitle)
        
        /*
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)*/
        
        //self.view.addSubview(button)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        cell.backgroundColor = UIColor.clear
        cell.textLabel!.textColor = UIColor.white
        cell.accessoryType = .disclosureIndicator
        
        tableView.separatorStyle = .none
        let bgColorView = UIView()
        let bgColor = UIColor(red: 73/255.0, green: 22/255.0, blue: 181/255.0, alpha: 1.0)
        bgColorView.backgroundColor = bgColor
        cell.selectedBackgroundView = bgColorView
        let ifont = UIFont(name: "HelveticaNeue-Medium", size: 20.0)!
        cell.textLabel!.font = ifont
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }

    func setUsernameTitle()
    {
        print(Main().getGuestBool())
        if(Main().getGuestBool() == true)
        {
            userNameTitle.text = "Guest"
        }
        else
        {
            userNameTitle.text = Main().getUsername()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskView.frame = profilePicView.bounds
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        //segue.destination = LoginViewController()
        // Pass the selected object to the new view controller.
        
    }
 

}
