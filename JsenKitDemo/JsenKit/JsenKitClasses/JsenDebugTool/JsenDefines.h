//
//  JsenDefines.h
//  JsenKit
//
//  Created by WangXuesen on 2017/11/1.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#ifndef JsenDefines_h
#define JsenDefines_h


// 弱引用
#define WeakObj(o) @autoreleasepool{} __weak typeof(o) o##Weak = o
// 强引用
#define StrongObj(o) @autoreleasepool{} __strong typeof(o) o = o##Weak



// 常量
#define JsenScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define JsenScreenHeight  [[UIScreen mainScreen] bounds].size.height



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
