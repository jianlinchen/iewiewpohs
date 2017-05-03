//
//  define.h
//  PDRoom
//
//  Created by vin on 14-9-15.
//  Copyright (c) 2014年 LianZhan. All rights reserved.
//

//正式环境
//#define HostURL @"http://112.74.18.159/service/WMWServlet/servlet/"

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
#define IPHONE5 [UIScreen mainScreen].bounds.size.height > 500

#define M_height [UIScreen mainScreen].bounds.size.height
#define M_width [UIScreen mainScreen].bounds.size.width

#define MAIN_COLOR ([UIColor colorWithRed:236.0/255 green:112.0/255 blue:50.0/255 alpha:1])
#define MAIN_COLOR_2 ([UIColor colorWithRed:162.0/255 green:137.0/255 blue:86.0/255 alpha:1])

#pragma mark get color
#define RGBCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]    //RGB进制颜色值
#define HexColor(hexValue) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]   //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000


#pragma mark Dictionary 2 object
#define CheckDictionaryKey(A,B) ((!!A)&&(![A isKindOfClass:[NSNull class]])&&A.count>0&&[A.allKeys containsObject:B]&&(![[A objectForKey:B] isKindOfClass:[NSNull class]]))
#define DateStringFromDictionary(DIC,KEY) ([Utils getDateFromString:[DIC objectForKey:KEY]])
#define DateFromSecDic(DIC,KEY) ([Utils getDateFromNumber:[DIC objectForKey:KEY]])

#define Dictionary2Object(DIC,KEY,OBJ) if (CheckDictionaryKey(DIC, KEY)) { \
OBJ = [DIC objectForKey:KEY];\
}
#define Dictionary2Object_2(DIC,KEY,OBJ,TYPE)\
if (CheckDictionaryKey(DIC, KEY)) {\
if ([[DIC objectForKey:KEY] isKindOfClass:TYPE]) {\
OBJ = [DIC objectForKey:KEY];\
}\
}
#define Dictionary2TimeObject(DIC,KEY,OBJ) if (CheckDictionaryKey(DIC, KEY)) { \
if ([[DIC objectForKey:KEY ] isKindOfClass:[NSString class]]) {\
OBJ = DateStringFromDictionary(DIC, KEY);\
}else{\
OBJ = DateFromSecDic(DIC, KEY);\
}\
}

