//
//  UIImage+Ext.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 27.10.24.
//

import UIKit

extension UIImage {
  
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

extension UIImage {
  
  func convertToBase64(
    size: CGSize = .init(width: 100, height: 100),
    result: @escaping (String?, String?) -> Void
  ) {
    let resizedImage = self.resizeImage(targetSize: size)
    if let jpegData = resizedImage.jpegData(compressionQuality: 0.1) {
      DispatchQueue.main.async {
        Console.log("Base64 string created successfully.")
        result(nil, jpegData.base64EncodedString(options: .lineLength64Characters))
      }
    } else {
      Console.log("Failed to convert image to JPEG.")
      result("Failed to convert image to JPEG.", nil)
    }
  }
  
}
