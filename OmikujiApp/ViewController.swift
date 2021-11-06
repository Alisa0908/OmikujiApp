//
//  ViewController.swift
//  OmikujiApp
//
//  Created by 松尾有紗 on 2021/11/06.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    // 結果を表示したときに音を出すための再生オブジェクトを格納
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()

    @IBOutlet weak var stickView: UIView!
    @IBOutlet weak var stickLabel: UILabel!
    @IBOutlet weak var stickHeight: NSLayoutConstraint!
    @IBOutlet weak var stickBottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var bigLabel: UILabel!
    
    let resultTexts: [String] = [
        "大吉",
        "中吉",
        "小吉",
        "吉",
        "末吉",
        "凶",
        "大凶"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound() //この1行を追加
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion != UIEvent.EventSubtype.motionShake || overView.isHidden == false {
            return
        }
        
        let resultNum = Int( arc4random_uniform(UInt32(resultTexts.count)) )
        stickLabel.text = resultTexts[resultNum]
        stickBottomMargin.constant = stickHeight.constant * -1

        UIView.animate(withDuration: 1, animations: {

            self.view.layoutIfNeeded()

            }, completion: { (finished: Bool) in
                self.bigLabel.text = self.stickLabel.text
                                self.overView.isHidden = false
                //結果表示のときに音を再生(Play)する
                self.resultAudioPlayer.play()
        })
    }
    
    @IBAction func tapRetryButton(_ sender: Any) {
        overView.isHidden = true
        stickBottomMargin.constant = 0
    }
    
    func setupSound() {
        if let sound = Bundle.main.path(forResource: "bell", ofType: ".mp3") {
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
  
}

