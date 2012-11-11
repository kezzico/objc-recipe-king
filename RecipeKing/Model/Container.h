//
//  Container.h
//  CheapoAir
//
//  Created by Lee Irvine on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Container : NSObject {
  NSMutableDictionary *_components;
}

+ (Container *) shared;
- (void) registerProtocol: (Protocol *) proto toClass: (Class) class;
- (void) registerProtocol: (Protocol *) proto toInstance:(id) obj;
- (id) resolve: (Protocol *) proto;
@end


@interface Dependency : NSObject {
@public
  Class class;
  id instance;
}

@end;