
用法：
```

NSTimeInterval timeInterval = 1513598888;
NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
NSString *str = [DateConvertUtil convertToStringWithNSDate:date dateFormatter:nil];
[_datas addObject:str];
str = [DateConvertUtil convertToStringWithTimeInterval:timeInterval dateFormatter:nil];
[_datas addObject:str];

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

str = [DateConvertUtil convertToStringWithNSDate:date dateFormatter:dateFormatter];
[_datas addObject:str];
str = [DateConvertUtil convertToStringWithTimeInterval:timeInterval dateFormatter:dateFormatter];
[_datas addObject:str];

str = [NSString stringWithFormat:@"is now before date : %@",[DateConvertUtil isNowTimeBeforeDate:date]?@"yes":@"no"];
[_datas addObject:str];
str = [NSString stringWithFormat:@"is now before timeInterval : %@",[DateConvertUtil isNowTimeBeforeTimeInterval:timeInterval]?@"yes":@"no"];
[_datas addObject:str];

str = [NSString stringWithFormat:@"now time is : %@",[DateConvertUtil getNowDateStringWithDateFormatter:dateFormatter]];
[_datas addObject:str];

str = [NSString stringWithFormat:@"weekday of date:%@",[DateConvertUtil weekdayStringFromDate:date]];
[_datas addObject:str];

```
