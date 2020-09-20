//
//  ParticleDataConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 3/18/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "ParticleDataConverter.h"


ParticleDataConverter::ParticleDataConverter(){
    
}
    
ParticleDataConverter::~ParticleDataConverter(){

}

void ParticleDataConverter::parseXML(){
    
     tinyxml2::XMLElement* particleConfig = doc.FirstChildElement("particleEmitterConfig");
     
    //position variance
     tinyxml2::XMLElement* particlePosVarianceElement = particleConfig->FirstChildElement("sourcePositionVariance");
     
     const char* particlePosXVarianceAttribute=particlePosVarianceElement->Attribute("x");
     const char* particlePosYVarianceAttribute=particlePosVarianceElement->Attribute("y");
     
     float posXVariance=atof(particlePosXVarianceAttribute);
     float posYVariance=atof(particlePosYVarianceAttribute);
     
    particle.positionVariance={posXVariance,posYVariance,0.0};
    
     //speed
     tinyxml2::XMLElement* speedElement = particleConfig->FirstChildElement("speed");
     
     const char* particleSpeedAttribute=speedElement->Attribute("value");
     
     particle.speed=atof(particleSpeedAttribute);
     
     //speed variance
     tinyxml2::XMLElement* speedVarianceElement = particleConfig->FirstChildElement("speedVariance");
     
     const char* particleSpeedVarianceAttribute=speedVarianceElement->Attribute("value");
     
     particle.speedVariance=atof(particleSpeedVarianceAttribute);
     
     //life span
     tinyxml2::XMLElement* lifeSpanElement = particleConfig->FirstChildElement("particleLifeSpan");
     
     const char* particleLifeAttribute=lifeSpanElement->Attribute("value");
     
     particle.lifeSpan=atof(particleLifeAttribute);
     
     //maximum number of particles
     tinyxml2::XMLElement* maxNumberOfParticlesElement = particleConfig->FirstChildElement("maxParticles");
     
     const char* maxNumberOfParticlesAttribute=maxNumberOfParticlesElement->Attribute("value");
     
     particle.maxParticles=atof(maxNumberOfParticlesAttribute);
     
     //angle
     tinyxml2::XMLElement* angleElement = particleConfig->FirstChildElement("angle");
     
     const char* angleAttribute=angleElement->Attribute("value");
     
     particle.angle=atof(angleAttribute);
     
     //angle variance
     tinyxml2::XMLElement* angleVarianceElement = particleConfig->FirstChildElement("angleVariance");
     
     const char* angleVarianceAttribute=angleVarianceElement->Attribute("value");
     
     particle.angleVariance=atof(angleVarianceAttribute);
     
     //start color
     
     tinyxml2::XMLElement* startColorElement = particleConfig->FirstChildElement("startColor");
     
     const char* colorRedAttribute=startColorElement->Attribute("red");
     const char* colorGreenAttribute=startColorElement->Attribute("green");
     const char* colorBlueAttribute=startColorElement->Attribute("blue");
     const char* colorAlphaAttribute=startColorElement->Attribute("alpha");
     
     float startColorRed=atof(colorRedAttribute);
     float startColorGreen=atof(colorGreenAttribute);
     float startColorBlue=atof(colorBlueAttribute);
     float startColorAlpha=atof(colorAlphaAttribute);
     
    particle.startColor={startColorRed,startColorGreen,startColorBlue,startColorAlpha};
     
     //start color variance
     
     tinyxml2::XMLElement* startColorVarianceElement = particleConfig->FirstChildElement("startColorVariance");
     
     colorRedAttribute=startColorVarianceElement->Attribute("red");
     colorGreenAttribute=startColorVarianceElement->Attribute("green");
     colorBlueAttribute=startColorVarianceElement->Attribute("blue");
     colorAlphaAttribute=startColorVarianceElement->Attribute("alpha");
     
     float startColorRedVariance=atof(colorRedAttribute);
     float startColorGreenVariance=atof(colorGreenAttribute);
     float startColorBlueVariance=atof(colorBlueAttribute);
     float startColorAlphaVariance=atof(colorAlphaAttribute);
     
    particle.startColorVariance={startColorRedVariance,startColorGreenVariance,startColorBlueVariance,startColorAlphaVariance};
     
     //end color
     tinyxml2::XMLElement* endColorElement = particleConfig->FirstChildElement("finishColor");
     
     colorRedAttribute=endColorElement->Attribute("red");
     colorGreenAttribute=endColorElement->Attribute("green");
     colorBlueAttribute=endColorElement->Attribute("blue");
     colorAlphaAttribute=endColorElement->Attribute("alpha");
     
     float endColorRed=atof(colorRedAttribute);
     float endColorGreen=atof(colorGreenAttribute);
     float endColorBlue=atof(colorBlueAttribute);
     float endColorAlpha=atof(colorAlphaAttribute);
     
    particle.finishColor={endColorRed,endColorGreen,endColorBlue,endColorAlpha};
     
     //end color variance
     tinyxml2::XMLElement* endColorVarianceElement = particleConfig->FirstChildElement("finishColorVariance");
     
     colorRedAttribute=endColorVarianceElement->Attribute("red");
     colorGreenAttribute=endColorVarianceElement->Attribute("green");
     colorBlueAttribute=endColorVarianceElement->Attribute("blue");
     colorAlphaAttribute=endColorVarianceElement->Attribute("alpha");
     
     float endColorRedVariance=atof(colorRedAttribute);
     float endColorGreenVariance=atof(colorGreenAttribute);
     float endColorBlueVariance=atof(colorBlueAttribute);
     float endColorAlphaVariance=atof(colorAlphaAttribute);
     
    particle.finishColorVariance={endColorRedVariance,endColorGreenVariance,endColorBlueVariance,endColorAlphaVariance};
     
     //gravity
     tinyxml2::XMLElement* gravityElement = particleConfig->FirstChildElement("gravity");
     const char* gravityXDirectionAttribute=gravityElement->Attribute("x");
     const char* gravityYDirectionAttribute=gravityElement->Attribute("y");
     
     float gravityXValue=atof(gravityXDirectionAttribute);
     float gravityYValue=atof(gravityYDirectionAttribute);
     
     particle.gravity= {gravityXValue,gravityYValue,0.0};
     
     //start size
     tinyxml2::XMLElement* particleStartSizeElement = particleConfig->FirstChildElement("startParticleSize");
     
     const char* particleStartSizeAttribute=particleStartSizeElement->Attribute("value");
     
     particle.startParticleSize=atof(particleStartSizeAttribute);
    
     //start size variance
     tinyxml2::XMLElement* particleStartSizeVarianceElement = particleConfig->FirstChildElement("startParticleSizeVariance");
     
     const char* particleStartSizeVarianceAttribute=particleStartSizeVarianceElement->Attribute("value");
     
     particle.startParticleSizeVariance=atof(particleStartSizeVarianceAttribute);
     
     //end size
     tinyxml2::XMLElement* particleEndSizeElement = particleConfig->FirstChildElement("finishParticleSize");
     
     const char* particleEndSizeAttribute=particleEndSizeElement->Attribute("value");
     
     particle.finishParticleSize=atof(particleEndSizeAttribute);
     
     //end size variance
     tinyxml2::XMLElement* particleEndSizeVarianceElement = particleConfig->FirstChildElement("finishParticleSizeVariance");
     
     const char* particleEndSizeVarianceAttribute=particleEndSizeVarianceElement->Attribute("value");
     
     particle.finishParticleSizeVariance=atof(particleEndSizeVarianceAttribute);
     
     //duration
     tinyxml2::XMLElement* emitterDurationRateElement = particleConfig->FirstChildElement("duration");
     
     const char* emitterDurationRateAttribute=emitterDurationRateElement->Attribute("value");
     
     particle.duration=atof(emitterDurationRateAttribute);
     
     //radial acceleration
     tinyxml2::XMLElement* particleRadialAccelerationElement = particleConfig->FirstChildElement("radialAcceleration");
     
     const char* particleRadialAccelerationAttribute=particleRadialAccelerationElement->Attribute("value");
     
     particle.radialAcceleration=atof(particleRadialAccelerationAttribute);
     
     //radial acceleration variance
     tinyxml2::XMLElement* particleRadialAccelerationVarianceElement = particleConfig->FirstChildElement("radialAccelVariance");
     
     const char* particleRadialAccelerationVarianceAttribute=particleRadialAccelerationVarianceElement->Attribute("value");
     
     particle.radialAccelerationVariance=atof(particleRadialAccelerationVarianceAttribute);
     
     //tangent acceleration
     tinyxml2::XMLElement* particleTangentAccelerationElement = particleConfig->FirstChildElement("tangentialAcceleration");
     
     const char* particleTangentAccelerationAttribute=particleTangentAccelerationElement->Attribute("value");
     
     particle.tangentialAcceleration=atof(particleTangentAccelerationAttribute);
     
     //tangent acceleration variance
     tinyxml2::XMLElement* particleTangentAccelerationVarianceElement = particleConfig->FirstChildElement("tangentialAccelVariance");
     
     const char* particleTangentAccelerationVarianceAttribute=particleTangentAccelerationVarianceElement->Attribute("value");
     
     particle.tangentialAccelerationVariance=atof(particleTangentAccelerationVarianceAttribute);
     
     //rotation start
     tinyxml2::XMLElement* particleStartRotationElement = particleConfig->FirstChildElement("rotationStart");
     
     const char* particleStartRotationAttribute=particleStartRotationElement->Attribute("value");
     
     particle.rotationStart=atof(particleStartRotationAttribute);
     
     //rotation start variance
     tinyxml2::XMLElement* particleStartRotationVarianceElement = particleConfig->FirstChildElement("rotationStartVariance");
     
     const char* particleStartRotationVarianceAttribute=particleStartRotationVarianceElement->Attribute("value");
     
     particle.rotationStartVariance=atof(particleStartRotationVarianceAttribute);
     
     //rotation end
     tinyxml2::XMLElement* particleEndRotationElement = particleConfig->FirstChildElement("rotationEnd");
     
     const char* particleEndRotationAttribute=particleEndRotationElement->Attribute("value");
     
     particle.rotationEnd=atof(particleEndRotationAttribute);
     
     //rotation start variance
     tinyxml2::XMLElement* particleEndRotationVarianceElement = particleConfig->FirstChildElement("rotationEndVariance");
     
     const char* particleEndRotationVarianceAttribute=particleEndRotationVarianceElement->Attribute("value");
     
     particle.rotationEndVariance=atof(particleEndRotationVarianceAttribute);
     
     //blending source
     tinyxml2::XMLElement* blendingFactorSourceElement = particleConfig->FirstChildElement("blendFuncSource");
     
     const char* blendingFactorSourceAttribute=blendingFactorSourceElement->Attribute("value");
     
     int blendingFactorSource=blendingFactorMapping(atoi(blendingFactorSourceAttribute));
     
     particle.blendFunctionSource=blendingFactorSource;
     
     //blending dest
     tinyxml2::XMLElement* blendingFactorDestElement = particleConfig->FirstChildElement("blendFuncDestination");
     
     const char* blendingFactorDestAttribute=blendingFactorDestElement->Attribute("value");
     
     int blendingFactorDest=blendingFactorMapping(atoi(blendingFactorDestAttribute));
     
     particle.blendFunctionDestination=blendingFactorDest;
    
    //texture
    tinyxml2::XMLElement *texture=particleConfig->FirstChildElement("texture");
    
    std::string textureName=texture->Attribute("name");
    
    particle.texture=textureName;
         
}

void ParticleDataConverter::setParticleName(std::string uName){
    
    particle.name=uName;
}


int ParticleDataConverter::blendingFactorMapping(int uBlending){
    
    int blendingFactor=0;
    
    switch (uBlending) {
        
        //GL_ZERO=MTLBlendFactorZero
        case 0:
            blendingFactor=0;
            break;
        
        //GL_ONE=MTLBlendFactorOne
        case 1:
            blendingFactor=1;
            break;
        
        //GL_DST_COLOR=MTLBlendFactorDestinationColor
        case 774:
            blendingFactor=6;
            break;
        
        //GL_ONE_MINUS_DST_COLOR=MTLBlendFactorOneMinusDestinationColor
        case 775:
            blendingFactor=7;
            break;
            
        //GL_SRC_ALPHA=MTLBlendFactorSourceAlpha
        case 770:
            blendingFactor=4;
            break;
            
        //GL_ONE_MINUS_SRC_ALPHA=MTLBlendFactorOneMinusSourceAlpha
        case 771:
            blendingFactor=5;
            break;
            
        //GL_DST_ALPHA=MTLBlendFactorDestinationAlpha
        case 772:
            blendingFactor=8;
            break;
            
        //GL_ONE_MINUS_DST_ALPHA=MTLBlendFactorOneMinusDestinationAlpha
        case 773:
            blendingFactor=9;
            break;
            
        //GL_SOURCE_ALPHA_SATURATED=MTLBlendFactorSourceAlphaSaturated
        case 776:
            blendingFactor=10;
            break;
            
        default:
            break;
    }
    
    return blendingFactor;
    
}

void ParticleDataConverter::writeParticleDataToFile(std::ofstream &file){
    
    //WRITE MODEL NAME
    //get the size of the string
    size_t particleNameLen=particle.name.size();
    file.write((char*)&particleNameLen,sizeof(particleNameLen));
    file.write((char*)&particle.name[0],particleNameLen);
    
    //POSITION VARIANCE
    int positionVarianceSize=(int)particle.positionVariance.size();
    file.write((char*)&positionVarianceSize,sizeof(int));
    file.write((char*)&particle.positionVariance[0],positionVarianceSize*sizeof(float));
    
    //SPEED
    float speedSize=(float)particle.speed;
    file.write((char*)&speedSize,sizeof(float));
    file.write((char*)&particle.speed,sizeof(speedSize));
    
    //speed variance
    float speedVarianceSize=(float)particle.speedVariance;
    file.write((char*)&speedVarianceSize,sizeof(float));
    file.write((char*)&particle.speedVariance,sizeof(speedVarianceSize));

    //life
    float lifeSpanSize=(float)particle.lifeSpan;
    file.write((char*)&lifeSpanSize,sizeof(float));
    file.write((char*)&particle.lifeSpan,sizeof(lifeSpanSize));

    //maximum number of particles
    int maxNumberOfParticlesSize=(int)particle.maxParticles;
    file.write((char*)&maxNumberOfParticlesSize,sizeof(int));
    file.write((char*)&particle.maxParticles,sizeof(maxNumberOfParticlesSize));

    //angle
    float angleSize=(float)particle.angle;
    file.write((char*)&angleSize,sizeof(float));
    file.write((char*)&particle.angle,sizeof(angleSize));

    //angle variance
    float angleVarianceSize=(float)particle.angleVariance;
    file.write((char*)&angleVarianceSize,sizeof(float));
    file.write((char*)&particle.angleVariance,sizeof(angleVarianceSize));

    //start color
    int startColorSize=(int)particle.startColor.size();
    file.write((char*)&startColorSize,sizeof(int));
    file.write((char*)&particle.startColor[0],startColorSize*sizeof(float));

    //start color variance
    int startColorVarianceSize=(int)particle.startColorVariance.size();
    file.write((char*)&startColorVarianceSize,sizeof(int));
    file.write((char*)&particle.startColorVariance[0],startColorVarianceSize*sizeof(float));

    //end color
    int finishColorSize=(int)particle.finishColor.size();
    file.write((char*)&finishColorSize,sizeof(int));
    file.write((char*)&particle.finishColor[0],finishColorSize*sizeof(float));

    //end color variance
    int finishColorVarianceSize=(int)particle.finishColorVariance.size();
    file.write((char*)&finishColorVarianceSize,sizeof(int));
    file.write((char*)&particle.finishColorVariance[0],finishColorVarianceSize*sizeof(float));

    //gravity
    int gravitySize=(int)particle.gravity.size();
    file.write((char*)&gravitySize,sizeof(int));
    file.write((char*)&particle.gravity[0],gravitySize*sizeof(float));

    //start particle size
    float startParticleSize=(float)particle.startParticleSize;
    file.write((char*)&startParticleSize,sizeof(float));
    file.write((char*)&particle.startParticleSize,sizeof(startParticleSize));

    //start particle size variance
    float startParticleVarianceSize=(float)particle.startParticleSizeVariance;
    file.write((char*)&startParticleVarianceSize,sizeof(float));
    file.write((char*)&particle.startParticleSizeVariance,sizeof(startParticleVarianceSize));

    //end particle size
    float finishParticleSize=(float)particle.finishParticleSize;
    file.write((char*)&finishParticleSize,sizeof(float));
    file.write((char*)&particle.finishParticleSize,sizeof(finishParticleSize));

    //end particle size variance
    float finishParticleVarianceSize=(float)particle.finishParticleSizeVariance;
    file.write((char*)&finishParticleVarianceSize,sizeof(float));
    file.write((char*)&particle.finishParticleSizeVariance,sizeof(finishParticleVarianceSize));

    //duration
    float durationSize=(float)particle.duration;
    file.write((char*)&durationSize,sizeof(float));
    file.write((char*)&particle.duration,sizeof(durationSize));

    //radial acceleration
    float radialAccelerationSize=(float)particle.radialAcceleration;
    file.write((char*)&radialAccelerationSize,sizeof(float));
    file.write((char*)&particle.radialAcceleration,sizeof(radialAccelerationSize));

    //radial acceleration variance
    float radialAccelerationVarianceSize=(float)particle.radialAccelerationVariance;
    file.write((char*)&radialAccelerationVarianceSize,sizeof(float));
    file.write((char*)&particle.radialAccelerationVariance,sizeof(radialAccelerationVarianceSize));

    //tangent acceleration
    float tangentialAccelerationSize=(float)particle.tangentialAcceleration;
    file.write((char*)&tangentialAccelerationSize,sizeof(float));
    file.write((char*)&particle.tangentialAcceleration,sizeof(tangentialAccelerationSize));

    //tangent acceleration variance
    float tangentialAccelerationVarianceSize=(float)particle.tangentialAccelerationVariance;
    file.write((char*)&tangentialAccelerationVarianceSize,sizeof(float));
    file.write((char*)&particle.tangentialAccelerationVariance,sizeof(tangentialAccelerationVarianceSize));

    //rotation start
    float rotationStartSize=(float)particle.rotationStart;
    file.write((char*)&rotationStartSize,sizeof(float));
    file.write((char*)&particle.rotationStart,sizeof(rotationStartSize));

    //rotation start variance
    float rotationStartVarianceSize=(float)particle.rotationStartVariance;
    file.write((char*)&rotationStartVarianceSize,sizeof(float));
    file.write((char*)&particle.rotationStartVariance,sizeof(rotationStartVarianceSize));

    //rotation end
    float rotationEndSize=(float)particle.rotationEnd;
    file.write((char*)&rotationEndSize,sizeof(float));
    file.write((char*)&particle.rotationEnd,sizeof(rotationEndSize));

    //rotation end variance
    float rotationEndVarianceSize=(float)particle.rotationEndVariance;
    file.write((char*)&rotationEndVarianceSize,sizeof(float));
    file.write((char*)&particle.rotationEndVariance,sizeof(rotationEndVarianceSize));

    //blending source
    int blendingSourceSize=(int)particle.blendFunctionSource;
    file.write((char*)&blendingSourceSize,sizeof(int));
    file.write((char*)&particle.blendFunctionSource,sizeof(blendingSourceSize));
    
    //blending dest
    int blendingDestinationSize=(int)particle.blendFunctionDestination;
    file.write((char*)&blendingDestinationSize,sizeof(int));
    file.write((char*)&particle.blendFunctionDestination,sizeof(blendingDestinationSize));

    //texture
    //get the size of the string
    size_t textureNamelen=particle.texture.size();
    file.write((char*)&textureNamelen,sizeof(textureNamelen));
    file.write((char*)&particle.texture[0],textureNamelen);
    
}

bool ParticleDataConverter::writeBinaryToFile(std::string filepath){
    
    std::ofstream file(filepath, std::ios::out | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        return false;
        
    }

    writeParticleDataToFile(file);
       
    //std::cout<<"Particle's data was converted into binary."<<std::endl;
    file.close();
    return true;
}


void ParticleDataConverter::readBinaryFile(std::string filepath){
    
    std::ifstream file(filepath, std::ios::in | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }
    
    file.seekg(0);
    
    PARTICLES particle;
    
    //READ NAME
    size_t particleNamelen=0;
    file.read((char*)&particleNamelen,sizeof(particleNamelen));
    particle.name.resize(particleNamelen);
    file.read((char*)&particle.name[0],particleNamelen);
    
    //READ position variance
    int positionVarianceSize=0;
    file.read((char*)&positionVarianceSize,sizeof(int));
    std::vector<float> tempPositionVariance(positionVarianceSize,0);
    
    //copy temp to position
    particle.positionVariance=tempPositionVariance;
    file.read((char*)&particle.positionVariance[0], positionVarianceSize*sizeof(float));
    
    //speed
    float speedSize=0;
    file.read((char*)&speedSize,sizeof(float));
    file.read((char*)&particle.speed, sizeof(speedSize));

    //speed variance
    float speedVarianceSize=0;
    file.read((char*)&speedVarianceSize,sizeof(float));
    file.read((char*)&particle.speedVariance, sizeof(speedVarianceSize));

    //life
    float lifeSpanSize=0;
    file.read((char*)&lifeSpanSize,sizeof(float));
    file.read((char*)&particle.lifeSpan, sizeof(lifeSpanSize));

    //maximum number of particles
    int maximumParticlesSize=0;
    file.read((char*)&maximumParticlesSize,sizeof(int));
    file.read((char*)&particle.maxParticles, sizeof(maximumParticlesSize));

    //angle
    float angleSize=0;
    file.read((char*)&angleSize,sizeof(float));
    file.read((char*)&particle.angle, sizeof(angleSize));

    //angle variance
    float angleVarianceSize=0;
    file.read((char*)&angleVarianceSize,sizeof(float));
    file.read((char*)&particle.angleVariance, sizeof(angleVarianceSize));

    //start color
    int startColorSize=0;
    file.read((char*)&startColorSize,sizeof(int));
    std::vector<float> tempStartColor(startColorSize,0);
    
    //copy temp to start color
    particle.startColor=tempStartColor;
    file.read((char*)&particle.startColor[0], startColorSize*sizeof(float));

    //start color variance
    int startColorVarianceSize=0;
    file.read((char*)&startColorVarianceSize,sizeof(int));
    std::vector<float> tempStartColorVariance(startColorVarianceSize,0);
    
    //copy temp to start color
    particle.startColorVariance=tempStartColorVariance;
    file.read((char*)&particle.startColorVariance[0], startColorVarianceSize*sizeof(float));

    //end color
    int endColorSize=0;
    file.read((char*)&endColorSize,sizeof(int));
    std::vector<float> tempEndColor(endColorSize,0);
    
    //copy temp to start color
    particle.finishColor=tempEndColor;
    file.read((char*)&particle.finishColor[0], endColorSize*sizeof(float));

    //end color variance
    int endColorVarianceSize=0;
    file.read((char*)&endColorVarianceSize,sizeof(int));
    std::vector<float> tempEndColorVariance(endColorVarianceSize,0);
    
    //copy temp to start color
    particle.finishColorVariance=tempEndColorVariance;
    file.read((char*)&particle.finishColorVariance[0], endColorVarianceSize*sizeof(float));

    //gravity
    int gravitySize=0;
    file.read((char*)&gravitySize,sizeof(int));
    std::vector<float> tempGravity(gravitySize,0);
    
    //copy temp to gravity
    particle.gravity=tempGravity;
    file.read((char*)&particle.gravity[0], gravitySize*sizeof(float));

    //start particle size
    float startParticleSize=0;
    file.read((char*)&startParticleSize,sizeof(float));
    file.read((char*)&particle.startParticleSize, sizeof(startParticleSize));

    //start particle size variance
    float startParticleVarianceSize=0;
    file.read((char*)&startParticleVarianceSize,sizeof(float));
    file.read((char*)&particle.startParticleSizeVariance, sizeof(startParticleVarianceSize));

    //end particle size
    float finishParticleSize=0;
    file.read((char*)&finishParticleSize,sizeof(float));
    file.read((char*)&particle.finishParticleSize, sizeof(finishParticleSize));

    //end particle size variance
    float finishParticleVarianceSize=0;
    file.read((char*)&finishParticleVarianceSize,sizeof(float));
    file.read((char*)&particle.finishParticleSizeVariance, sizeof(finishParticleVarianceSize));

    //duration
    float durationSize=0;
    file.read((char*)&durationSize,sizeof(float));
    file.read((char*)&particle.duration, sizeof(durationSize));

    //radial acceleration
    float radialAccelerationSize=0;
    file.read((char*)&radialAccelerationSize,sizeof(float));
    file.read((char*)&particle.radialAcceleration, sizeof(radialAccelerationSize));

    //radial acceleration variance
    float radialAccelerationVarianceSize=0;
    file.read((char*)&radialAccelerationVarianceSize,sizeof(float));
    file.read((char*)&particle.radialAccelerationVariance, sizeof(radialAccelerationVarianceSize));

    //tangent acceleration
    float tangentialAccelerationSize=0;
    file.read((char*)&tangentialAccelerationSize,sizeof(float));
    file.read((char*)&particle.tangentialAcceleration, sizeof(tangentialAccelerationSize));

    //tangent acceleration variance
    float tangentialAccelerationVarianceSize=0;
    file.read((char*)&tangentialAccelerationVarianceSize,sizeof(float));
    file.read((char*)&particle.tangentialAccelerationVariance, sizeof(tangentialAccelerationVarianceSize));

    //rotation start
    float rotationStartSize=0;
    file.read((char*)&rotationStartSize,sizeof(float));
    file.read((char*)&particle.rotationStart, sizeof(rotationStartSize));

    //rotation start variance
    float rotationStartVarianceSize=0;
    file.read((char*)&rotationStartVarianceSize,sizeof(float));
    file.read((char*)&particle.rotationStartVariance, sizeof(rotationStartVarianceSize));

    //rotation end
    float rotationEndSize=0;
    file.read((char*)&rotationEndSize,sizeof(float));
    file.read((char*)&particle.rotationEnd, sizeof(rotationEndSize));

    //rotation end variance
    float rotationEndVarianceSize=0;
    file.read((char*)&rotationEndVarianceSize,sizeof(float));
    file.read((char*)&particle.rotationEndVariance, sizeof(rotationEndVarianceSize));

    //blending source
    float blendingSourceSize=0;
    file.read((char*)&blendingSourceSize,sizeof(float));
    file.read((char*)&particle.blendFunctionSource, sizeof(blendingSourceSize));

    //blending dest
    float blendingDestinationSize=0;
    file.read((char*)&blendingDestinationSize,sizeof(float));
    file.read((char*)&particle.blendFunctionDestination, sizeof(blendingDestinationSize));

    //texture
    size_t textureNamelen=0;
    file.read((char*)&textureNamelen,sizeof(textureNamelen));
    particle.texture.resize(textureNamelen);
    file.read((char*)&particle.texture[0],textureNamelen);

}

