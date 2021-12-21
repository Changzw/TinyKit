//
//  StateTableView.swift
//  TinyKit
//
//  Created by 常仲伟 on 2021/8/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StateMachine

/*
 1. 需求分析
 2. input & output
 3. input & output 分层，泛化
 */

/*
 1. 状态
 loading
 empty
 error
 normal
 */

final class StateView: NSObject, StateMachineBuilder {
  enum State: StateMachineHashable {
    case normal,
         empty,
         loadingMore,
         error,
         refreshing
  }
  
  enum Event: StateMachineHashable {
    case refresh,
         loadMore,
         noData,
         hasData,
         fail
  }

  enum SideEffect {
  
  }
  typealias StateViewStateMachine = StateMachine<State, Event, SideEffect>
  typealias ValidTransition = StateViewStateMachine.Transition.Valid
  typealias InvalidTransition = StateViewStateMachine.Transition.Invalid
  
  private static func stateMachine(doEffect:@escaping (SideEffect) -> ()) -> StateViewStateMachine {
    StateViewStateMachine {
      initialState(.empty)
      state(.empty) {
        on(.refresh) { transition(to: .refreshing) }
      }
      state(.error) {
        on(.refresh) { transition(to: .refreshing) }
      }
      state(.normal) {
        on(.refresh)  { transition(to: .refreshing) }
        on(.loadMore) { transition(to: .loadingMore) }
      }
      state(.refreshing) {
        on(.noData) { transition(to: .empty) }
        on(.fail)   { transition(to: .error) }
        on(.hasData){ transition(to: .normal) }
      }
      state(.loadingMore) {
        on(.noData) { transition(to: .normal) }
        on(.fail) { transition(to: .normal) }
        on(.hasData) { transition(to: .normal) }
      }
    }
  }
  
  lazy var state = Self.stateMachine { [weak self] effect in
    
  }
}

final class StateTableView: UITableView {
  
}
