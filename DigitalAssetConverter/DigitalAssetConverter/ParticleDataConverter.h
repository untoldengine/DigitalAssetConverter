//
//  ParticleDataConverter.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 3/18/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef ParticleDataConverter_hpp
#define ParticleDataConverter_hpp

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

class ParticleDataConverter: public DataConverter {

private:
    
    /**
    @brief element representing the particle
    */
    PARTICLES particle;
    
public:
    
    /**
    @brief Constructor
    */
    ParticleDataConverter();
    
    /**
    @brief Destructor
    */
    ~ParticleDataConverter();

    /**
     @brief parses the xml file
     */
    void parseXML();
    
    /**
     @brief Writes mesh binary data into a file
     @param file file to write data
     */
    void writeParticleDataToFile(std::ofstream &file);
    
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
    
    /**
    @brief sets the name of the particle
    @param uName particle name
    */
    void setParticleName(std::string uName);
    
    /**
    @brief maps the appropriate Metal blending factor
    @param uBlending blending numer
    @return returns appropraite blending factor for Metal
    */
    int blendingFactorMapping(int uBlending);
    
};

#endif /* ParticleDataConverter_hpp */
