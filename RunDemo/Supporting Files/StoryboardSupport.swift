//
//  StoryboardSupport.swift
//  RunDemo
//
//  Created by 何纪栋 on 2021/9/9.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension StoryboardIdentifiable where Self: UITableViewCell {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}


extension UIViewController: StoryboardIdentifiable { }
extension UITableViewCell: StoryboardIdentifiable { }


extension UITableView {
    func dequeResuableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.storyboardIdentifier, for: indexPath) as? T else {
            fatalError("无法找到与 \(T.storyboardIdentifier) 相关联的table view cell")
        }
        return cell
    }
    
    func cellForRow<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("无法得到\(T.self)事件的单位格")
        }
        return cell
    }
}




protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self:UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegue(withIdentifier identifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
    
    func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
        guard
            let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
        else {
            fatalError("Invalid segue identifier: \(String(describing: segue.identifier))")
        }

        return segueIdentifier
    }
}
