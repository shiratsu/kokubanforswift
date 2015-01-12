//
//  DrawingView.h
//  kokubanForiPhone
//
//  Created by 平塚 俊輔 on 11/07/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLineDepth 10

@interface DrawingView : UIView {
	
	__weak NSMutableArray *aryData;
    CGContextRef	canvas;
    

}
// ストロークのアクセサ。assign となっている点に注意。（管理は呼び出し側で行う）
@property (nonatomic,weak) NSMutableArray *aryData;

@end
