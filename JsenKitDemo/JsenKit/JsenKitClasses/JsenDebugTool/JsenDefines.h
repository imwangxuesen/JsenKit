//
//  JsenDefines.h
//  JsenKit
//
//  Created by WangXuesen on 2017/11/1.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#ifndef JsenDefines_h
#define JsenDefines_h


// NSLog 宏
#ifndef __OPTIMIZE__

#define NSLog(FORMAT, ...) do{\
fprintf(stderr,"<%s : ", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String]);\
fprintf(stderr,"%zd> \n", __LINE__);\
fprintf(stderr,"%s\n", __func__);\
fprintf(stderr,"==> %s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
fprintf(stderr,"------------ * ------------\n\n");\
} while(0)
#else

#define NSLog(...) {}

#endif

#endif /* JsenDefines_h */
