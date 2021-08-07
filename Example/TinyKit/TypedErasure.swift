//
//  TypedErasure.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/8/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

protocol ModelWrapper {
  associatedtype T
  var m: T { get set }
}

//struct AnyModelWrapper<Model>: ModelWrapper {
//  let m: Model
//  init<T: ModelWrapper>(m: T) where T.T == Model {
//    self.m = m.m
//  }
//}
