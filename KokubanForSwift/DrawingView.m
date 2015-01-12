//
//  DrawingView.m
//  kokubanForiPhone
//
//  Created by 平塚 俊輔 on 11/07/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DrawingView.h"


@implementation DrawingView

@synthesize aryData;

#pragma mark -
#pragma mark 描画領域作成
CGContextRef createCanvasContext(int width, int height)
{
	//RGBの描画領域作成。
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(
                                                 NULL,		//初期化用データ。NULLなら初期化はシステムに任せる
                                                 width,		//画像横ピクセル数
                                                 height,		//縦
                                                 8,			//RGB各要素は8ビット
                                                 0,			//横１ラインの画像を定義するのに必要なバイト数。0はシステムに任せる。
                                                 colorSpace, //RGB色空間。
                                                 kCGImageAlphaPremultipliedLast);	//RGBの後ろにアルファ値(RGBはアルファ値が適用済み)
	
    CGColorSpaceRelease(colorSpace);
	//NSLog(@"cccccccccccccccccccc");
	//NSLog(@"%@",context);
	return context;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMultipleTouchEnabled:YES];
        // Initialization code
        canvas	= createCanvasContext(frame.size.width, frame.size.height);
    }
    return self;
}

- (void)awakeFromNib
{
	//ここに初期化コード
	[self setMultipleTouchEnabled:YES];
	canvas	= createCanvasContext(320, 480);
	
	
}


-(void)drawStroke:(NSMutableArray *)ary:(CGContextRef)ctx {
	
    
    
	// 最初の４つは色情報
	if ([ary count] >= 5) {
		CGFloat penRed = [(NSNumber *)[ary objectAtIndex:0] floatValue];
		CGFloat penGreen = [(NSNumber *)[ary objectAtIndex:1] floatValue];
		CGFloat penBlue = [(NSNumber *)[ary objectAtIndex:2] floatValue];
		CGFloat penAlpha = [(NSNumber *)[ary objectAtIndex:3] floatValue];
        int linedepth = [(NSNumber *)[ary objectAtIndex:4] intValue];
		CGContextSetLineWidth( ctx, linedepth );
        //CGContextSetLineWidth( ctx, 20 );
        
		CGContextSetRGBStrokeColor( ctx, penRed, penGreen, penBlue, penAlpha );
	}
	if ([ary count] >= 7) {
		CGPoint pos;
		pos.x = [(NSNumber *)[ary objectAtIndex:5] integerValue];
		pos.y = [(NSNumber *)[ary objectAtIndex:6] integerValue];
		CGContextMoveToPoint(ctx, pos.x, pos.y);
		for (int i = 7; i < ([ary count]-1); i+=2) { // -1は、objectAtIndxでオーバーしないため
			pos.x = [(NSNumber *)[ary objectAtIndex:i] integerValue];
			pos.y = [(NSNumber *)[ary objectAtIndex:i+1] integerValue];
			CGContextAddLineToPoint(ctx, pos.x, pos.y);
		}
	}
	CGContextStrokePath(ctx);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	if (aryData) {
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		CGContextSetLineCap(ctx, kCGLineCapRound);
        
		
		if ([aryData count] > 0) {
			if ([[aryData objectAtIndex:0] isKindOfClass:[NSMutableArray class]]) {
				for (NSMutableArray *stroke in aryData) {
					[self drawStroke:stroke :ctx];
				}
			} else {
				[self drawStroke:aryData :ctx];
			}
		}
	}
}



- (void)dealloc {
}


@end
