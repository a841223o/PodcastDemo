//
//  EpisodeModelOC.m
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

#import "EpisodeOCModel.h"

@implementation EpisodeOCModel
@end


@implementation EpisodeOCItem

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.title = dictionary[@"title"] ;
        self.title = [self.title stringByTrimmingCharactersInSet : [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.summary = dictionary[@"itunes:summary"];
        self.summary = [self.summary stringByTrimmingCharactersInSet : [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.image = dictionary[@"image"];
        self.date = dictionary[@"pubDate"];
        self.date = [self.date stringByTrimmingCharactersInSet : [NSCharacterSet whitespaceAndNewlineCharacterSet]];
       

        self.url = dictionary[@"enclosure"][@"url"];
        self.type = dictionary[@"enclosure"][@"type"];
        self.length = dictionary[@"enclosure"][@"length"];
    }
    return self;
}

@end
