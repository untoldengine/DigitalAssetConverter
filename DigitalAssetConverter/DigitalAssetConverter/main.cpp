//
//  main.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/13/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include <iostream>
#include <string.h>
#include <unistd.h>
#include "MeshDataConverter.hpp"
#include "AnimDataConverter.hpp"
#include "ImageConverter.hpp"
#include "ParticleDataConverter.hpp"
#include <filesystem>
#include <sys/stat.h>

std::string inputPathFolder;
std::string outputPathFolder;

bool checkIfPathExist(std::string uPath){
    
    struct stat buf;
    bool pathExist=false;
    
    if(stat(uPath.c_str(), &buf)==0) return pathExist=true;
    
    std::cout<<"Path does not exist. Please enter it again"<<std::endl;
    
    return pathExist;
}

void setPaths(){
    
    do{
        
        std::cout<<"\nEnter the Input Folder Path"<<std::endl;
        
        std::cin>>inputPathFolder;
        
    }while (!checkIfPathExist(inputPathFolder));
    
    
    do{
        std::cout<<"\nEnter the Output Folder Path"<<std::endl;
        
        std::cin>>outputPathFolder;
    
    }while (!checkIfPathExist(outputPathFolder));
    
    inputPathFolder=inputPathFolder+"/";
    outputPathFolder=outputPathFolder+"/";
    
}

int main(int argc, const char * argv[]) {
    
    std::string filename;
    std::string binaryPath;
    std::string imageNamePath;
    int selection=0;
    
    std::cout<<"This program will convert the XML format into the binary format used in the Untold Engine."<<std::endl;
    
    //ask for the input&output folder
    std::cout<<"\nBefore you begin, you must set the Input and Output folder paths. The Input folder contains all of the data that you want to convert to binary, such as mesh(.xml), animation(.xml), images(.png). The Output folder will contain all the data in binary format (.u4d)"<<std::endl;
    
    //set Paths
    setPaths();

    do{
        
        std::cout<<"\nMake a selection:"<<std::endl;
        std::cout<<"\t 1. Convert Mesh Data to binary"<<std::endl;
        std::cout<<"\t 2. Convert Animation Data to binary"<<std::endl;
        std::cout<<"\t 3. Convert Image Data to binary"<<std::endl;
        std::cout<<"\t 4. Convert Particle Data to binary"<<std::endl;
        std::cout<<"\t 5. Change the input/output directories"<<std::endl;
        std::cout<<"\t 6. Quit"<<std::endl;
        
        std::cin>>selection;
        
        switch (selection) {
                
            case 1:
            {
                
                MeshDataConverter meshDataConverter;
                
                std::cout<<"\nEnter the source XML file name (no extension) of the Mesh"<<std::endl;
                
                std::cin>>filename;

                if(meshDataConverter.readXML(inputPathFolder+filename+".xmlscene")){
                    
                    meshDataConverter.writeBinaryToFile(outputPathFolder+filename+".u4d");
                    
                }
                
            }
                
                break;
                
            case 2:
            {
            
                AnimDataConverter animDataConverter;
                
                std::cout<<"\nEnter the source XML file name (no extension) of the animation"<<std::endl;
                
                std::cin>>filename;

                if (animDataConverter.readXML(inputPathFolder+filename+".xmlanim")) {
                    
                    animDataConverter.writeBinaryToFile(outputPathFolder+filename+".u4d");

                }
                
            }
                break;
                
            case 3:
            {

                ImageConverter imageConverter;
                
                std::cout<<"Name your texture file (This file will contain all of your textures)."<<std::endl;
                
                std::cin>>imageNamePath;
                
                imageConverter.decodeAllImagesInFolder(inputPathFolder);
                
                imageConverter.writeBinaryToFile(outputPathFolder+imageNamePath+".u4d");
                
            }
                
                break;
                
            case 4:
                
            {
                ParticleDataConverter particleConverter;
                
                std::cout<<"\nEnter the source PEX file name (no extension) of the particle"<<std::endl;
                
                std::cin>>filename;
                
                if (particleConverter.readXML(inputPathFolder+filename+".pex")) {
                    
                    particleConverter.setParticleName(filename);
                    
                    particleConverter.writeBinaryToFile(outputPathFolder+filename+".u4d");
                    
                }
                
            }
                
                break;
                
            case 5:
                
                setPaths();
            
                break;
                
                
            default:
                
                std::cout<<"Selection is not valid"<<std::endl;
                
                break;
                
        }
        
    }while (selection!=6);
    
    return 0;

}

