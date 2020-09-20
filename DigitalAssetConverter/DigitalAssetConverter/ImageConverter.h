//
//  ImageConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/17/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef ImageConverter_hpp
#define ImageConverter_hpp

#include <stdio.h>
#include <string.h>
#include <vector>
#include <iostream>
#include <fstream> //for file i/o
#include "lodepng.h"
#include "CommonProtocols.h"

/**
 @brief The ImageConverter converts png data into binary data
 */
class ImageConverter {

private:

    /**
     @brief Container with decoded binary data
     */
    std::vector<TEXTURES> textureContainer;
    
public:
    
    /**
     @brief Constructor
     */
    ImageConverter();
    
    /**
     @brief Destructor
     */
    ~ImageConverter();
    
    /**
     @brief Gets all png images found in the directory
     @param inputDirectoryPath Path to the folder
     */
    void decodeAllImagesInFolder(std::string inputDirectoryPath);
    
    /**
     @brief Decodes the png image using the lodepng library
     @param inputDirectoryPath Path to the folder
     @param uTexture Name of the texture
     */
    void decodeImage(std::string inputDirectoryPath, std::string uTexture);
    
    /**
     @brief Writes the decode png binary data into a file
     @param filepath Path to the file
     */
    bool writeBinaryToFile(std::string filepath);
    
    /**
     @brief Reads the decoded png binary data
     @param filepath Path to the file
     */
    void readBinaryFile(std::string filepath);
    
    /**
     @brief Writes individual decoded png binary data into the file
     @param file file name
     @param uTexture image texture
     */
    void writeImageDataToFile(std::ofstream &file, TEXTURES &uTexture);
    
};

#endif /* ImageConverter_hpp */
