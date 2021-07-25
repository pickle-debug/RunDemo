//
//  View.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/7/1.
//

import UIKit

class View: UIView {
    
    override func draw(_ rect: CGRect)
    {
        let fontName = "HelveticaNeue-Bold"
        let helveticaBold = UIFont(name: fontName,size: 40.0)
        let string = "Some String" as NSString
        string.draw(at: CGPointMake(40.0,180.0),
                    withAttributes:[NSAttributedString.Key.font : helveticaBold!])
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
