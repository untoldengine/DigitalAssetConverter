//
//  ViewController.h
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 9/17/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <iostream>
#include <string.h>
@interface ViewController : NSViewController<NSTabViewDelegate,NSTableViewDataSource> {

    
    __weak IBOutlet NSTextField *exportPathField;
    
    __weak IBOutlet NSTextField *assetPathField;
    
    
    __weak IBOutlet NSComboBox *exportTypeBox;
    
    
    __weak IBOutlet NSTableView *tableView;
    
    
    __weak IBOutlet NSTextField *textureNameField;
    
    
    __weak IBOutlet NSTextField *textureInstruction;
    __weak IBOutlet NSTextField *outputWindow;
    
    NSArray *assetFiles;
}

@property (nonatomic,strong) NSArray *filenamesContainer;

-(void)updateTable;

-(void)convertNSString:( NSString* )absoluteString
           toStlString:( std::string& )urlCppString_;

@end
