//
//  WalkthroughPageViewController.swift
//  BookList
//
//  Created by 田露 on 2/6/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    var pageIntro = ["Create and manage your own book list","Mark and rate when finish a book","Search a book from your book list"]
    var pageImages = ["image1","image2","image3"]
    var currentPageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let startingViewController = contentViewController(at: currentPageIndex) {
        setViewControllers([startingViewController], direction: .forward,animated: true, completion: nil)
        }
    }
    
    func nextPage(){
        currentPageIndex += 1
        if let nextViewController = contentViewController(at: currentPageIndex){
            setViewControllers([nextViewController], direction:.forward, animated: true, completion:nil)
        }
    }
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at:index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at:index)
    }
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageIntro.count {
            return nil
        }
        let storyboard = UIStoryboard(name: "walkthrough", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier:"WalkthroughContentViewController") as? WalkthroughContentViewController {
                pageContentViewController.imageFile = pageImages[index]
                pageContentViewController.intro = pageIntro[index]
                pageContentViewController.index = index
                return pageContentViewController
        }
            return nil
    }
}
