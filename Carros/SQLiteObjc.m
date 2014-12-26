//
//  SQLiteObjc.m
//  Carros
//
//  Created by Andre Furquin on 12/26/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

#import "SQLiteObjc.h"

@implementation SQLiteObjc

+(void) bindText:(sqlite3_stmt *)stmt idx:(int)idx withString:(NSString *)s{
    sqlite3_bind_text(stmt, idx, [s UTF8String], -1, nil);
}
+(NSString *)getText:(sqlite3_stmt *)stmt idx:(int)idx{
    char *s = (char *) sqlite3_column_text(stmt, idx);
    NSString *string = [NSString stringWithUTF8String:s];
    return string;
}
@end
