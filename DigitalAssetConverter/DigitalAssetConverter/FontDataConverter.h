//
//  FontDataConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 9/26/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef FontDataConverter_hpp
#define FontDataConverter_hpp

#include <stdio.h>
#include <iostream>
#include <fstream> //for file i/o
#include <iomanip>
#include <cstdlib>
#include <string.h>
#include <vector>
#include <sstream>
#include "CommonProtocols.h"
#include "tinyxml2.h"

#include "DataConverter.h"

class FontDataConverter: public DataConverter {
    
private:
    
    /**
    @brief element representing the particle
    */
    FONTDATA fonts;
    
public:
    
    FontDataConverter();
    
    ~FontDataConverter();
    
    /**
     @brief parses the xml file
     */
    void parseXML();
    
    /**
     @brief Writes mesh binary data into a file
     @param file file to write data
     */
    void writeFontDataToFile(std::ofstream &file);
    
    /**
     @brief writes binary data into the file
     @param filepath filepath to file
     */
    bool writeBinaryToFile(std::string filepath);
    
    /**
     @brief reads binary data from the file
     @param filepath filepath to file
     */
    void readBinaryFile(std::string filepath);
    
};

#endif /* FontDataConverter_hpp */
