//
//  HomeCollectionView.m
//  alarm
//
//  Created by 钟文锋  on 15/10/24.
//  Copyright © 2015年 vinfol. All rights reserved.
//

#import "HomeCollectionView.h"
#import "HomeCollectionViewCellModel.h"
#define ViewTag 1000
#define ImageBackgroundViewColor [UIColor colorWithRed:232/255.0 green:240/255.0 blue:195/255.0 alpha:0.2]
@interface HomeCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel* tipLabel;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UIView *seperatorLine;

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* didSelectArray;
@property (nonatomic, strong) NSMutableArray* selectedArray;
@end

@implementation HomeCollectionView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self addSubview:self.tipLabel];
        [self.collectionView addSubview:self.seperatorLine];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate&DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"HomeCollectionViewCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    HomeCollectionViewCellModel *model = (HomeCollectionViewCellModel *)self.data[indexPath.row + indexPath.section*4];
    
    UIView *imageBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45*kAdaptPixel, 45*kAdaptPixel)];
    imageBackgroundView.centerX = cell.width/2;
    imageBackgroundView.tag = indexPath.row + indexPath.section*4 + ViewTag;
    imageBackgroundView.layer.cornerRadius = imageBackgroundView.width/2;
    imageBackgroundView.backgroundColor = ImageBackgroundViewColor;
    imageBackgroundView.layer.masksToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25*kAdaptPixel, 25*kAdaptPixel)];
    imageView.centerX = imageBackgroundView.width/2;
    imageView.centerY = imageBackgroundView.height/2;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:model.imageNamed];
    [imageBackgroundView addSubview:imageView];
    
    [cell addSubview:imageBackgroundView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 52*kAdaptPixel, cell.width, 15*kAdaptPixel)];
    label.text = model.title;
    label.textColor = [UIColor groupTableViewBackgroundColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:11*kAdaptPixel];
    [cell addSubview:label];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.width/5, 65*kAdaptPixel);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10*kAdaptPixel, 15*kAdaptPixel, 15*kAdaptPixel, 10*kAdaptPixel);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *backgroundView = [collectionView viewWithTag:indexPath.row + indexPath.section*4 + ViewTag];
    HomeCollectionViewCellModel *model = (HomeCollectionViewCellModel *)self.data[indexPath.row + indexPath.section*4];
    
    if (![self.didSelectArray[indexPath.row + indexPath.section*4] boolValue]) {
        [self.selectedArray addObject:model];
        [self.didSelectArray setObject:@YES atIndexedSubscript:indexPath.row + indexPath.section*4];
        [UIView animateWithDuration:0.3f animations:^{
            backgroundView.backgroundColor = model.backgroundColor;
        }];
    }else {
        [self.selectedArray removeObject:model];
        [self.didSelectArray setObject:@NO atIndexedSubscript:indexPath.row + indexPath.section*4];
        [UIView animateWithDuration:0.3f animations:^{
            backgroundView.backgroundColor = ImageBackgroundViewColor;
        }];
    }
    
    
    if ([self.homeDelegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.homeDelegate didSelectItem:self.selectedArray];
    }
}


#pragma mark - getters and setters

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 30*kAdaptPixel, self.width, self.height - 30*kAdaptPixel) collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled = NO;
        [_collectionView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.2]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*kAdaptPixel, 5*kAdaptPixel, 120*kAdaptPixel, 20*kAdaptPixel)];
        _tipLabel.text = @"您今天：";
        _tipLabel.textColor = [UIColor groupTableViewBackgroundColor];
        _tipLabel.font = [UIFont systemFontOfSize:13*kAdaptPixel];
    }
    return _tipLabel;
}

- (UIView *)seperatorLine
{
    if (!_seperatorLine) {
        _seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(15*kAdaptPixel, self.collectionView.height/2 + 5*kAdaptPixel, self.width - 15*kAdaptPixel, 0.5)];
        _seperatorLine.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    }
    return _seperatorLine;
}

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];

        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"轻度运动过"
                                                      imageNamed:@"轻度运动"
                                                 backgroundColor:[UIColor colorWithRed:1 green:94/255.0 blue:94/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"剧烈运动过"
                                                      imageNamed:@"剧烈运动"
                                                 backgroundColor:[UIColor colorWithRed:51/255.0 green:194/255.0 blue:255/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"吃了宵夜"
                                                      imageNamed:@"宵夜"
                                                 backgroundColor:[UIColor colorWithRed:1 green:141/255.0 blue:54/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"喝了酒"
                                                      imageNamed:@"酒"
                                                 backgroundColor:[UIColor colorWithRed:162/255.0 green:120/255.0 blue:255/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"压力大"
                                                      imageNamed:@"压力"
                                                 backgroundColor:[UIColor colorWithRed:31/255.0 green:196/255.0 blue:53/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"失眠"
                                                      imageNamed:@"失眠"
                                                 backgroundColor:[UIColor colorWithRed:237/255.0 green:114/255.0 blue:215/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"喝了咖啡"
                                                      imageNamed:@"咖啡"
                                                 backgroundColor:[UIColor colorWithRed:1 green:141/255.0 blue:54/255.0 alpha:0.8]]];
        [_data addObject:[HomeCollectionViewCellModel makeHomeCollectionViewCellModel:@"兴奋"
                                                      imageNamed:@"兴奋"
                                                 backgroundColor:[UIColor colorWithRed:237/255.0 green:114/255.0 blue:215/255.0 alpha:0.8]]];

    }
    return _data;
}

- (NSMutableArray *)didSelectArray
{
    if (!_didSelectArray) {
        _didSelectArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.data count]; i ++) {
            [_didSelectArray addObject:@NO];
        }
    }
    return _didSelectArray;
}

- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [[NSMutableArray alloc] init];
    }
    return _selectedArray;
}

@end
