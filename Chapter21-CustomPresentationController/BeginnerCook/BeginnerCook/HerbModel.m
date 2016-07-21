//
//  HerbModel.m
//  BeginnerCook
//
//  Created by dudw on 16/7/21.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "HerbModel.h"

@implementation HerbModel

-(instancetype)initWithName:(NSString *)name image:(NSString *)image license:(NSString *)license credit:(NSString *)credit desc:(NSString *)desc{
    self = [super init];
    if (self) {
        _name = name;
        _image = image;
        _license = license;
        _credit = credit;
        _desc = desc;
    }
    
    return self;
}

- (NSArray *)allModels{
    if (_allModels.count) {
        
        HerbModel *Basil = [self initWithName:@"Basil" image:@"basil.jpg" license:@"http://creativecommons.org/licenses/by-sa/3.0" credit:@"http://commons.wikimedia.org/wiki/User:Castielli" desc:@"Basil is commonly used fresh in cooked recipes. In general, it is added at the last moment, as cooking quickly destroys the flavor. The fresh herb can be kept for a short time in plastic bags in the refrigerator, or for a longer period in the freezer, after being blanched quickly in boiling water. The dried herb also loses most of its flavor, and what little flavor remains tastes very different."];
        HerbModel *Saffron = [self initWithName:@"Saffron" image:@"saffron.jpg" license:@"http://creativecommons.org/licenses/by-sa/3.0" credit:@"http://commons.wikimedia.org/wiki/User:Lin%C3%A91" desc:@"Saffron's aroma is often described by connoisseurs as reminiscent of metallic honey with grassy or hay-like notes, while its taste has also been noted as hay-like and sweet. Saffron also contributes a luminous yellow-orange colouring to foods. Saffron is widely used in Indian, Persian, European, Arab, and Turkish cuisines. Confectioneries and liquors also often include saffron."];
        HerbModel *Marjoram = [self initWithName:@"Marjorana" image:@"marjorana.jpg" license:@"http://creativecommons.org/licenses/by-sa/3.0" credit:@"http://commons.wikimedia.org/wiki/User:Raul654"  desc:@"Marjoram is used for seasoning soups, stews, dressings and sauce. Majorana has been scientifically proved to be beneficial in the treatment of gastric ulcer, hyperlipidemia and diabetes. Majorana hortensis herb has been used in the traditional Austrian medicine for treatment of disorders of the gastrointestinal tract and infections."];
        HerbModel *Rosemary = [self initWithName:@"Rosemary" image:@"rosemary.jpg" license:@"http://www.gnu.org/licenses/old-licenses/fdl-1.2.html" credit:@"http://commons.wikimedia.org/wiki/User:Fir0002" desc:@"The leaves, both fresh and dried, are used in traditional Italian cuisine. They have a bitter, astringent taste and are highly aromatic, which complements a wide variety of foods. Herbal tea can be made from the leaves. When burnt, they give off a mustard-like smell and a smell similar to burning wood, which can be used to flavor foods while barbecuing. Rosemary is high in iron, calcium and vitamin B6."];
        HerbModel *Anise = [self initWithName:@"Anise" image:@"anise.jpg" license:@"http://commons.wikimedia.org/wiki/File:AniseSeeds.jpg" credit: @"http://commons.wikimedia.org/wiki/User:Ben_pcc" desc:@"Anise is sweet and very aromatic, distinguished by its characteristic flavor. The seeds, whole or ground, are used in a wide variety of regional and ethnic confectioneries, including black jelly beans, British aniseed balls, Australian humbugs, and others. The Ancient Romans often served spiced cakes with aniseseed, called mustaceoe at the end of feasts as a digestive. "];
        _allModels = @[Basil,Saffron,Marjoram,Rosemary,Anise];
    }
    
    return _allModels;
}

@end
