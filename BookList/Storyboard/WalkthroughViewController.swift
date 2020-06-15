//
//  WalkthroughViewController.swift
//  BookList
//
//  Created by 田露 on 2/6/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var walkthroughPageViewController:WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "walkthroughScreenViewed")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let index = walkthroughPageViewController?.currentPageIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.nextPage()
            case 2:
                UserDefaults.standard.set(true, forKey: "walkthroughScreenViewed")
                dismiss(animated: true, completion:nil)
            default:
                break
            }
            pageControl.currentPage = index + 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
        }
    }

    
}
