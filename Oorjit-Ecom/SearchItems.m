//
//  SearchItems.m
//  Jihazi
//
//  Created by Princy on 09/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "SearchItems.h"

@implementation SearchItems
- (instancetype)init:(NSDictionary *)json {
    self = [super init];
    if (self) {
        self.title = json[@"_highlightResult"][@"productTitle"][@"value"];
        self.image = json[@"productImage"];
        self.price = json[@"productPrice"];

        self.rating = [json[@"rating"] integerValue];
        self.year = [json[@"year"] integerValue];
    }
    return self;
}
@end
