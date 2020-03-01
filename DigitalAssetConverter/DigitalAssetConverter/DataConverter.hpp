//
//  DataConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/14/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef DataConverter_hpp
#define DataConverter_hpp

#include <stdio.h>
#include <string.h>
#include <vector>
#include <sstream>
#include <iostream>
#include "tinyxml2.h"

/**
 @brief The DataConverter class is the parent class of the several converters.
 */
class DataConverter {

private:
    
protected:
    
    /**
     @brief xml document
     */
    tinyxml2::XMLDocument doc;
    
public:
    
    /**
     @brief Constructor
     */
    DataConverter();
    
    /**
     @brief Destructor
     */
    ~DataConverter();
    
    /**
     @brief Converts string data into integer data
     @param uStringData string data
     @param uIntData container with int data
     */
    void stringToInt(std::string uStringData,std::vector<int> *uIntData);
    
    /**
     @brief Converts string data into float data
     @param uStringData string data
     @param uFloatData container with float data
     */
    void stringToFloat(std::string uStringData,std::vector<float> *uFloatData);
    
    /**
     @brief loads data into the model container
     @param modelData model data container
     @param uStringData string data
     */
    void loadData(std::vector<int> &modelData,std::string uStringData);
    
    /**
     @brief loads data into the model container
     @param modelData model data container
     @param uStringData string data
     */
    void loadData(std::vector<float> &modelData,std::string uStringData);
    
    /**
     @brief reads the xml document
     @param uFile xml file
     @result true if the file was found
     */
    bool readXML(std::string uFile); 
    
    /**
    @brief parses the xml file
     */
    virtual void parseXML(){};
    
    /**
     @brief writes binary data into the file
     @param filepath file to write data
     */
    virtual void writeBinaryToFile(std::string filepath){};
    
    /**
     @brief reads the binary file
     @param filepath file to read
     */
    virtual void readBinaryFile(std::string filepath){};
    
};

#endif /* DataConverter_hpp */
