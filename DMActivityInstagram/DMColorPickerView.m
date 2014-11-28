//
//  DMColorPickerView.m
//  DMActivityInstagram
//
//  Created by Cory Alder on 2013-09-23.
//  Copyright (c) 2013 Cory Alder. All rights reserved.
//

#import "DMColorPickerView.h"

@implementation DMColorPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

-(void)setup {
    [self addObserver:self forKeyPath:@"colors" options:NSKeyValueObservingOptionNew context:NULL];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.scrollView];
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"colors"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"colors"]) {
        [self updateColors];
    }
}

-(void)updateColors {
    
    NSInteger widthUnit = self.bounds.size.height-8;
    static NSInteger vGapUnit = 8;
    static NSInteger hGapUnit = 4;
    NSInteger width = vGapUnit + ([self.colors count] * (widthUnit+vGapUnit));
    
    self.scrollView.contentSize = (CGSize){width, self.bounds.size.height};
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger offset = 0;
    for (UIColor *color in self.colors) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = (CGRect){
            .size.height = widthUnit,
            .size.width = widthUnit,
            .origin.x = offset + vGapUnit,
            .origin.y = hGapUnit
        };
        
        [button addTarget:self.delegate action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        if ([color isKindOfClass:[UIColor class]]) {
            button.backgroundColor = color;
        } else {
            button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:(NSString *)color]];
        }
        
        
        [self.scrollView addSubview:button];
        offset += widthUnit+vGapUnit;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
