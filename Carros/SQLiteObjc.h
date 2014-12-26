//
//  SQLiteObjc.h
//  Carros
//
//  Created by Andre Furquin on 12/26/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SQLiteObjc : NSObject
+(void) bindText:(sqlite3_stmt *)stmt idx:(int)idx withString:(NSString *)s;
+(NSString *)getText:(sqlite3_stmt *)stmt idx:(int)idx;
@end
