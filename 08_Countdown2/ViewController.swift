//
//  ViewController.swift
//  08_Countdown2
//
//  Created by shota ito on 06/10/2018.
//  Copyright © 2018 shota ito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var hSlider: UISlider!
    @IBOutlet weak var mSlider: UISlider!
    @IBOutlet weak var sSlider: UISlider!
    
    
    var hours = 0
    var minutes = 0
    var seconds = 0
    var totalTime = 0
    
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    
    
    // slider
    @IBAction func hourSlider(_ sender: UISlider) {
        hours = Int(sender.value) * 3600
        totalTime = hours + minutes + seconds
        timerLabel.text = timeString(time: TimeInterval(totalTime))
        
    }
    
    @IBAction func minuteSlider(_ sender: UISlider) {
        minutes = Int(sender.value) * 60
        totalTime = hours + minutes + seconds
        timerLabel.text = timeString(time: TimeInterval(totalTime))
    }
    
    @IBAction func secondSlider(_ sender: UISlider) {
        seconds = Int(sender.value)
        totalTime = hours + minutes + seconds
        timerLabel.text = timeString(time: TimeInterval(totalTime))
    }
    
    
    
    
    
    
    func timeString(time: TimeInterval) -> String{
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hour, minute, second)
    }
    
    
    @objc func updateTimer() {
        if totalTime < 1 {
            timer.invalidate()
        }else{
            totalTime -= 1
            timerLabel.text = timeString(time: TimeInterval(totalTime))
        }
    }
    
    
    @IBAction func startBtn(_ sender: Any) {
        if isTimerRunning == false && totalTime != 0{
            runTimer()
            self.startBtn.isEnabled = false
            stopBtn.isEnabled = true
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        stopBtn.isEnabled = true
    }
    
    
    @IBAction func stopBtn(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.stopBtn.setTitle("RESUME", for: .normal)
        }else{
            runTimer()
            self.resumeTapped = false
            self.stopBtn.setTitle("STOP", for: .normal)
            
        }
    }
    
    
    @IBAction func resetBtn(_ sender: Any) {
        timer.invalidate()
        
        hours = 0
        minutes = 0
        seconds = 0
        totalTime = 0
        hSlider.value = 0
        mSlider.value = 0
        sSlider.value = 0
        
        timerLabel.text = timeString(time: TimeInterval(totalTime))
        
        isTimerRunning = false
        stopBtn.isEnabled = false
        self.startBtn.isEnabled = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopBtn.isEnabled = false
    }


}

