//
//  UITableViewCellWithSwitch.m
//  postroom
//
//  Created by Tomas McGuinness on 06/05/2013.
//  Copyright (c) 2013 com.boldbear. All rights reserved.
//

#import "UITableViewCellWithSwitch.h"

@implementation UITableViewCellWithSwitch

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.accessoryView = self.cellSwitch;
}

@end
