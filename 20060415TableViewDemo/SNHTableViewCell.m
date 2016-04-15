//
//  SNHTableViewCell.m
//  20060415TableViewDemo
//
//  Created by majian on 16/4/15.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "SNHTableViewCell.h"

@implementation SNHTableViewCell

- (void)setModel:(SNHTableViewCellModel *)model {
    _model = model;
    
    self.contentView.backgroundColor = model.backColor;
}

@end
