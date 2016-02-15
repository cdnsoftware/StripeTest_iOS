//
//  UIImage+NewImage.m
//  DealWheel
//
//  Created by Mayank Jain on 05/08/15.
//  Copyright (c) 2015 Deal Wheel Inc.. All rights reserved.
//

#import "UIImage+NewImage.h"
#import "Constant.h"

@implementation UIImage (NewImage)

+ (UIImage*)universalImageName:(NSString*)imageName
{
    
    if (IS_IPHONE_5) {
        
        NSMutableString *imageNameMutable = [imageName mutableCopy];
        
        //Delete png extension
        NSRange extension = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
        if (extension.location != NSNotFound) {
            [imageNameMutable deleteCharactersInRange:extension];
        }
        
        //Look for @2x to introduce -568h string
        NSRange retinaAtSymbol = [imageName rangeOfString:@"@2x"];
        if (retinaAtSymbol.location != NSNotFound) {
            [imageNameMutable insertString:@"-568h" atIndex:retinaAtSymbol.location];
        } else {
            [imageNameMutable appendString:@"-568h@2x"];
        }
        
        //Check if the image exists and load the new 568 if so or the original name if not
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
        if (imagePath) {
            //Remove the @2x to load with the correct scale 2.0
            return [UIImage imageNamed:imageNameMutable];
        } else {
            return [UIImage imageNamed:imageName];
        }
        
    } else if (IS_IPHONE_6){
        NSMutableString *imageNameMutable = [imageName mutableCopy];
        
        //Delete png extension
        NSRange extension = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
        if (extension.location != NSNotFound) {
            [imageNameMutable deleteCharactersInRange:extension];
        }
        
        [imageNameMutable appendString:@"-667h@2x"];
        
        //Check if the image exists and load the new 568 if so or the original name if not
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
        if (imagePath) {
            // NSLog(@"image name OUTPUT  %@\n", imageNameMutable);
            
            //Remove the @2x to load with the correct scale 2.0
            return [UIImage imageNamed:imageNameMutable];
        } else {
            return [UIImage imageNamed:imageName];
        }
    }
    
    else if (IS_IPHONE_6P){
        NSMutableString *imageNameMutable = [imageName mutableCopy];
        
        //Delete png extension
        NSRange extension = [imageName rangeOfString:@".png" options:NSBackwardsSearch | NSAnchoredSearch];
        if (extension.location != NSNotFound) {
            [imageNameMutable deleteCharactersInRange:extension];
        }
        
        //Look for @2x to introduce -568h string
        [imageNameMutable appendString:@"@3x"];
        
        //Check if the image exists and load the new 568 if so or the original name if not
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageNameMutable ofType:@"png"];
        if (imagePath) {
            //Remove the @2x to load with the correct scale 2.0
            // NSLog(@"image name OUTPUT 6+  %@", imageNameMutable);
            return [UIImage imageNamed:imageNameMutable];
        } else {
            return [UIImage imageNamed:imageName];
        }
    }else {
        return [UIImage imageNamed:imageName];
    }
}

@end
