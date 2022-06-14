//
//  EpisodeOCModel.h
//  PodcastDemo
//
//  Created by leo on 2022/6/14.
//

#import <Foundation/Foundation.h>

@class EpisodeOCModel ;
@class EpisodeOCItem ;


@interface EpisodeOCModel : NSObject
@property  (nonatomic, copy) NSString *title;
@property  (nonatomic, copy) NSString *headImageUrl;
@property  (nonatomic, copy) NSArray<EpisodeOCItem *> *items;
@end


@interface EpisodeOCItem : NSObject

@property  (nonatomic, copy) NSString *title;
@property  (nonatomic, copy) NSString *date;
@property  (nonatomic, copy) NSString *summary;
@property  (nonatomic, copy) NSString *image;
@property  (nonatomic, copy) NSString *url;
@property  (nonatomic, copy) NSString *type;
@property  (nonatomic, copy) NSString *length;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

