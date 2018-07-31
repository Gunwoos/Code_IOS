//
//  ViewController.swift
//  class0726_kakaoLogin
//
//  Created by 임건우 on 2018. 7. 26..
//  Copyright © 2018년 lims. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kakaoLoginButton: KOLoginButton!
   
    @IBAction private func kakaoLogin(_ sender: KOLoginButton!){
        guard let session = KOSession.shared() else { return }
        
        // Close Old Session
        session.isOpen() ? session.close() : ()
        
        session.open { (error) in
            guard session.isOpen() else { return }
            // Open Session Failed
            
            KOSessionTask.userMeTask { (error, userMe) in
                guard let me = userMe,
                    let nickName = me.nickname,
                    let profileURL = me.profileImageURL,
                    let thumbnailURL = me.thumbnailImageURL
                    else { return }
             
                let task = URLSession.shared.dataTask(with: profileURL, completionHandler: { (data, response, error) in
                    DispatchQueue.main.async {
                        print(profileURL
                        )
                    }
                })
                task.resume()
                
            
                print(userMe!.nickname!)
                print(userMe!.profileImageURL!.absoluteString)
                
            }
        }
        // Login Success
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sessionDidChangeNotification() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name.KOSessionDidChange,
            object: nil,
            queue: .main
        ) { noti in
            guard (noti.object as? KOSession) != nil else { return }
            // Code...
        }
    }


}

