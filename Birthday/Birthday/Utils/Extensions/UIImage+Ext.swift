//
//  UIImage+Ext.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 27.10.24.
//

import UIKit

extension UIImage {
  
  func convertImageToBase64String() -> String? {
    guard let imageData = self.jpegData(compressionQuality: 1.0) else {
      return nil
    }
    return imageData.base64EncodedString()
  }
  
  func resizeImage(targetSize: CGSize) -> UIImage {
    let size = self.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let newSize: CGSize
    if widthRatio > heightRatio {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    self.draw(in: CGRect(origin: .zero, size: newSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage ?? self
  }
  
}
