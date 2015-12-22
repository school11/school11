//
//  ZLTimer.m
//  time
//
//  Created by tiptimes on 15/12/11.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "ZLTimer.h"

@interface ZLTimer()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray * _nameArray;
    NSMutableArray * _hourArray;
    NSMutableArray * _hourLongArray;
    NSMutableArray * _minArray;
    NSMutableArray * _minLongArray;
    NSMutableArray * arr1;
    NSMutableArray * arr2;
    
}
@property(strong,nonatomic) UIPickerView * pickerView;

@property (nonatomic, strong)NSString *hourStr;

@property (nonatomic, strong)NSString *minuteStr;

@end

@implementation ZLTimer
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        _hourArray = [[NSMutableArray alloc] init];
        _hourLongArray = [[NSMutableArray alloc] init];
        _minArray = [[NSMutableArray alloc] init];
        _minLongArray = [[NSMutableArray alloc] init];
        
        [self createView];
        
        
    }
    return self;
}



-(void) createView{
    

    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
    [self.pickerView reloadAllComponents];//刷新pickerView
    _nameArray=[NSArray arrayWithObjects:@"今天",@"明天",@"后天",nil];
    
    
    //获取当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year = [dateComponent year];
    n = year;
    int month = [dateComponent month];
    y = month;
    int  day = (int)[dateComponent day];
    r = day;
    int  hour = (int)[dateComponent hour];
    int  minute = (int)[dateComponent minute];
    //    NSInteger second = [dateComponent second];
//    NSLog(@"%d-%d-%d",day,hour,minute);
    
    for (int i=hour; i<=24; i++) {
        [_hourArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for (int i=0; i<=23; i++) {
        [_hourLongArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    int tmp=minute/10;
    for (int i=tmp; i<=6; i++) {
        int p=i;
        [_minArray addObject:[NSString stringWithFormat:@"%d",p*10]];
    }
    for (int i=0; i<6; i++) {
        int p=i;
        [_minLongArray addObject:[NSString stringWithFormat:@"%d",p*10]];
    }
    arr1=[[NSMutableArray alloc] initWithArray:_hourArray];
    arr2=[[NSMutableArray alloc] initWithArray:_minArray];
    self.hourStr = _hourArray[0];
    self.minuteStr = _minArray[0];
    self.timeString = [NSString stringWithFormat:@"%d-%d-%d %@:%@",n,y,r,self.hourStr,self.minuteStr];
}

#pragma mark-----delegate---

//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return  3;
    } else if(component==1){
        
        return  [_hourArray count];
    }
    return [_minArray count];
}
////返回指定列，行的高度，就是自定义行的高度
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 20.0f;
//}
////返回指定列的宽度
//- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    if (component==0) {
//        return  350/3;
//    } else if(component==1){
//        return  350/3;
//    }
//    return  350/3;
//}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, 30)];
    
    NSString *str;
    if (component==0) {
        str = [_nameArray objectAtIndex:row];
    } else if(component==1){
        str = [_hourArray objectAtIndex:row];
    }else{
        str = [_minArray objectAtIndex:row];
    }
    
    text.textAlignment = NSTextAlignmentCenter;
    text.text = str;
    [view addSubview:text];
    
    return view;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component==0) {
        NSString *str = [_nameArray objectAtIndex:row];
        return str;
    } else if(component==1){
        NSString *str = [_hourArray objectAtIndex:row];
        return str;
    }
    NSString *str = [_minArray objectAtIndex:row];
    return str;
}

//显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str;
    if (component==0) {
        str = [_nameArray objectAtIndex:row];
    } else if(component==1){
        str = [_hourArray objectAtIndex:row];
    }else{
        str = [_minArray objectAtIndex:row];
    }
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;
}
//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
    
    
    if (component == 0) {
        a = row;
        
        NSLog(@"日   %d",a );
        if (row == 0) {
            [_hourArray removeAllObjects];
            [_hourArray addObjectsFromArray:arr1];
            [_minArray removeAllObjects];
            [_minArray addObjectsFromArray:arr2];
            [self.pickerView reloadAllComponents];
        }else{
            
            [_hourArray removeAllObjects];
            [_hourArray addObjectsFromArray:_hourLongArray];
            [_minArray removeAllObjects];
            [_minArray addObjectsFromArray:_minLongArray];
            [self.pickerView reloadAllComponents];
            
        }
    }
    else if (component == 1)
    {
        b=row;
        self.hourStr = _hourArray[row];
        NSLog(@"时   %d",b  );

    }
    else
    {
        c = row;
        self.minuteStr = _minArray[row];
        NSLog(@"分   %d",c );
    }
    r = r + a;

    self.timeString = [NSString stringWithFormat:@"%d-%d-%d %@:%@",n,y,r,self.hourStr,self.minuteStr];
}
@end
