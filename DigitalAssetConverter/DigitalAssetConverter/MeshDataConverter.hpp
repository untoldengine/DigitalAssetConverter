//
//  MeshDataConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/13/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef MeshParser_hpp
#define MeshParser_hpp

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

#include "DataConverter.hpp"

/**
 @brief The MeshDataConverter converts xml data into binary data
 */
class MeshDataConverter:public DataConverter {
    
private:
    
    /**
     @brief element representing the mesh
     */
    MODELS models;
    
public:
    
    /**
     @brief Constructor
     */
    MeshDataConverter();
    
    /**
     @brief Destructor
     */
    ~MeshDataConverter();
    
    /**
     @brief parses the xml file
     */
    void parseXML();
    
    /**
     @brief Reads mesh data file in binary format
     @param file file to read
     @param uModel mesh representing the model
     */
    void readMeshDataFile(std::ifstream &file, MODEL &uModel);
    
    /**
     @brief Writes mesh binary data into a file
     @param file file to write data
     @param uModel mesh representing the model
     */
    void writeMeshDataToFile(std::ofstream &file,MODEL &uModel);
    
    /**
     @brief writes binary data into the file
     @param filepath filepath to file
     */
    void writeBinaryToFile(std::string filepath);
    
    /**
     @brief reads binary data from the file
     @param filepath filepath to file
     */
    void readBinaryFile(std::string filepath);
    
};

#endif /* MeshParser_hpp */
