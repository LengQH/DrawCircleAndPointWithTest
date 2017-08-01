//
//  NSObject+ChangeUnicode.h
//  yoli
//
//  Created by 冷求慧 on 17/3/14.
//  Copyright © 2017年 Leng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ChangeUnicode)

+(NSString *)stringByReplaceUnicode:(NSString *)string;

@end

@interface NSArray (LengUnicode)
@end

@interface NSDictionary (LengUnicode)
@end
