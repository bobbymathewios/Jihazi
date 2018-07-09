//
//  History+CoreDataProperties.h
//  
//
//  Created by Princy on 10/05/18.
//
//

#import "History+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface History (CoreDataProperties)

+ (NSFetchRequest<History *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
