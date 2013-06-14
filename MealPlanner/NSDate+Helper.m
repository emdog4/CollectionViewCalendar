//
//  NSDate+Helper.m
//  MealPlanner
//
//  Created by Emery Clark on 2/16/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

+(NSInteger) weekdayOfFirstDateOfCurrentMonth
{
    
    //Get gregorian calendar
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //Today's date
    NSDate *today = [NSDate date];
    
    //Weekday components
    NSDateComponents *weekdayComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    
    //Set date to first day of the month
    [weekdayComponents setDay:1];
    
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:weekdayComponents];
    
    NSDateComponents *comp = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit) fromDate:firstDayOfMonthDate];
    
    NSInteger weekday = [comp weekday];
    //Return the weekday
    return weekday;
}



@end
