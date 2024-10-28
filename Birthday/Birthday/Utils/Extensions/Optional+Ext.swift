//
//  Optional+Ext.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

public protocol AnyOptional {
  
    var isNil: Bool { get }
    var isNotNil: Bool { get }
  
}

extension Optional: AnyOptional {
  
    public var isNil: Bool { self == nil }
    public var isNotNil: Bool { !isNil }
  
}
