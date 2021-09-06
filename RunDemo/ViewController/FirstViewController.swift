//
//  FirstViewController.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/12.
//

import UIKit


class FirstViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var RunButton: UIButton!
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

