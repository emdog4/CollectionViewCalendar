//
//  CalendarViewController.m
//  MealPlanner
//
//  Created by Emery Clark on 2/16/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import "CalendarViewController.h"
#import "CollectionViewCell.h"
#import "NSDate+Helper.h"

@interface CalendarViewController () {
    NSInteger totalDaysInMonth;
    //NSInteger firstWeekdayDayOfMonth;
    NSRange daysInMonth;
    NSMutableArray *entireMonthDates;
}
@property NSInteger totalDaysInMonth;
//@property NSInteger firstWeekdayDayOfMonth;
@property NSRange daysInMonth;
@property NSMutableArray *entireMonthDates;


@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.entireMonthDates = [[NSMutableArray alloc] init];
    
    NSDate *today = [NSDate date];
    
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents = [currentCalendar components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    
    NSInteger month = [weekdayComponents month];
    
    
    NSDateComponents *components = [currentCalendar components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    
    if(month == 1){
        [components setMonth:12];
    } else {
        [components setMonth:month-1];
    }
    [components setDay:1];
    
    NSDate *previousMonthDate = [currentCalendar dateFromComponents:components];
    
    NSRange daysInPreviousMonth = [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:previousMonthDate];
    NSInteger daysInPreviousMonthLength = daysInPreviousMonth.length;
    
    
    int firstWeekdayDayOfMonth = [NSDate weekdayOfFirstDateOfCurrentMonth];
    
    
    if(firstWeekdayDayOfMonth != 1)
    {

        int a = daysInPreviousMonthLength - (firstWeekdayDayOfMonth-2);
            
        for(int i=0; i < firstWeekdayDayOfMonth-1; i++)
        {
            
            NSNumber *wrapped = [NSNumber numberWithInt:a+i];
            
            [self.entireMonthDates addObject:wrapped];
            
        }
    }
    
    self.daysInMonth = [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];
    
    
    for(int i=1;i<self.daysInMonth.length+1;i++)
    {
        NSNumber *wrapped = [NSNumber numberWithInt:i];
        [self.entireMonthDates addObject:wrapped];
    }
    
    
    
    
    NSDateComponents *components2 = [currentCalendar components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    int lastday = self.daysInMonth.length;
    
    [components2 setDay:lastday];
    [components2 setHour:0];
    [components2 setMinute:5];
    //components2
    
    NSDate *lastDayOfMonthDate = [currentCalendar dateFromComponents:components2];
    
    NSDateComponents *comp3 = [currentCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:lastDayOfMonthDate];
    
    int weekdayOfLastDayOfMonth = [comp3 weekday];
    
    if(weekdayOfLastDayOfMonth != 7)
    {
        int daysInNextMonthLength = 7-weekdayOfLastDayOfMonth;
        
        for(int i=1; i<daysInNextMonthLength; i++)
        {
            NSNumber *wrapped = [NSNumber numberWithInt:i];
            [self.entireMonthDates addObject:wrapped];
        }
    }
    
    //self.totalDaysInMonth = daysInMonth.length + firstWeekdayDayOfMonth - 1;
    
    
    //NSLog(@"%u, %@",[self.entireMonthDates count], [self.entireMonthDates description]);
        
    
    
	//self.dataSource = @[@"Jan", @"Feb", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    //NSLog(@"%u",self.dataSource.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIColllectionViewController delegate methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return self.dataSource.count;
    return self.entireMonthDates.count;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.myLabel.text = [NSString stringWithFormat:@"%u",[[self.entireMonthDates objectAtIndex:indexPath.row] integerValue]];
    
    //UILabel *mealsPlanned = [[UILabel alloc] initWithFrame:CGRectMake(36, 36, 75, 20)];
    //[mealsPlanned setText:@"Meals Planned"];
    //[cell addSubview:mealsPlanned];
    
    
    //NSLog(@"%@", [self.dataSource objectAtIndex:indexPath.row]);
    NSLog(@"%@", @"hit");
    //if(indexPath.row < self.firstWeekdayDayOfMonth) {
        
    //}
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout  *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    
    //NSLog(@"%f, %f",screenWidth/7,screenHeight/7);
    
    //return CGSizeMake(screenWidth/7,screenHeight/7);
    
    // Adjust cell size for orientation
    if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        return CGSizeMake(146.f, 140.f);
    } else {
        return CGSizeMake(109.f, 109.f);
    }
    
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.collectionView performBatchUpdates:nil completion:nil];
}

@end
