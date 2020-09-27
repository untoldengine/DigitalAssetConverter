//
//  ViewController.m
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 9/17/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#import "ViewController.h"
#include <iostream>
#include <string.h>
#include <unistd.h>
#include "MeshDataConverter.h"
#include "AnimDataConverter.h"
#include "ImageConverter.h"
#include "ParticleDataConverter.h"
#include "FontDataConverter.h"
#include <fstream>
@implementation ViewController

- (IBAction)exportTypeBox:(NSComboBox *)sender {
    
     [self updateTable];
    
}

- (IBAction)assetPathButton:(NSButton *)sender {
    
            NSOpenPanel* panel = [NSOpenPanel openPanel];
        
            panel.canChooseFiles=false;
            panel.canChooseDirectories=true;
            panel.showsHiddenFiles=false;
        
          // This method displays the panel and returns immediately.
          // The completion handler is called when the user selects an
          // item or cancels the panel.
          [panel beginWithCompletionHandler:^(NSInteger result){
              if (result == NSModalResponseOK) {
                NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
                  
                // Open  the document.
                  
                  self->assetPathField.stringValue=theDoc.path;

                  NSFileManager *fileManager=[NSFileManager defaultManager];
                  
                  self->assetFiles=[fileManager contentsOfDirectoryAtPath:theDoc.path error:nil];
                  
                  [self updateTable];
                  
    //              self.filenamesContainer =[fileManager contentsOfDirectoryAtPath:theDoc.path error:nil];
    //              [self->tableView reloadData];
                  
             }

          }];
    
}

- (IBAction)exportPathButton:(NSButton *)sender {
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    
        panel.canChooseFiles=false;
        panel.canChooseDirectories=true;
        panel.showsHiddenFiles=false;
    
      // This method displays the panel and returns immediately.
      // The completion handler is called when the user selects an
      // item or cancels the panel.
      [panel beginWithCompletionHandler:^(NSInteger result){
          if (result == NSModalResponseOK) {
            NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
              
            // Open  the document.
            self->exportPathField.stringValue=theDoc.path;
         
          }

      }];
    
}


- (IBAction)convert:(NSButton *)sender {
    
    std::string filename;
    filename.clear();
    NSString *filenameString;
    bool conversionSuccessful=false;
    
    NSInteger row = [tableView selectedRow];
    
    if (row>=0) {
        
        NSURL *filenameURL=(NSURL*)[[[self->_filenamesContainer objectAtIndex:row] lastPathComponent] stringByDeletingPathExtension];

        filenameString=(NSString*)filenameURL;
        filename = std::string([filenameString UTF8String]);
        
    }
    
    std::string assetPath=std::string([[assetPathField stringValue] UTF8String]);
    std::string exportPath=std::string([[exportPathField stringValue] UTF8String]);

    assetPath=assetPath+"/";
    exportPath=exportPath+"/";
    
    //Convert Scene data
    if ([self->exportTypeBox indexOfSelectedItem]==0 && filename.empty()==false) {
    
        MeshDataConverter meshDataConverter;
        
        if(meshDataConverter.readXML(assetPath+filename+".xmlscene")){
            
            if(meshDataConverter.writeBinaryToFile(exportPath+filename+".u4d")){
                
                conversionSuccessful=true;
                outputWindow.stringValue=[NSString stringWithFormat:@"Scene data, %@, was converted successfully",filenameString];
                
            }
         
        }
        //Convert animation data
    }else if([self->exportTypeBox indexOfSelectedItem]==1 && filename.empty()==false){
        
        AnimDataConverter animDataConverter;
        
        if (animDataConverter.readXML(assetPath+filename+".xmlanim")) {
            
            if(animDataConverter.writeBinaryToFile(exportPath+filename+".u4d")){
                
                conversionSuccessful=true;
                
                outputWindow.stringValue=[NSString stringWithFormat:@"Animation data, %@, was converted successfully",filenameString];
                
            }

        }
        //Convert image data
    }else if([self->exportTypeBox indexOfSelectedItem]==2 && (self->textureNameField.stringValue != nil && self->textureNameField.stringValue.length>0)){
        
        ImageConverter imageConverter;
        
        std::string imageNamePath=std::string([[self->textureNameField stringValue] UTF8String]);
        
        imageConverter.decodeAllImagesInFolder(assetPath);

        if(imageConverter.writeBinaryToFile(exportPath+imageNamePath+".u4d")){
            
            conversionSuccessful=true;
            
            outputWindow.stringValue=[NSString stringWithFormat:@"Texture data, %@, was converted successfully",[self->textureNameField stringValue]];
            
        }
        
        
        //Convert particle data
    }else if ([self->exportTypeBox indexOfSelectedItem]==3 && filename.empty()==false){
        
        ParticleDataConverter particleConverter;
       
       if (particleConverter.readXML(assetPath+filename+".pex")) {
           
           particleConverter.setParticleName(filename);
           
           if(particleConverter.writeBinaryToFile(exportPath+filename+".u4d")){
            
               conversionSuccessful=true;
               outputWindow.stringValue=[NSString stringWithFormat:@"Particle data, %@, was converted successfully",filenameString];
                   
               }
           
       }
        
    }else if ([self->exportTypeBox indexOfSelectedItem]==4 && filename.empty()==false){
        
      FontDataConverter fontConverter;
       
       if (fontConverter.readXML(assetPath+filename+".fnt")) {
           
           if(fontConverter.writeBinaryToFile(exportPath+filename+".u4d")){
               
               conversionSuccessful=true;
               
               outputWindow.stringValue=[NSString stringWithFormat:@"Font data, %@, was converted successfully",filenameString];
               
           }
           
       }
        
    }
    
    if (conversionSuccessful==false) {
        
        outputWindow.stringValue=@"Error: The destination file was not allowed to be opened. Click on the Project's Target->Signing & Capabilities->App Sandbox and make sure the File Access Type's permissions are set to Read/Write. The User Selected and Download folders should have read/write access.";
    
    }
    
}


-(void)convertNSString:( NSString* )absoluteString
           toStlString:( std::string& )urlCppString_
{
    if ( nil != absoluteString )
    {
        std::string tmpUrlCppString
        (
         [absoluteString cStringUsingEncoding: NSUTF8StringEncoding],
         [absoluteString lengthOfBytesUsingEncoding: NSUTF8StringEncoding]
         );

        urlCppString_ = tmpUrlCppString;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
     
    //assetPathField.stringValue=@"Browse to your asset folder";
    //exportPathField.stringValue=@"Browse to the Resource Folder of the engine";
    
    [exportTypeBox selectItemAtIndex:0];
    
    [self->textureNameField setHidden:true];
    [self->textureInstruction setHidden:true];
    
    tableView.delegate=(id <NSTableViewDelegate>)self; 
    tableView.dataSource=self;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.filenamesContainer.count;
    
}


// NSTableViewDelegate
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifier owner:self];
    if ([identifier isEqualToString:@"assetname"]) {
        cell.textField.stringValue = [self.filenamesContainer objectAtIndex:row];
    }

    return cell;

}

- (NSArray *)filenamesContainer{
    if(!_filenamesContainer){
        _filenamesContainer=@[@""];
    }
    return _filenamesContainer;
}

-(void)updateTable{
    
    NSArray *sceneFiles=[self->assetFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.xmlscene'"]];
    NSArray *animFiles=[self->assetFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.xmlanim'"]];
    NSArray *pngFiles=[self->assetFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.png'"]];
    NSArray *particleFiles=[self->assetFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.pex'"]];
    NSArray *fontFiles=[self->assetFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.fnt'"]];
    
    
    [self->textureNameField setHidden:true];
    [self->textureInstruction setHidden:true];
    [self->tableView setEnabled:true];
    
    if ([self->exportTypeBox indexOfSelectedItem]==0) {
        
        self.filenamesContainer=sceneFiles;
        
    }else if([self->exportTypeBox indexOfSelectedItem]==1){
    
        self.filenamesContainer=animFiles;
        
    }else if([self->exportTypeBox indexOfSelectedItem]==2){
        
        self.filenamesContainer=pngFiles;
        [self->tableView setEnabled:false];
        [self->textureNameField setHidden:false];
        [self->textureInstruction setHidden:false];
        
    }else if ([self->exportTypeBox indexOfSelectedItem]==3){
        
        self.filenamesContainer=particleFiles;
        
    }else if ([self->exportTypeBox indexOfSelectedItem]==4){
        
        self.filenamesContainer=fontFiles;
        
    }
    
    [self->tableView reloadData];
    
}

@end
