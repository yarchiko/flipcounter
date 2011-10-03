//
//  FlipCounterView.m
//  FlipCounter
//
//  Created by Steven Fusco on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipCounterView.h"

#define FCV_FRAME_WIDTH 53
#define FCV_TOPFRAME_HEIGHT 39
#define FCV_BOTTOMFRAME_HEIGHT 64

@implementation FlipCounterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage* sprite = [UIImage imageNamed:@"digits.png"];
        CGImageRef spriteRef = [sprite CGImage];
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = FCV_FRAME_WIDTH;
        CGFloat topH = FCV_TOPFRAME_HEIGHT;
        CGFloat bottomH = FCV_BOTTOMFRAME_HEIGHT;
        
        int numCols = 4;
        int numRows = 20;
        
        numTopFrames = 3;
        int totalNumTopFrames = numTopFrames * 10;
        topFrames = [NSMutableArray arrayWithCapacity:totalNumTopFrames];
        
        numBottomFrames = 4;
        int totalNumBottomFrames = numBottomFrames * 10;
        bottomFrames = [NSMutableArray arrayWithCapacity:totalNumBottomFrames];
        
        int bottomRowStart = 10;
        for (int row=0; row!=numRows; ++row) {
            x = 0;
            BOOL isTopFrame = (row < bottomRowStart);
            CGFloat h = isTopFrame ? topH : bottomH;
            
            for (int col=0; col!=numCols; ++col) {
                if ((col == 3) && (row < bottomRowStart)) continue; // ignore whitespace
                
                CGRect frameRect = CGRectMake(x, y, w, h);
                CGImageRef image = CGImageCreateWithImageInRect(spriteRef, frameRect);
                UIImage* imagePtr = [[UIImage alloc] initWithCGImage:image];
                
                if (isTopFrame) {
                    [topFrames addObject:imagePtr];
                } else {
                    [bottomFrames addObject:imagePtr];
                }
                
                [imagePtr release];
                CFRelease(image);
                
                x += w;
            }
            
            y += h;
        }
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage* t = [topFrames objectAtIndex:0];
    [t drawAtPoint:CGPointZero];
    
    UIImage* b = [bottomFrames objectAtIndex:0];
    [b drawAtPoint:CGPointMake(0, FCV_TOPFRAME_HEIGHT)];
}



@end
