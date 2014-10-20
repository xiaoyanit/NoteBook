//
//  NoteCellTableViewCell.m
//  NoteBook
//
//  Created by 畅通 on 14-10-16.
//  Copyright (c) 2014年 tom. All rights reserved.
//

#import "NoteCellTableViewCell.h"

#define KColor(r,g,b)  [UIColor colorWithHue:r/255.0 saturation:g/255.0 brightness:b/255.0 alpha:1]
#define kStatusTableViewCellControlSpacing 10//控件间距
#define kStatusTableViewCellBackgroundColor KColor(251,251,251)
#define kStatusGrayColor KColor(50,50,50)
#define kStatusLightGrayColor KColor(120,120,120)

#define kStatusTableViewCellAvatarWidth 40 //头像宽度
#define kStatusTableViewCellAvatarHeight kStatusTableViewCellAvatarWidth
#define kStatusTableViewCellUserNameFontSize 14
#define kStatusTableViewCellMbTypeWidth 13 //会员图标宽度
#define kStatusTableViewCellMbTypeHeight kStatusTableViewCellMbTypeWidth
#define kStatusTableViewCellCreateAtFontSize 12
#define kStatusTableViewCellSourceFontSize 12
#define kStatusTableViewCellTextFontSize 14

@interface NoteCellTableViewCell(){
    
    UIImageView * _avatar;//头像
    UIImageView * _mbType;//会员类型
    UILabel * _userName;
    UILabel * _creatrAt;
    UILabel * _source;
    UILabel * _text;
    
}
@end

@implementation NoteCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubview];
    }
    return self;
}


#pragma mark 初始化视图
- (void)initSubview{
    //头像控件
    _avatar = [[UIImageView alloc]init];
    [self addSubview:_avatar];
    
    //用户
    _userName = [[UILabel alloc]init];
    _userName.textColor = kStatusGrayColor;
    _userName.font = [UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize];
    [self addSubview:_userName];
    
    //会员类型
    _mbType = [[UIImageView alloc]init];
    [self addSubview:_mbType];
    
    //日期
    _creatrAt = [[UILabel alloc]init];
    _creatrAt.textColor = kStatusLightGrayColor;
    _creatrAt.font = [UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize];
    [self addSubview:_creatrAt];
    
    //设备
    _source = [[UILabel alloc]init];
    _source.textColor = kStatusLightGrayColor;
    _source.font = [UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize];
    [self addSubview:_source];
    
    //内容
    _text = [[UILabel alloc]init];
    _text.textColor = kStatusGrayColor;
    _text.font = [UIFont systemFontOfSize:kStatusTableViewCellTextFontSize];
    _text.numberOfLines = 0;//相当于不限制行数
    [self addSubview:_text];
    
}

//1）.对于单行文本数据的显示调用+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;方法来得到文本宽度和高度。
//2）.对于多行文本数据的显示调用- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes context:(NSStringDrawingContext *)context ;方法来得到文本宽度和高度；同时注意在此之前需要设置文本控件的numberOfLines属性为0。
#pragma mark 设置微博
- (void)setNote:(Note *)note{
    
    CGFloat avatarX = 10,avatarY = 10;
    CGRect avatarRect = CGRectMake(avatarX, avatarY, kStatusTableViewCellAvatarWidth, kStatusTableViewCellAvatarHeight);
    _avatar.image = [UIImage imageNamed:note.profileImageUrl];
    _avatar.frame = avatarRect;
    
    CGFloat userNameX = CGRectGetMaxX(_avatar.frame) + kStatusTableViewCellControlSpacing;
    CGFloat userNameY = avatarY;
    CGSize userNameSize = [note.userName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize]}];  //获得文字的size，根据字体型号12，不同字体导致文字的size不同
    CGRect userNameRect = CGRectMake(userNameX, userNameY, userNameSize.width, userNameSize.height);
    _userName.text = note.userName;
    _userName.frame = userNameRect;
    
    CGFloat mbTypeX = CGRectGetMaxX(_userName.frame) + kStatusTableViewCellControlSpacing;
    CGFloat mbTypeY = avatarY;
    CGRect mbTypeRect = CGRectMake(mbTypeX, mbTypeY, kStatusTableViewCellMbTypeWidth, kStatusTableViewCellMbTypeHeight);
    _mbType.image = [UIImage imageNamed:note.mbtype];
    _mbType.frame = mbTypeRect;
    
    CGSize createAtSize = [note.createAt sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize]}];
    CGFloat createAtX = userNameX;
    CGFloat createAtY = CGRectGetMaxY(_avatar.frame) - createAtSize.height;//头像frame最大值-日期文字的高度
    CGRect createAtRect = CGRectMake(createAtX, createAtY, createAtSize.width, createAtSize.height);
    _creatrAt.text = note.createAt;
    _creatrAt.frame = createAtRect;
    
    CGSize sourceSize = [note.source sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize]}];
    CGFloat sourceX = CGRectGetMaxX(_creatrAt.frame) + kStatusTableViewCellControlSpacing;
    CGFloat sourceY = createAtY;
    CGRect sourceRect = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    _source.text = note.source;
    _source.frame = sourceRect;
    
    CGFloat textX = avatarX;
    CGFloat textY = CGRectGetMaxY(_avatar.frame) + kStatusTableViewCellControlSpacing;
    CGFloat textWidth = self.frame.size.width - 2 * kStatusTableViewCellControlSpacing;
    CGSize textSize = [note.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellTextFontSize]} context:nil].size;
    CGRect textRect = CGRectMake(textX, textY, textSize.width, textSize.height);
    _text.text = note.text;
    _text.frame = textRect;
    
    _cellHeight = CGRectGetMaxY(_text.frame) + kStatusTableViewCellControlSpacing;
    
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
