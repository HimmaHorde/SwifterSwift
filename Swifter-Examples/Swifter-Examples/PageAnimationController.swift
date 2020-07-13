//
//  PageAnimationController.swift
//  Swifter-Examples
//
//  Created by 杨林 on 2020/7/9.
//  Copyright © 2020 yanglin
//

import UIKit

class PageAnimationController: UITableViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        .none
    }
}

extension PageAnimationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SubPageController()
        presentPopover(vc, sourcePoint: .init(x: 100, y: 100), size: .init(width: 200, height: 200), delegate: self, animated: true) {
            
        }
    }
}


fileprivate class SubPageController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .brown
    }
}
