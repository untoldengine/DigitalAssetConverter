//
//  LightDataConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/19/21.
//  Copyright © 2021 Untold Engine Studios. All rights reserved.
//

#ifndef LightDataConverter_hpp
#define LightDataConverter_hpp

#include <stdio.h>
#include "DataConverter.h"
#include <iostream>
#include <fstream> //for file i/o
#include <iomanip>
#include <cstdlib>
#include <string.h>
#include <vector>
#include <sstream>
#include "CommonProtocols.h"
#include "tinyxml2.h"


class LightDataConverter:public DataConverter {
    
private:
    
    LIGHTS lights;
    
public:
    
    LightDataConverter();
    
    ~LightDataConverter();
    
    /**
    @brief parses the xml file
     */
    void parseXML();
    
    /**
     @brief writes binary data into the file
     @param filepath file to write data
     */
    bool writeBinaryToFile(std::string filepath);
    
    /**
     @brief reads the binary file
     @param filepath file to read
     */
    void readBinaryFile(std::string filepath);
    
    /**
     @brief Writes mesh binary data into a file
     @param file file to write data
     */
    void writeLightDataToFile(std::ofstream &file);
    
};

#endif /* LightDataConverter_hpp */
