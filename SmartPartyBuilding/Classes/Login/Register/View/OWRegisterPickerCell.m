//
//  OWRegisterPickerCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/12.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWRegisterPickerCell.h"

@interface OWRegisterPickerCell ()

@end

@implementation OWRegisterPickerCell

static NSString *const identifier = @"OWRegisterPickerCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWRegisterPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWRegisterPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


/*
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

@end
