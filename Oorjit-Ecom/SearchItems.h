//
//  SearchItems.h
//  Jihazi
//
//  Created by Princy on 09/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchItems : NSObject
- (instancetype)init:(NSDictionary*)json;
@property (nonatomic) NSString *title,*price;
@property (nonatomic) NSString *image;
@property (nonatomic) NSInteger rating;
@property (nonatomic) NSInteger year;
@end
