//
//  StateMachineDemoViewController.swift
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/8/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import StateMachine
import WebKit
import SnapKit
import FSPagerView
import RxSwift
import RxCocoa

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
  
  private lazy var pagerView: FSPagerView = {
    let v = FSPagerView(frame: .zero)
    v.register(ItemCell.self, forCellWithReuseIdentifier: String(describing: ItemCell.self))
    v.itemSize = FSPagerView.automaticSize
    v.removesInfiniteLoopForSingleItem = true
    v.delegate = self
    v.dataSource = self
    v.isInfinite = true
    v.automaticSlidingInterval = 0
    v.backgroundColor = .clear
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .random
    view.addSubview(pagerView)
    pagerView.snp.makeConstraints{
      $0.center.equalToSuperview()
      $0.width.height.equalTo(200)
    }
    
    Observable<Int>.timer(.seconds(0), period: .seconds(3), scheduler: MainScheduler.instance)
      .bind{[unowned self] _ in
//        guard let u = URL(string: "https://zvod.badambiz.com/h5/eid_al-adha_2021/wy//index2.html?qbc=dk&v=2&rule_tab=0&rule_sub=0") else { return }
        self.pagerView.reloadData()
      }

  }
}

class ItemCell: FSPagerViewCell {
  
  var url: URL = URL(string: "https://zvod.badambiz.com/h5/eid_al-adha_2021/wy//index2.html?qbc=dk&v=2&rule_tab=0&rule_sub=0")! {
    didSet {
      webView.load(URLRequest(url: url))

    }
  }
  let webView = WKWebView()
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(webView)
    webView.snp.makeConstraints{
      $0.edges.equalToSuperview()
    }
      
    guard let u = URL(string: "https://zvod.badambiz.com/h5/eid_al-adha_2021/wy//index2.html?qbc=dk&v=2&rule_tab=0&rule_sub=0") else { return }
    webView.load(URLRequest(url: u))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension StateMachineDemoViewController: FSPagerViewDataSource {
  func numberOfItems(in pagerView: FSPagerView) -> Int {
    return 1
//    let c = data?.contents?.count ?? 0
//    pageControl.numberOfPages = c
//    return c
  }
  
  func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCell.self), at: index) as! ItemCell
    cell.url = URL(string: "https://zvod.badambiz.com/h5/eid_al-adha_2021/wy//index2.html?qbc=dk&v=2&rule_tab=0&rule_sub=0")!
    return cell
  }
  
  func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
//    guard let c = cell as? LiveRoomSquareBannerContentsCell else { return }
//    descInfoLabel.text = c.data?.text
  }
}

extension StateMachineDemoViewController: FSPagerViewDelegate {
  func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
//    pageControl.currentPage = targetIndex
  }
  
  func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
//    pageControl.currentPage = pagerView.currentIndex
  }
  
  func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
//    if let cell = cell as? LiveRoomSquareBannerContentsCell,
//       index < (data?.contents?.count ?? 0),
//       let t = data?.contents?[index]?.typeInfo, t == .h5 {
//      cell.webViewVC?.url = nil
//    }
  }
  
  func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//    pagerView.deselectItem(at: index, animated: true)
//    if let t = data?.contents?[index]?.typeInfo, t == .h5 {
//      return
//    }
//
//    guard let clickFeed = clickFeed,
//          let idxPath = indexPath,
//          let bs = data?.contents,
//          index < bs.count,
//          let c = bs[index] else { return }
//    clickFeed(c, idxPath, index)
  }
}


