//
//  ViewController.swift
//  ImageScroller
//
//  Created by Greg Heo on 2014-12-18.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var imageView: UIImageView!
  var scrollView: UIScrollView!
  var originLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    imageView = UIImageView(image: UIImage(named: "zombies.jpg"))

    scrollView = UIScrollView(frame: view.bounds)
    scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    scrollView.backgroundColor = UIColor.blackColor()
    scrollView.contentSize = imageView.bounds.size

    scrollView.addSubview(imageView)
    view.addSubview(scrollView)

    originLabel = UILabel(frame: CGRect(x: 20, y: 30, width: 0, height: 0))
    originLabel.backgroundColor = UIColor.blackColor()
    originLabel.textColor = UIColor.whiteColor()
    view.addSubview(originLabel)

    scrollView.delegate = self
    
    setZoomParametersForSize(scrollView.bounds.size)
    scrollView.zoomScale = scrollView.minimumZoomScale
    
    originLabel.numberOfLines = 0
    updateLabel()
    
  }
    
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
    }

    func updateLabel() {
        originLabel.text = "Offset: \(scrollView.contentOffset)\n" + "Zoom: \(scrollView.zoomScale)"
        originLabel.sizeToFit()
    }
    
    func setZoomParametersForSize(scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        // scrollView.zoomScale = minScale
        
        
    }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateLabel()
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        updateLabel()
    }
//  func scrollViewDidScroll(scrollView: UIScrollView) {
//    originLabel.text = "\(scrollView.contentOffset)"
//    originLabel.sizeToFit()
//  }
}
