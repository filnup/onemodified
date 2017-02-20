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
import SwiftyButton
import BubbleTransition

class MainMenu: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var startGame: PressableButton!
    let transition = BubbleTransition()
    @IBOutlet var lavaLabel: UILabel!
    
    var player: AVPlayer?
    var audioPlayer = AVAudioPlayer()
    


    override func viewDidLoad() {
        super.viewDidLoad()
    

        
        //This deals with the button preferences
        startGame.colors = .init(button: .red, shadow: .black)
        startGame.shadowHeight = 10
        startGame.cornerRadius = 8
        startGame.depth = 0.5
        
        
        
        lavaLabel.text = "LAVA"
        lavaLabel.font = UIFont(name: "BaileysCar-Regular", size: 120)
        
        
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

   
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .custom
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startGame.center
        transition.bubbleColor = .black
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = startGame.center
        transition.bubbleColor = startGame.backgroundColor!
        return transition
    }
    
    
    
}
