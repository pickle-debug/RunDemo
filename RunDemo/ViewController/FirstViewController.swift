//
//  FirstViewController.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/12.
//

import UIKit

class FirstViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startRun"{
            let vc = segue.destination as! RunViewController
            vc.modalPresentationStyle = .fullScreen
        }
    }
}
//    @IBAction func turnToRunViewController(sender: Any?) {
//        let vc = RunViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//        }




    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

