//
//  Tracker.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/7/29.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
// 注意！！
/*
 最外层的接口是为了收集信息的！！
 * 设计模式的状态机
 * 彼此知道各自的状态的样子
 * 有一个 context 持有一个 state，context 执行各种操作
 * 当前的 state weak 依赖 context 改变他的 state 的状态
 */

//MARK: state
protocol TrackingState {
  func startTracking()
  func stopTracking()
  func pauseTracking(for time: TimeInterval)
  
  func makeCheckIn()
  func findMyChildren()
}

class EnabledTrackingState: TrackingState {
  private weak var tracker: LocationTracker?
  init(tracker: LocationTracker?) {
    self.tracker = tracker
  }
  
  func startTracking() {
    print("EnabledTrackingState: startTracking is invoked")
  }
  
  func stopTracking() {
    print("EnabledTrackingState: Received 'stop tracking'")
    print("EnabledTrackingState: Changing state to 'disabled'...")
    tracker?.update(state: DisabledTrackingState(tracker: tracker))
    tracker?.stopTracking()
  }
  
  func pauseTracking(for time: TimeInterval) {
    print("EnabledTrackingState: Received 'pause tracking' for \(time) seconds")
    print("EnabledTrackingState: Changing state to 'disabled'...")
    tracker?.update(state: DisabledTrackingState(tracker: tracker))
    tracker?.pauseTracking(for: time)
  }
  
  func makeCheckIn() {
    print("EnabledTrackingState: performing check-in at the current location")
  }
  
  func findMyChildren() {
    print("EnabledTrackingState: searching for children...")
  }
}

class DisabledTrackingState: TrackingState {
  private weak var tracker: LocationTracker?
  init(tracker: LocationTracker?) {
    self.tracker = tracker
  }
  
  func startTracking() {
    print("DisabledTrackingState: Received 'start tracking'")
    print("DisabledTrackingState: Changing state to 'enabled'...")
    tracker?.update(state: EnabledTrackingState(tracker: tracker))
  }
  
  func pauseTracking(for time: TimeInterval) {
    print("DisabledTrackingState: Pause tracking for \(time) seconds")
    
    for i in 0...Int(time) {
      print("DisabledTrackingState: pause...\(i)")
    }
    
    print("DisabledTrackingState: Time is over")
    print("Disabled -> Enable\n")
    self.tracker?.update(state: EnabledTrackingState(tracker: self.tracker))
    self.tracker?.startTracking()
  }
  
  func stopTracking() {
    print("DisabledTrackingState: Received 'stop tracking'")
    print("DisabledTrackingState: Do nothing...")
  }
  
  func makeCheckIn() {
    print("DisabledTrackingState: Received 'make check-in'")
    print("DisabledTrackingState: Changing state to 'enabled'...")
    tracker?.update(state: EnabledTrackingState(tracker: tracker))
    tracker?.makeCheckIn()
  }
  
  func findMyChildren() {
    print("DisabledTrackingState: Received 'find my children'")
    print("DisabledTrackingState: Changing state to 'enabled'...")
    tracker?.update(state: EnabledTrackingState(tracker: tracker))
    tracker?.findMyChildren()
  }
}

//MARK: - Context
class LocationTracker {
  /// Location tracking is enabled by default
  private lazy var trackingState: TrackingState = EnabledTrackingState(tracker: self)
  func startTracking() {
    trackingState.startTracking()
  }
  func stopTracking() {
    trackingState.stopTracking()
  }
  func pauseTracking(for time: TimeInterval) {
    trackingState.pauseTracking(for: time)
  }
  func makeCheckIn() {
    trackingState.makeCheckIn()
  }
  func findMyChildren() {
    trackingState.findMyChildren()
  }
  
  func update(state: TrackingState) {
    trackingState = state
  }
}
