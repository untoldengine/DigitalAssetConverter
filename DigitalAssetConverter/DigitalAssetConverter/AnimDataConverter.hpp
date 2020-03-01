//
//  AnimDataConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/14/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef AnimDataConverter_hpp
#define AnimDataConverter_hpp

#include <stdio.h>
#include "DataConverter.hpp"
#include <fstream> //for file i/o
#include <iomanip>
#include <cstdlib>
#include <string.h>
#include <vector>
#include <sstream>
#include "CommonProtocols.h"
#include "tinyxml2.h"

/**
 @brief The AnimDataConverter converts xml animation data into binary data
 */
class AnimDataConverter:public DataConverter {

private:
    
    /**
     @brief Animation data
     */
    ANIMATIONS animationData;
    
public:
    
    /**
     @brief Constructor
     */
    AnimDataConverter();
    
    /**
     @brief Destructor
     */
    ~AnimDataConverter();
    
    /**
     @brief parses the xml file
     */
    void parseXML();
    
    /**
     @brief Writes animation binary data into a file
     @param file file to write binary data
     */
    void writeAnimDataToFile(std::ofstream &file);
    
    /**
     @brief Writes binary data into the file
     @param filepath filepath to the file
     */
    void writeBinaryToFile(std::string filepath);
    
    /**
     @brief Reads the binary data from the file
     @param filepath filepath to the file
     */
    void readBinaryFile(std::string filepath);
    
};

#endif /* AnimDataConverter_hpp */
