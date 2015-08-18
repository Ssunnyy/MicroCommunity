//
//  HZLocation.m
//  areapicker
//
//  Created by Cloud Dai on 15-8-17.
//  Copyright (c) 2015年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>
#import "MCHomeCityModel.h"

#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
}

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id<HZAreaPickerDelegate>)delegate
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0] ;
    if (self) {
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citys.plist" ofType:nil]];
        
        provinces = [[[data objectForKey:@"data"]objectAtIndex:0]objectForKey:@"_child"];
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (int i = 0; i < provinces.count; i ++) {
            
            MCHomeCityModel *cityModel = [[MCHomeCityModel alloc]initWithDataDic:[provinces objectAtIndex:i]];
            
            NSMutableArray *cityArray = [NSMutableArray array];
            for (int j = 0 ; j < cityModel._child.count; j ++) {
                MCHomeCityModel *city = [[MCHomeCityModel alloc]initWithDataDic:[cityModel._child objectAtIndex:j]];
                NSMutableArray *areaArray = [NSMutableArray array];
                
                for (int m = 0; m < city._child.count; m ++) {
                    MCHomeCityModel *area = [[MCHomeCityModel alloc]initWithDataDic:[city._child objectAtIndex:m]];
                    [areaArray addObject:area];
                }
                
                city._child = areaArray;
                
                [cityArray addObject:city];
            }
            
            cityModel._child = cityArray;
            
            [dataArray addObject:cityModel];
        }

        
        //加载数据
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
            
            provinces = dataArray;
            MCHomeCityModel *province = (MCHomeCityModel *)[provinces objectAtIndex:0];
            cities = province._child;
            MCHomeCityModel *city = (MCHomeCityModel *)[cities objectAtIndex:0];
            
            self.locate.state = province.region_name;
            self.locate.city = city.region_name;
            
            areas = city._child;
            if (areas.count > 0) {
                MCHomeCityModel *area = [city._child objectAtIndex:0];
                self.locate.district = area.region_name;
            } else{
                self.locate.district = @"";
            }
            
        } else{
            provinces = dataArray;
            MCHomeCityModel *province = (MCHomeCityModel *)[provinces objectAtIndex:0];
            cities = province._child;
            MCHomeCityModel *city = (MCHomeCityModel *)[cities objectAtIndex:0];
            
            self.locate.state = province.region_name;
            self.locate.city = city.region_name;
        }
    }
        
    return self;
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
                return [areas count];
                break;
            }
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                
            {
                MCHomeCityModel *privince = (MCHomeCityModel*)[provinces objectAtIndex:row];
                return privince.region_name;
            }
                break;
            case 1:
            {
                MCHomeCityModel *city = (MCHomeCityModel*)[cities objectAtIndex:row];
                return city.region_name;
            }
                break;
            case 2:
                if ([areas count] > 0) {
                    {
                        MCHomeCityModel *area = (MCHomeCityModel *)[areas objectAtIndex:row];
                        return area.region_name;
                    }
                    break;
                }
            default:
                return  @"";
                break;
        }
    } else{
        switch (component) {
            case 0:
                
            {
                MCHomeCityModel *privince = (MCHomeCityModel*)[provinces objectAtIndex:row];
                return privince.region_name;
            }
                break;
            case 1:
            {
                MCHomeCityModel *city = (MCHomeCityModel*)[cities objectAtIndex:row];
                return city.region_name;
            }
                break;
            default:
                return @"";
                break;
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
            {
                MCHomeCityModel *privince = (MCHomeCityModel *)[provinces objectAtIndex:row];
                cities = privince._child;
                MCHomeCityModel *city = (MCHomeCityModel *)[cities objectAtIndex:0];
                
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                areas = city._child;
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.state = privince.region_name;
                self.locate.city = city.region_name;
                if ([areas count] > 0) {
                    MCHomeCityModel *area = (MCHomeCityModel *)[areas objectAtIndex:0];
                    self.locate.district = area.region_name;
                } else{
                    self.locate.district = @"";
                }
            }
                break;
            case 1:
            {
                
                MCHomeCityModel *city = (MCHomeCityModel *)[cities objectAtIndex:row];
                areas = city._child;

                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = city.region_name;
                
                if ([areas count] > 0) {
                    MCHomeCityModel *area = (MCHomeCityModel *)[areas objectAtIndex:0];
                    self.locate.district = area.region_name;
                } else{
                    self.locate.district = @"";
                }
            }
                break;
            case 2:
            {
                if ([areas count] > 0) {
                    MCHomeCityModel *area = (MCHomeCityModel *)[areas objectAtIndex:row];
                    self.locate.district = area.region_name;
                } else{
                    self.locate.district = @"";
                }
            }
                break;
            default:
                break;
        }
    } else{
        switch (component) {
            case 0:
            {
                MCHomeCityModel *privince = (MCHomeCityModel *)[provinces objectAtIndex:row];
                cities = privince._child;
                MCHomeCityModel *city = (MCHomeCityModel *)[cities objectAtIndex:0];
                

                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.state = privince.region_name;
                self.locate.city = city.region_name;
            }
                break;
            case 1:
            {
                MCHomeCityModel *city = (MCHomeCityModel *)[cities objectAtIndex:row];
                self.locate.city = city.region_name;
            }
                break;
            default:
                break;
        }
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}

@end
