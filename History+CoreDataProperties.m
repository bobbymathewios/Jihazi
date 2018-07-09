//
//  History+CoreDataProperties.m
//  
//
//  Created by Princy on 10/05/18.
//
//

#import "History+CoreDataProperties.h"

@implementation History (CoreDataProperties)

+ (NSFetchRequest<History *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"History"];
}

@dynamic title;

@end
