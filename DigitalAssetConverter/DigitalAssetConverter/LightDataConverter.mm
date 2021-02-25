//
//  LightDataConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/19/21.
//  Copyright © 2021 Untold Engine Studios. All rights reserved.
//

#include "LightDataConverter.h"

LightDataConverter::LightDataConverter(){
    
}

LightDataConverter::~LightDataConverter(){
    
}

void LightDataConverter::parseXML(){
    
    tinyxml2::XMLNode *root=doc.FirstChildElement("UntoldEngine");
    
    //Get lights
    tinyxml2::XMLElement *node=root->FirstChildElement("asset")->FirstChildElement("lights")->FirstChildElement("directional_lights");
    const char* numberOfDirLights=node->Attribute("lights_count");
    
    lights.numberOfDirectionalLights=atoi(numberOfDirLights);
    
    if (node!=NULL) {
        
        for (tinyxml2::XMLElement *child=node->FirstChildElement("directional_light"); child!=NULL; child=child->NextSiblingElement("directional_light")) {
            
            std::string lightName=child->Attribute("name");
            
            tinyxml2::XMLElement *energy=child->FirstChildElement("energy");
            tinyxml2::XMLElement *color=child->FirstChildElement("light_color");
            tinyxml2::XMLElement *localMatrix=child->FirstChildElement("local_matrix");
            
            //Set name
            DIRECTIONALLIGHT light;
            light.name=lightName;

            if (energy!=NULL) {
                const char* data=energy->GetText();
                light.energy=atof(data);
                
            }
            
            if (color!=NULL) {
                
                std::string data=color->GetText();
                loadData(light.color, data);
                
            }
            
            if (localMatrix!=NULL) {
                
                std::string bodyTransformatioMatrix=localMatrix->GetText();
                loadData(light.localMatrix,bodyTransformatioMatrix);
            }
            
            lights.directionalLights.push_back(light);
            
        }
           
    }
    
    //Get the point lights
    node=root->FirstChildElement("asset")->FirstChildElement("lights")->FirstChildElement("point_lights");
    const char* numberOfPointLights=node->Attribute("lights_count");
    lights.numberOfPointLights=atoi(numberOfPointLights);
    
    if (node!=NULL) {
        
        for (tinyxml2::XMLElement *child=node->FirstChildElement("point_light"); child!=NULL; child=child->NextSiblingElement("point_light")) {
            
            std::string lightName=child->Attribute("name");
            
            tinyxml2::XMLElement *energy=child->FirstChildElement("energy");
            tinyxml2::XMLElement *fallout=child->FirstChildElement("fallout_distance");
            tinyxml2::XMLElement *constantCoefficient=child->FirstChildElement("constant_coefficient");
            tinyxml2::XMLElement *linearCoefficient=child->FirstChildElement("linear_coefficient");
            tinyxml2::XMLElement *quadraticCoefficient=child->FirstChildElement("quadratic_coefficient");
            tinyxml2::XMLElement *color=child->FirstChildElement("light_color");
            tinyxml2::XMLElement *localMatrix=child->FirstChildElement("local_matrix");
            
            //Set name
            POINTLIGHT light;
            light.name=lightName;

            if (energy!=NULL) {
                const char* data=energy->GetText();
                light.energy=atof(data);
                
            }
            
            if (fallout!=NULL) {
                const char* data=fallout->GetText();
                light.falloutDistance=atof(data);
                
            }
            
            if (constantCoefficient!=NULL) {
                const char* data=constantCoefficient->GetText();
                light.constantCoefficient=atof(data);
            }
            
            if (linearCoefficient!=NULL) {
                const char* data=linearCoefficient->GetText();
                light.linearCoefficient=atof(data);
            }
            
            if (quadraticCoefficient!=NULL) {
                const char* data=quadraticCoefficient->GetText();
                light.quadraticCoefficient=atof(data);
            }
            
            if (color!=NULL) {
                
                std::string data=color->GetText();
                loadData(light.color, data);
                
            }
            
            if (localMatrix!=NULL) {
                
                std::string bodyTransformatioMatrix=localMatrix->GetText();
                loadData(light.localMatrix,bodyTransformatioMatrix);
            }
            
            lights.pointLights.push_back(light);
        }
           
    }
    
}

void LightDataConverter::writeLightDataToFile(std::ofstream &file){
    
    //WRITE NUMBER OF DIR LIGHTS
    int numberOfDirLightSize=(int)lights.numberOfDirectionalLights;
    file.write((char*)&numberOfDirLightSize,sizeof(int));
    file.write((char*)&lights.numberOfDirectionalLights,sizeof(numberOfDirLightSize));
    
    for (int i=0;i<numberOfDirLightSize;i++){
        
        //name
        //get the size of the string
        size_t dirLightNameLen=lights.directionalLights.at(i).name.size();
        file.write((char*)&dirLightNameLen,sizeof(dirLightNameLen));
        file.write((char*)&lights.directionalLights.at(i).name[0],dirLightNameLen);
        
        //Energy
        float energySize=(float)lights.directionalLights.at(i).energy;
        file.write((char*)&energySize,sizeof(float));
        file.write((char*)&lights.directionalLights.at(i).energy,sizeof(energySize));
        
        //Color
        int colorSize=(int)lights.directionalLights.at(i).color.size();
        file.write((char*)&colorSize,sizeof(int));
        file.write((char*)&lights.directionalLights.at(i).color[0],colorSize*sizeof(float));
        
        //Local Matrix
        int localMatrixSize=(int)lights.directionalLights.at(i).localMatrix.size();
        
        file.write((char*)&localMatrixSize,sizeof(int));
        
        file.write((char*)&lights.directionalLights.at(i).localMatrix[0],localMatrixSize*sizeof(float));
        
    }
    
    //WRITE NUMBER OF POINT LIGHTS
    
    int numberOfPointLightSize=(int)lights.numberOfPointLights;
    file.write((char*)&numberOfPointLightSize,sizeof(int));
    file.write((char*)&lights.numberOfPointLights,sizeof(numberOfPointLightSize));
    
    for (int i=0;i<lights.numberOfPointLights;i++){
        
        //name
        //get the size of the string
        size_t pointLightNameLen=lights.pointLights.at(i).name.size();
        file.write((char*)&pointLightNameLen,sizeof(pointLightNameLen));
        file.write((char*)&lights.pointLights.at(i).name[0],pointLightNameLen);
        
        //Energy
        float energySize=(float)lights.pointLights.at(i).energy;
        file.write((char*)&energySize,sizeof(float));
        file.write((char*)&lights.pointLights.at(i).energy,sizeof(energySize));
        
        //Fallout
        float falloutDistanceSize=(float)lights.pointLights.at(i).falloutDistance;
        file.write((char*)&falloutDistanceSize,sizeof(float));
        file.write((char*)&lights.pointLights.at(i).falloutDistance,sizeof(falloutDistanceSize));
        
        //constanct coefficient
        float constantCoefficientSize=(float)lights.pointLights.at(i).constantCoefficient;
        file.write((char*)&constantCoefficientSize,sizeof(float));
        file.write((char*)&lights.pointLights.at(i).constantCoefficient,sizeof(constantCoefficientSize));
        
        //linear coefficient
        float linearCoefficientSize=(float)lights.pointLights.at(i).linearCoefficient;
        file.write((char*)&linearCoefficientSize,sizeof(float));
        file.write((char*)&lights.pointLights.at(i).linearCoefficient,sizeof(linearCoefficientSize));
        
        //quadratic coefficient
        float quadraticCoefficientSize=(float)lights.pointLights.at(i).quadraticCoefficient;
        file.write((char*)&quadraticCoefficientSize,sizeof(float));
        file.write((char*)&lights.pointLights.at(i).quadraticCoefficient,sizeof(quadraticCoefficientSize));
        
        //Color
        int colorSize=(int)lights.pointLights.at(i).color.size();
        file.write((char*)&colorSize,sizeof(int));
        file.write((char*)&lights.pointLights.at(i).color[0],colorSize*sizeof(float));
        
        //Local Matrix
        int localMatrixSize=(int)lights.pointLights.at(i).localMatrix.size();
        
        file.write((char*)&localMatrixSize,sizeof(int));
        
        file.write((char*)&lights.pointLights.at(i).localMatrix[0],localMatrixSize*sizeof(float));
    }
    
}


bool LightDataConverter::writeBinaryToFile(std::string filepath){
    
    std::ofstream file(filepath, std::ios::out | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        return false;
        
    }

    writeLightDataToFile(file);
       
    
    file.close();
    return true;
}

void LightDataConverter::readBinaryFile(std::string filepath){
    
    std::ifstream file(filepath, std::ios::in | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }
    
    file.seekg(0);
    
    LIGHTS lights;
    
    //Number of directional lights
    int numberOfDirLightSize=0;
    file.read((char*)&numberOfDirLightSize,sizeof(int));
    file.read((char*)&lights.numberOfDirectionalLights, sizeof(numberOfDirLightSize));
    
    for (int i=0; i<numberOfDirLightSize; i++) {
        
        DIRECTIONALLIGHT dirLight;
        
        //READ NAME
        size_t lightNamelen=0;
        file.read((char*)&lightNamelen,sizeof(lightNamelen));
        dirLight.name.resize(lightNamelen);
        file.read((char*)&dirLight.name[0],lightNamelen);
        
        //Energy
        float energySize=0;
        file.read((char*)&energySize,sizeof(float));
        file.read((char*)&dirLight.energy, sizeof(energySize));
        
        //color
        int colorSize=0;
        file.read((char*)&colorSize,sizeof(int));
        std::vector<float> tempColor(colorSize,0);
        
        //copy temp to color
        dirLight.color=tempColor;
        file.read((char*)&dirLight.color[0], colorSize*sizeof(float));
        
        //READ LOCAL MATRIX
        int localMatrixSize=0;
        file.read((char*)&localMatrixSize,sizeof(int));
        std::vector<float> tempLocalMatrix(localMatrixSize,0);
        
        //copy temp to light matrix
        dirLight.localMatrix=tempLocalMatrix;
        file.read((char*)&dirLight.localMatrix[0], localMatrixSize*sizeof(float));
        
        lights.directionalLights.push_back(dirLight);
        
    }
    
    //Number of point lights
    int numberOfPointLightSize=0;
    file.read((char*)&numberOfPointLightSize,sizeof(int));
    file.read((char*)&lights.numberOfPointLights, sizeof(numberOfPointLightSize));
    
    for (int i=0; i<numberOfPointLightSize; i++) {
        
        POINTLIGHT pointLight;
        
        //READ NAME
        size_t lightNamelen=0;
        file.read((char*)&lightNamelen,sizeof(lightNamelen));
        pointLight.name.resize(lightNamelen);
        file.read((char*)&pointLight.name[0],lightNamelen);
        
        //Energy
        float energySize=0;
        file.read((char*)&energySize,sizeof(float));
        file.read((char*)&pointLight.energy, sizeof(energySize));
        
        //Fallout distance
        float falloutSize=0;
        file.read((char*)&falloutSize,sizeof(float));
        file.read((char*)&pointLight.falloutDistance, sizeof(falloutSize));
        
        //constant coefficient
        float constantCoefficientSize=0;
        file.read((char*)&constantCoefficientSize,sizeof(float));
        file.read((char*)&pointLight.constantCoefficient, sizeof(constantCoefficientSize));
        
        //linear coefficient
        float linearCoefficientSize=0;
        file.read((char*)&linearCoefficientSize,sizeof(float));
        file.read((char*)&pointLight.linearCoefficient, sizeof(linearCoefficientSize));
        
        //quadratic coefficient
        float quadraticCoefficientSize=0;
        file.read((char*)&quadraticCoefficientSize,sizeof(float));
        file.read((char*)&pointLight.quadraticCoefficient, sizeof(quadraticCoefficientSize));
        
        //color
        int colorSize=0;
        file.read((char*)&colorSize,sizeof(int));
        std::vector<float> tempColor(colorSize,0);
        
        //copy temp to color
        pointLight.color=tempColor;
        file.read((char*)&pointLight.color[0], colorSize*sizeof(float));
        
        //READ LOCAL MATRIX
        int localMatrixSize=0;
        file.read((char*)&localMatrixSize,sizeof(int));
        std::vector<float> tempLocalMatrix(localMatrixSize,0);
        
        //copy temp to light matrix
        pointLight.localMatrix=tempLocalMatrix;
        file.read((char*)&pointLight.localMatrix[0], localMatrixSize*sizeof(float));
        
        lights.pointLights.push_back(pointLight);
        
    }
    
}
