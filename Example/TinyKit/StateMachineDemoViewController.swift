//
//  StateMachineDemoViewController.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/8/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StateMachine
import Nimble

class MyStateMachine: StateMachineBuilder {
  enum State: StateMachineHashable {
    case solid, liquid, gas
  }
  
  enum Event: StateMachineHashable {
    case melt, freeze, vaporize, condense
  }
  
  enum SideEffect {
    case logMelted, logFrozen, logVaporized, logCondensed
  }
  
  typealias MatterStateMachine = StateMachine<State, Event, SideEffect>
  typealias ValidTransition = MatterStateMachine.Transition.Valid
  typealias InvalidTransition = MatterStateMachine.Transition.Invalid
  
  enum Message {
    static let melted: String = "I melted"
    static let frozen: String = "I froze"
    static let vaporized: String = "I vaporized"
    static let condensed: String = "I condensed"
  }
  
  static func matterStateMachine(withInitialState _state: State) -> MatterStateMachine {
    MatterStateMachine {
      initialState(_state)
      state(.solid) {
        on(.melt) {
          transition(to: .liquid, emit: .logMelted)
        }
      }
      state(.liquid) {
        on(.freeze) {
          transition(to: .solid, emit: .logFrozen)
        }
        on(.vaporize) {
          transition(to: .gas, emit: .logVaporized)
        }
      }
      state(.gas) {
        on(.condense) {
          transition(to: .liquid, emit: .logCondensed)
        }
      }
      onTransition {
        guard case let .success(transition) = $0, let sideEffect = transition.sideEffect else { return }
        switch sideEffect {
          case .logMelted: print(Message.melted)
          case .logFrozen: print(Message.frozen)
          case .logVaporized: print(Message.vaporized)
          case .logCondensed: print(Message.condensed)
        }
      }
    }
  }
}

class StateMachineDemoViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .random
    
  }
  
  

}
