//
//  OCViewController.m
//  TinyKit_Example
//
//  Created by 常仲伟 on 2021/8/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#import "TransitionKitDemoViewController.h"
#import "TinyKit-Swift.h"
@import TransitionKit;

@interface TransitionKitDemoViewController ()
@property(strong, nonatomic) TKStateMachine *inboxStateMachine;
@end

@implementation TransitionKitDemoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view setBackgroundColor:[UIColor random]];
  self.inboxStateMachine = [TKStateMachine new];
  
  TKState *unread = [TKState stateWithName:@"Unread"];
  [unread setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
    NSLog(@"state: %@, transition: %@", state, transition);
  }];
  TKState *read = [TKState stateWithName:@"Read"];
  [read setDidExitStateBlock:^(TKState *state, TKTransition *transition) {
    NSLog(@"state: %@, transition: %@", state, transition);
  }];
  TKState *deleted = [TKState stateWithName:@"Deleted"];
  [deleted setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
    NSLog(@"state: %@, transition: %@", state, transition);
  }];
  
  [self.inboxStateMachine addStates:@[ unread, read, deleted ]];
  self.inboxStateMachine.initialState = unread;
  
  TKEvent *viewMessage = [TKEvent eventWithName:@"View Message" transitioningFromStates:@[unread] toState:read];
  TKEvent *deleteMessage = [TKEvent eventWithName:@"Delete Message" transitioningFromStates:@[read, unread] toState:deleted];
  TKEvent *markAsUnread = [TKEvent eventWithName:@"Mark as Unread" transitioningFromStates:@[read, deleted] toState:unread];
  
  [self.inboxStateMachine addEvents:@[ viewMessage, deleteMessage, markAsUnread ]];
  
  // Activate the state machine
  [self.inboxStateMachine activate];
  
  [self.inboxStateMachine isInState:@"Unread"]; // YES, the initial state
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  // Fire some events
  NSDictionary *userInfo = nil;
  NSError *error = nil;
  BOOL success = [self.inboxStateMachine fireEvent:@"View Message" userInfo:userInfo error:&error]; // YES
  success = [self.inboxStateMachine fireEvent:@"Delete Message" userInfo:userInfo error:&error]; // YES
  success = [self.inboxStateMachine fireEvent:@"Mark as Unread" userInfo:userInfo error:&error]; // YES
  
  success = [self.inboxStateMachine canFireEvent:@"Mark as Unread"]; // NO
  
  // Error. Cannot mark an Unread message as Unread
  success = [self.inboxStateMachine fireEvent:@"Mark as Unread" userInfo:nil error:&error]; // NO
}
@end
