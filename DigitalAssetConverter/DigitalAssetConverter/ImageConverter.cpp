//
//  ImageConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/17/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "ImageConverter.hpp"
#include <experimental/filesystem>

namespace fs=std::experimental::filesystem;

ImageConverter::ImageConverter(){
    
}

ImageConverter::~ImageConverter(){
    
}

void ImageConverter::decodeAllImagesInFolder(std::string inputDirectoryPath){
    
    std::vector<std::string> textureImagesPath;
    
    for(const auto &p: fs::recursive_directory_iterator(inputDirectoryPath)){
        if(p.path().extension() == ".png"){
            
            std::string pathString=p.path();
            size_t pathStringSize=pathString.size();
            size_t inputDirectoryPathSize=inputDirectoryPath.size();
            
            std::string imagePath=pathString.substr(inputDirectoryPathSize,pathStringSize-inputDirectoryPathSize);
            
            textureImagesPath.push_back(imagePath);
            
        }
           
    }
    
    std::cout<<"Converting into binary..."<<std::endl;
    
    for(auto n:textureImagesPath){

        decodeImage(inputDirectoryPath, n);

    }
    
}

void ImageConverter::decodeImage(std::string inputDirectoryPath, std::string uTexture){
    
    // Load file and decode image.
    TEXTURES texture;
    
    unsigned error;
    
    std::string fullPath=inputDirectoryPath+uTexture;
    
    error = lodepng::decode(texture.image, texture.width, texture.height,fullPath.c_str());
    
    //if there's an error, display it
    if(error){
        std::cout << "decoder error " << error << ": " << lodepng_error_text(error) << std::endl;
    }else{
        
        //set the name
        texture.name=uTexture;
        
        //Flip and invert the image
        unsigned char* imagePtr=&texture.image[0];
        
        int halfTheHeightInPixels=texture.height/2;
        int heightInPixels=texture.height;
        
        //Assume RGBA for 4 components per pixel
        int numColorComponents=4;
        
        //Assuming each color component is an unsigned char
        int widthInChars=texture.width*numColorComponents;
        
        unsigned char *top=NULL;
        unsigned char *bottom=NULL;
        unsigned char temp=0;
        
        for( int h = 0; h < halfTheHeightInPixels; ++h )
        {
            top = imagePtr + h * widthInChars;
            bottom = imagePtr + (heightInPixels - h - 1) * widthInChars;
            
            for( int w = 0; w < widthInChars; ++w )
            {
                // Swap the chars around.
                temp = *top;
                *top = *bottom;
                *bottom = temp;
                
                ++top;
                ++bottom;
            }
        }
        
        
    }
    
    textureContainer.push_back(texture);
    
}

void ImageConverter::writeImageDataToFile(std::ofstream &file, TEXTURES &uTexture){
    
    //NAME
    //get the size of the string
    size_t imageNameLen=uTexture.name.size();
    file.write((char*)&imageNameLen,sizeof(imageNameLen));
    file.write((char*)&uTexture.name[0],imageNameLen);
    
    //WIDTH
    float widthSize=(float)uTexture.width;
    file.write((char*)&widthSize,sizeof(float));
    file.write((char*)&uTexture.width,sizeof(widthSize));
    
    //HEIGHT
    float heightSize=(float)uTexture.height;
    file.write((char*)&heightSize,sizeof(float));
    file.write((char*)&uTexture.height,sizeof(heightSize));
    
    //IMAGE
    int textureSize=(int)uTexture.image.size();
    file.write((char*)&textureSize,sizeof(int));
    file.write((char*)&uTexture.image[0],textureSize*sizeof(unsigned char));
    
    
}

void ImageConverter::writeBinaryToFile(std::string filepath){
    
    std::ofstream file(filepath, std::ios::out | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }

    //write the number of textures
    int numberOfTexturesSize=(int)textureContainer.size();
    file.write((char*)&numberOfTexturesSize,sizeof(int));
    
    for(auto n:textureContainer){
        
        writeImageDataToFile(file,n);
        
    }
    
    std::cout<<"Texture data was converted into binary."<<std::endl;
    
    file.close();
    
}

void ImageConverter::readBinaryFile(std::string filepath){
    
    std::ifstream file(filepath, std::ios::in | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"no file"<<std::endl;
        
        exit(1);
        
    }
    
    file.seekg(0);
    
    TEXTURES texture;
    
    //READ NUMBER OF TEXTURES
    int numberOfTexturesSize=0;
    file.read((char*)&numberOfTexturesSize,sizeof(int));
    
    for(int i=0;i<numberOfTexturesSize;i++){
        
        //NAME
        size_t textureNamelen=0;
        file.read((char*)&textureNamelen,sizeof(textureNamelen));
        texture.name.resize(textureNamelen);
        file.read((char*)&texture.name[0],textureNamelen);
        
        std::cout<<"Name: "<<texture.name<<std::endl;
        
        //WIDTH
        float widthSize=0;
        file.read((char*)&widthSize,sizeof(float));
        file.read((char*)&texture.width, sizeof(widthSize));
        
        //HEIGHT
        float heightSize=0;
        file.read((char*)&heightSize,sizeof(float));
        file.read((char*)&texture.height, sizeof(heightSize));
        
        //IMAGE
        int imageSize=0;
        file.read((char*)&imageSize,sizeof(int));
        std::vector<unsigned char> tempImage(imageSize,0);
        
        //copy temp to model2
        texture.image=tempImage;
        file.read((char*)&texture.image[0], imageSize*sizeof(unsigned char));
        
    }
    
}
