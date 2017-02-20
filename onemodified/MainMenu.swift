//
//  MainMenu.swift
//  onemodified
//
//  Created by Ethan Bonin on 2/20/17.
//  Copyright © 2017 onehelloworld. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MainMenu: UIViewController {
    
    var player: AVPlayer?
    var audioPlayer = AVAudioPlayer()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        do {
            
            let audio = Bundle.main.path(forResource: "mainMenu", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: (NSURL(fileURLWithPath: audio!)) as URL)
            
            
        }catch {}
        
        audioPlayer.play()
        
        
        // Load the video from the app bundle.
        let videoURL: NSURL = Bundle.main.url(forResource: "Volcano", withExtension: "mp4")! as NSURL
        
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //loop video
        NotificationCenter.default.addObserver(self, selector: #selector(MainMenu.loopVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

    }

    
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
