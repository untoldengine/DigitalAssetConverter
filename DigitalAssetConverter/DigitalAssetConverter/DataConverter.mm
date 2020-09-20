//
//  DataConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/14/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "DataConverter.h"


DataConverter::DataConverter(){
    
}

DataConverter::~DataConverter(){
    
}

bool DataConverter::readXML(std::string uFile){
    
    bool loadOk=doc.LoadFile(uFile.c_str());
    
    if (!loadOk) {
    
        std::cout<<"File loaded."<<std::endl;
        std::cout<<"Converting into binary..."<<std::endl;
        parseXML();
        loadOk=true;
        
    }else{
        
        std::cout<<"File "<<uFile<<" was not found."<<std::endl;
        loadOk=false;
    }
    
    return loadOk;
    
}

void DataConverter::stringToInt(std::string uStringData,std::vector<int> *uIntData){
    
    std::stringstream stringToParse(uStringData);
    
    std::string outString;
    
    while (getline(stringToParse, outString, ' ')) {
        
        std::istringstream iss(outString);
        
        int c=stoi(outString);
        
        uIntData->push_back(c);
        
    }
    
}

void DataConverter::stringToFloat(std::string uStringData,std::vector<float> *uFloatData){
    
    std::stringstream stringToParse(uStringData);
    
    std::string outString;
    
    while (getline(stringToParse, outString, ' ')) {
        
        std::istringstream iss(outString);
        
        float c=stof(outString);
        
        uFloatData->push_back(c);
        
    }
    
}



void DataConverter::loadData(std::vector<int> &modelData,std::string uStringData){
    
    std::vector<int> tempVector;
    
    stringToInt(uStringData, &tempVector);
    
    for (int i=0; i<tempVector.size();i++) {
        
        int data=tempVector.at(i);
        
        modelData.push_back(data);
        
    }
    
}

void DataConverter::loadData(std::vector<float> &modelData,std::string uStringData){
    
    std::vector<float> tempVector;
    
    stringToFloat(uStringData, &tempVector);
    
    for (int i=0; i<tempVector.size();i++) {
        
        float data=tempVector.at(i);
        
        modelData.push_back(data);
        
    }
    
}
