//
//  SelectionViewController.m
//  Jambro
//
//  Created by Faraz Haider on 15/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "SelectionViewController.h"
#import "Play.h"
#import "Listen.h"
#import "Looking.h"
#import "BiosViewController.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "UtilitiesHelper.h"
#import "Selection.h"
#import "SelectionCollectionViewCell.h"
#import "SoundManager.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface SelectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
        CGRect collectionViewFrame;
    int indexOfPage;
    Selection *selection;
}
@property (weak, nonatomic) IBOutlet UICollectionView *selectionCollectionView;
@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    collectionViewFrame = CGRectZero;
    indexOfPage = 1;
//    NSLog(@"%@",[self getJsonDataFromFile]);
    
    [[SoundManager sharedManager] prepareToPlay];
    
    if ([UtilitiesHelper getUserDefaultForKey:@"Selection"]) {
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        selection = [defaults rm_customObjectForKey:@"Selection"];
        
    }else{
        [self setSelectionData];
        
//    NSMutableArray *selectionArray =[self getJsonDataFromFile];
//    
//    NSMutableDictionary *selectionDictionary = [[NSMutableDictionary alloc]init];
//        selectionDictionary = [selectionArray[0] mutableCopy];
//        
//    selection.play = [[selectionDictionary objectForKey:@"play"] mutableCopy];
//    selection.looking = [[selectionDictionary objectForKey:@"looking"] mutableCopy];
//    selection.listen = [[selectionDictionary objectForKey:@"listen"]mutableCopy ];
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden = TRUE;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
     if (CGRectEqualToRect(CGRectZero, collectionViewFrame)) {
    collectionViewFrame = self.selectionCollectionView.frame;
     }
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
     self.navigationController.navigationBar.hidden = FALSE;
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    UICollectionViewFlowLayout *flowLayout = (id)self.selectionCollectionView.collectionViewLayout;
    
    CGFloat screenWidth = collectionViewFrame.size.width;
    float cellWidth = screenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    flowLayout.itemSize = size;
    
   [flowLayout invalidateLayout];
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if (indexOfPage == 1) {
        return selection.play.count;
    }
    else if (indexOfPage == 2)
    {
        return selection.listen.count;
    }
    else
    return selection.looking.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *selectionCollectionViewCell;
    
    Play *playObject;
    Listen *listenObject;
    Looking * lookingObject;
//    UIView * selectionView = [selectionCollectionViewCell viewWithTag:100];
//    UILabel *selectionNameLabel = [selectionCollectionViewCell viewWithTag:200];
    
    if(indexOfPage == 1)
    {
        SelectionCollectionViewCell *playCV= (SelectionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectionCell" forIndexPath:indexPath];
        
        playObject = selection.play[indexPath.row];
        
        playCV.bgView.backgroundColor = [UIColor clearColor];
        playCV.bgView.alpha = 1.0;
        playCV.bgView.layer.cornerRadius = playCV.bounds.size.width/2;
        playCV.bgView.layer.borderWidth = 1.0f;
        playCV.bgView.layer.borderColor = [UIColor blackColor].CGColor;
        playCV.bgView.layer.masksToBounds = YES;
        playCV.bgView.clipsToBounds = YES;
        
        if ([playObject.selected boolValue]) {
            UIColor * color = [self colorFromHexString:playObject.color];
            playCV.bgView.backgroundColor = color;
            playCV.bgView.alpha = 0.8;
        }

        playCV.nameLabel.text = playObject.name;
        playCV.nameLabel.textColor = [playObject.selected boolValue]?[UIColor whiteColor]:[UIColor blackColor];
        
        selectionCollectionViewCell = playCV;
    }
    else if (indexOfPage == 2)
    {
         SelectionCollectionViewCell*listenCV= (SelectionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectionCell" forIndexPath:indexPath];
        
        listenObject = selection.listen[indexPath.row];
        
        listenCV.bgView.backgroundColor = [UIColor clearColor];
        listenCV.bgView.alpha = 1.0;
        listenCV.bgView.layer.cornerRadius = listenCV.bounds.size.width/2;
        listenCV.bgView.layer.borderWidth = 1.0f;
        listenCV.bgView.layer.borderColor = [UIColor blackColor].CGColor;
        listenCV.bgView.layer.masksToBounds = YES;
        listenCV.bgView.clipsToBounds = YES;
        
        if ([listenObject.selected boolValue]) {
            UIColor * color = [self colorFromHexString:listenObject.color];
            listenCV.bgView.backgroundColor = color;
            listenCV.bgView.alpha = 0.8;
        }

        listenCV.nameLabel.text = listenObject.name;
        listenCV.nameLabel.textColor = [listenObject.selected boolValue]?[UIColor whiteColor]:[UIColor blackColor];
        
        
        selectionCollectionViewCell = listenCV;
    }
     else
     {
          SelectionCollectionViewCell*lookingCV= (SelectionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectionCell" forIndexPath:indexPath];
         lookingObject = selection.looking[indexPath.row];
         lookingCV.bgView.backgroundColor = [UIColor clearColor];
         lookingCV.bgView.alpha = 1.0;
         lookingCV.bgView.layer.cornerRadius = lookingCV.bounds.size.width/2;
         lookingCV.bgView.layer.borderWidth = 1.0f;
         lookingCV.bgView.layer.borderColor = [UIColor blackColor].CGColor;
         lookingCV.bgView.layer.masksToBounds = YES;
         lookingCV.bgView.clipsToBounds = YES;
         
         if ([lookingObject.selected boolValue]) {
             UIColor * color = [self colorFromHexString:lookingObject.color];
             lookingCV.bgView.backgroundColor = color;
             lookingCV.bgView.alpha = 0.8;
         }

         lookingCV.nameLabel.text = lookingObject.name;
         lookingCV.nameLabel.textColor = [lookingObject.selected boolValue]?[UIColor whiteColor]:[UIColor blackColor];
         selectionCollectionViewCell = lookingCV;
     }
    
    return selectionCollectionViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    Play *playObject;
    Listen *listenObject;
    Looking * lookingObject;
    
    if(indexOfPage == 1)
    {
        playObject = selection.play[indexPath.row];;
        playObject.selected = [playObject.selected boolValue]?@"0":@"1";
       
        
        if ([playObject.selected boolValue]) {
            [[SoundManager sharedManager] playSound:playObject.sound looping:NO];
        }
        
        for (Play *local in selection.play){
            if ([local.playId isEqualToString:playObject.playId])
            {
                local.selected = playObject.selected;
            }
        }


        
        
    }
    else if (indexOfPage == 2)
    {
        listenObject = selection.listen[indexPath.row];;
        listenObject.selected = [listenObject.selected boolValue]?@"0":@"1";
        
        if ([listenObject.selected boolValue]) {
            [[SoundManager sharedManager] playSound:listenObject.sound looping:NO];
        }
        
        for (Listen *local in selection.listen){
            if ([local.listenId isEqualToString:listenObject.listenId])
            {
                local.selected = listenObject.selected;
            }
        }
        

    }
    else
    {
        lookingObject = selection.looking[indexPath.row];;
        lookingObject.selected = [lookingObject.selected boolValue]?@"0":@"1";
        
        if ([lookingObject.selected boolValue]) {
            [[SoundManager sharedManager] playSound:lookingObject.sound looping:NO];
        }
        
        
        
        for (Looking *local in selection.looking){
            if ([local.lookingId isEqualToString:lookingObject.lookingId])
            {
                local.selected = lookingObject.selected;
            }
        }
        
    }
    

        [self.selectionCollectionView reloadData];
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = collectionViewFrame.size.width;
    float cellWidth = screenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)getJsonDataFromFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Selection" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray * arrayJson = [NSMutableArray arrayWithArray:json];
    
    return arrayJson;
}

- (IBAction)nextButtonClicked:(id)sender {
    indexOfPage ++;
    if (indexOfPage == 4) {
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults rm_setCustomObject:selection forKey:@"Selection"];
        
        BiosViewController * biosVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BiosViewController"];
        [self.navigationController pushViewController:biosVC animated:YES];
        return;
    }
     self.selectionCollectionView.alpha = 0;
    
    [self.selectionCollectionView reloadData];
    [self.selectionCollectionView performBatchUpdates:^{
        [self.selectionCollectionView.collectionViewLayout invalidateLayout];
//        [self.selectionCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
//
//        dispatch_async(dispatch_get_main_queue(), ^ {
//             [self.selectionCollectionView reloadData];
//        });
      
    } completion:^(BOOL finished)
     {
         self.selectionCollectionView.alpha = 1.0;
     }];

}



- (IBAction)previousButtonClicked:(id)sender {
    indexOfPage --;
    if (indexOfPage == 0) {
        return;
    }
   self.selectionCollectionView.alpha = 0;
    [self.selectionCollectionView reloadData];
    [self.selectionCollectionView performBatchUpdates:^{
////        dispatch_async(dispatch_get_main_queue(), ^ {
////            [self.selectionCollectionView reloadData];
////        });
////         [self.selectionCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
         [self.selectionCollectionView.collectionViewLayout invalidateLayout];
    } completion:^(BOOL finished)
     {
         self.selectionCollectionView.alpha = 1.0;
     }];

}


-(UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}




-(void)setSelectionData
{
    NSMutableDictionary * selectionDictionary = [NSMutableDictionary dictionary];
        NSMutableArray * lookingArray = [NSMutableArray array];
        NSMutableArray * listenArray = [NSMutableArray array];
        NSMutableArray * playArray = [NSMutableArray array];
    
    
    NSArray * nameArray = @[@"Guitar",
                            @"Drums",
                            @"Bass",
                            @"Keyboard",
                            @"Vocals",
                            @"Flute",
                            @"Percussion",
                            @"Piano",
                            @"Violin",
                            @"Saxophone",
                            @"Tabla",
                            @"Harmonium",
                            @"Harmonica",
                            @"Strings",
                            @"Eastern",
                            @"Other",
                            @"Rock",
                            @"Pop",
                            @"Blues",
                            @"Jazz",
                            @"Funk",
                            @"Folk",
                            @"R&B",
                            @"Hip-hop",
                            @"Classical",
                            @"Latin",
                            @"World",
                            @"Reggae",
                            @"Country",
                            @"Metal",
                            @"Eastern",
                            @"Other"];
    
    
    NSArray * colorArray = @[@"#39BD95",
                             @"#9D5789",
                             @"#AA9F8F",
                             @"#854030",
                             @"#505068",
                             @"#5EB3DD",
                             @"#E56846",
                             @"#6B8BA5",
                             @"#ABC14D",
                             @"#DD8597",
                             @"#65704D",
                             @"#D462B9",
                             @"#204496",
                             @"#8D90B2",
                             @"#1F8989",
                             @"#FF9999",
                             @"#4B6479",
                             @"#EB73F4",
                             @"#1FBBFF",
                             @"#9C8C5A",
                             @"#00A000",
                             @"#8629FF",
                             @"#CA1C2D",
                             @"#9166AC",
                             @"#B283A9",
                             @"#F4AA06",
                             @"#1EC18E",
                             @"#FF7900",
                             @"#CE4427",
                             @"#000000",
                             @"#74899C",
                             @"#AFAFAF"];
    
    NSArray * soundArray = @[@"guitar.wav",
                             @"drums.wav",
                             @"bass.wav",
                             @"keyboard.wav",
                             @"vocals.wav",
                             @"flute.wav",
                             @"percussion.wav",
                             @"piano.wav",
                             @"violin.wav",
                             @"saxophone.wav",
                             @"tabla.wav",
                             @"hamonium.wav",
                             @"harmonica.wav",
                             @"strings.wav",
                             @"eastern.mp3",
                             @"click.wav"];
    
    for (int i =0 ; i <= 15; i ++)
    {
    NSMutableDictionary *playDic = [[NSMutableDictionary alloc]init];
    [playDic setObject:colorArray[i] forKey:@"color"];
    [playDic setObject:soundArray[i] forKey:@"sound"];
    [playDic setObject:@"0" forKey:@"selected"];
    [playDic setObject:nameArray[i] forKey:@"name"];
    [playDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
    [playArray addObject:playDic];
    }
    
    for (int i =0 ; i <= 15; i ++)
    {
        NSMutableDictionary *lookingDic = [[NSMutableDictionary alloc]init];
        [lookingDic setObject:colorArray[i] forKey:@"color"];
        [lookingDic setObject:soundArray[i] forKey:@"sound"];
        [lookingDic setObject:@"0" forKey:@"selected"];
        [lookingDic setObject:nameArray[i] forKey:@"name"];
        [lookingDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
        [lookingArray addObject:lookingDic];
    }

    for (int i =16 ; i <= 31; i ++)
    {
        NSMutableDictionary *listenDic = [[NSMutableDictionary alloc]init];
        [listenDic setObject:colorArray[i] forKey:@"color"];
        [listenDic setObject:@"click.wav" forKey:@"sound"];
        [listenDic setObject:@"0" forKey:@"selected"];
        [listenDic setObject:nameArray[i] forKey:@"name"];
        [listenDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
        [listenArray addObject:listenDic];
    }
    
    [selectionDictionary setObject:playArray forKey:@"play"];
    [selectionDictionary setObject:lookingArray forKey:@"looking"];
    [selectionDictionary setObject:listenArray forKey:@"listen"];
    
    selection =[Selection instanceFromDictionary:selectionDictionary];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
