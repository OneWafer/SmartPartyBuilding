//
//  OWBaseUserLineCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseUserLineCell.h"
#import "OWBaseUserLineItem.h"

#define TimeDayLabelLeftMargin 15
#define TimeDayLabelTopMargin 20

#define BodyViewLeftMargin 90
#define BodyViewRightMargin 15

@interface OWBaseUserLineCell ()

@property (nonatomic, strong) OWBaseUserLineItem *item;

@property (nonatomic, strong) UILabel *timeDayLabel;

@property (nonatomic, strong) UILabel *timeMonthLabel;

@end

@implementation OWBaseUserLineCell

#pragma mark - Lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
    }
    return self;
}


-(void) initView
{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_timeDayLabel == nil) {
        _timeDayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeDayLabel.font = [UIFont boldSystemFontOfSize:30];
        //_timeDayLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeDayLabel];
    }
    
    
    if (_timeMonthLabel == nil) {
        _timeMonthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeMonthLabel.font = [UIFont systemFontOfSize:12];
        //_timeDayLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeMonthLabel];
    }
    
    if (_bodyView == nil) {
        _bodyView = [[UIButton alloc] initWithFrame:CGRectZero];
        //_bodyView.backgroundColor = [UIColor darkGrayColor];
        [_bodyView addTarget:self action:@selector(onClickBodyView:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_bodyView];
    }
    
}

-(void) updateWithItem:(OWBaseUserLineItem *) item
{
    
    self.item = item;
    
    
    CGFloat x, y, width, height;
    x = TimeDayLabelLeftMargin;
    y = 0;
    if (item.bShowTime) {
        y = TimeDayLabelTopMargin;
    }
    
    width = 40;
    height = 25;
    _timeDayLabel.frame = CGRectMake(x, y, width, height);
    _timeDayLabel.text = item.day < 10 ? [NSString stringWithFormat:@"0%ld", (unsigned long)item.day]: [NSString stringWithFormat:@"%ld", (unsigned long)item.day];
    _timeDayLabel.hidden = !item.bShowTime;
    
    
    x = CGRectGetMinX(_timeDayLabel.frame)+35;
    y = CGRectGetMinY(_timeDayLabel.frame)+10;
    width = 30;
    height = 15;
    _timeMonthLabel.frame = CGRectMake(x, y, width, height);;
    _timeMonthLabel.text = [NSString stringWithFormat:@"%ld月", (unsigned long)item.month];
    _timeMonthLabel.hidden = _timeDayLabel.hidden;
    
}


-(void)updateBodyWithHeight:(CGFloat)height
{
    CGFloat x, y, width;
    x=BodyViewLeftMargin;
    y = 0;
    if (_item.bShowTime) {
        y = TimeDayLabelTopMargin;
    }
    width = [UIScreen mainScreen].bounds.size.width - x - BodyViewRightMargin;
    _bodyView.frame = CGRectMake(x, y, width, height);
    
    
}


-(void) onClickBodyView:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(onClickItem:)]){
        [_delegate onClickItem:self.item];
    }
    
}

-(CGFloat) getCellHeight:(OWBaseUserLineItem *) item;
{
    return item.bShowTime? TimeDayLabelTopMargin+10:10;
}

@end
