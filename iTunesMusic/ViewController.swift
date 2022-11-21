//
//  ViewController.swift
//  iTunesMusic
//
//  Created by TaiYi Chien on 2022/11/18.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    var avPlayer: AVPlayer?
    var play = false
    var playUrl = ""
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationCenter()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
        image()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer?.replaceCurrentItem(with: nil)
    }
    
    func initUI() {
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        playButton.setTitle("", for: .normal)
    }
    
    func image() {
        let url = URL(string: imageUrl)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        task.resume()
    }
    
    func notificationCenter() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil, queue: .main) { [self] _ in
            play = false
            playButton.setImage(UIImage(named: "replay"), for: .normal)
            let url = URL(string: playUrl)
            avPlayer =  AVPlayer(url: url!)
        }
    }
    
    @objc func playAction() {
        if avPlayer == nil {
            let url = URL(string: playUrl)
            avPlayer = AVPlayer(url: url!)
        }
        
        if play {
            play = false
            avPlayer?.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            play = true
            avPlayer?.play()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        }
    }

}

