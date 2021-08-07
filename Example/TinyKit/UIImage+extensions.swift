//
//  UIImage+extensions.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/8/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

#warning("下采样")
extension UIImage {
  
  class func image(with color: UIColor, size: CGSize = CGSize(width: 1, height: 1), radius: CGFloat? = nil) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()!
    context.setFillColor(color.cgColor);
    let rect = CGRect(origin: CGPoint.zero, size: size)
    context.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    if let radius = radius {
      return image.cornerRadius(radius)
    }
    return image
  }
  
  func cornerRadius(_ radius: CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let context = UIGraphicsGetCurrentContext()!
    let rect = CGRect(origin: CGPoint.zero, size: size)
    let path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
    context.addPath(path)
    context.clip()
    draw(in: rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }
  
  func alpha(_ value: CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}
