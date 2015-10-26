//
//  Dlog.h
//  EarMaster
//
//  Created by Yun-He-Lee on 15/10/9.
//  Copyright (c) 2015年 EM. All rights reserved.
//


#define IS_DEBUG
#ifdef IS_DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif
 