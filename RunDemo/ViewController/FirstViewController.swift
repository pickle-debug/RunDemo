//
//  FirstViewController.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/12.
//

import UIKit


class FirstViewController: UIViewController, UIViewControllerTransitioningDelegate {
//TO DO 优化代码，复用

    @IBOutlet weak var RunButton: UIButton!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           initBtn()
       }
    
    func initBtn() {
//        let screenSize = UIScreen.main.bounds.size
//        RunButton.frame = CGRect(x: screenSize.width / 2, y: screenSize.height / 2,width: 200, height: 200)
        RunButton.layer.cornerRadius = 5
    
//        let icon = UIImage(named: "icon")
//        RunButton.setImage(UIImage(named:"icon.png"), for: .normal)
    }
    
    @IBAction func startRun(_ sender: UIButton) {
        self.performSegue(withIdentifier: "StartRun", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartRun"{
            let RunViewController = segue.destination as! RunViewController
            RunViewController.modalPresentationStyle = .fullScreen
        }
    }
}





    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

