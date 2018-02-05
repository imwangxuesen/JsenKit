//
//  NSString+JsenKit.m
//  JsenKit
//
//  Created by WangXuesen on 2017/7/31.
//  Copyright © 2017年 WangXuesen. All rights reserved.
//

#import "NSString+JsenKit.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSObject+JsenKit.h"

@implementation NSString (JsenKit)

- (NSString *)jsen_md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const void *str = [data bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)data.length, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

- (NSString *)jsen_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)jsen_base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


- (NSString *)js_whitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
}


- (NSString *)js_whiteAllSpace {
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

+(BOOL)js_checkIdentityCardNo:(NSString*)cardNo
{
    BOOL flag;
    if (cardNo.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:cardNo];
}

+ (BOOL)js_doCheckEmailFormat:(NSString *)email
{
    BOOL checkResult = YES;
    
    checkResult = ![self isValueEmpty:email];
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if (![emailTest evaluateWithObject:email]) {
        checkResult = NO;
    }
    
    return checkResult;
}

+ (BOOL)js_doCheckMobilePhoneNumber:(NSString *)phoneNumber {
    BOOL checkResult = YES;
    checkResult = ![self isValueEmpty:phoneNumber];
    
    if (checkResult) {
        NSString *mobilePhoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *mobilePhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobilePhoneRegex];
        if (![mobilePhoneTest evaluateWithObject:phoneNumber]) {
            checkResult = NO;
        }
    }
    
    return checkResult;
}


+ (BOOL)js_doCheckPasswordBit:(NSString *)password {
    BOOL checkResult = YES;
    checkResult = ![self isValueEmpty:password];
    if (checkResult && [password js_charNumber] >= 6 && [password js_charNumber] <=20) {
        checkResult = YES;
    } else {
        checkResult = NO;
    }
    return checkResult;
}

+ (BOOL)js_doCheckValidateCodeBit:(NSString *)validateCode {
    BOOL checkResult = YES;
    checkResult = ![self isValueEmpty:validateCode];
    if (checkResult && [validateCode js_charNumber] == 6) {
        checkResult = YES;
    } else {
        checkResult = NO;
    }
    return checkResult;
}


- (int)js_charNumber{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)js_urlencode {
    return [[NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] absoluteString];
}

- (BOOL)js_isUrl
{
    if(self == nil)
        return NO;
    NSString *url;
    if (self.length>4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = self;
    }
    NSString *urlRegex = @"(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}


- (NSString *)js_encryptPhone {
    NSRange range = NSMakeRange(2, 4);
    return [self stringByReplacingCharactersInRange:range withString:@"****"];
}

- (BOOL)js_containString:(NSString *)str {
    if (!str || str.length <= 0) {
        return NO;
    }
    
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:str];
    }
    
    return [self rangeOfString:str].location != NSNotFound;
}


- (NSString *)js_removeMagicalCharacter {
    if (self.length == 0) {
        return self;
    }
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\u0300-\u036F]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""];
    return modifiedString;
}

+ (CGFloat)js_heightForString:(UIView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

@end
