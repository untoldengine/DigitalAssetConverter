//
//  AnimDataConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/14/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "AnimDataConverter.hpp"

AnimDataConverter::AnimDataConverter(){
    
}

AnimDataConverter::~AnimDataConverter(){
    
}

void AnimDataConverter::readBinaryFile(std::string filepath){
    
    std::ifstream file(filepath, std::ios::in | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }
    
    file.seekg(0);
    
    ANIMATIONS animation;
    
    //READ ANIMATION NAME
    size_t animNamelen=0;
    file.read((char*)&animNamelen,sizeof(animNamelen));
    animation.name.resize(animNamelen);
    file.read((char*)&animation.name[0],animNamelen);
    
    
    //ANIMATION TRANSFORM
    int poseTransformSize=0;
    file.read((char*)&poseTransformSize,sizeof(int));
    std::vector<float> tempPoseTransform(poseTransformSize,0);
    
    //copy temp to anim2
    animation.poseTransform=tempPoseTransform;
    file.read((char*)&animation.poseTransform[0], poseTransformSize*sizeof(float));
    
    //FPS
    float fpsSize=0;
    file.read((char*)&fpsSize,sizeof(float));
    file.read((char*)&animation.fps, sizeof(fpsSize));
    
    //KEYFRAME COUNT
    int keyframeCountSize=0;
    file.read((char*)&keyframeCountSize,sizeof(int));
    file.read((char*)&animation.keyframeCount, sizeof(keyframeCountSize));
    
    for (int i=0; i<keyframeCountSize; i++) {
    
        KEYFRAME keyframe;
        
        //TIME
        float timeSize=0;
        file.read((char*)&timeSize,sizeof(float));
        file.read((char*)&keyframe.time, sizeof(timeSize));
        
        //BONE COUNT
        int boneCountSize=0;
        file.read((char*)&boneCountSize,sizeof(int));
        file.read((char*)&keyframe.boneCount, sizeof(boneCountSize));
        
        for (int j=0; j<boneCountSize; j++) {
            
            ANIMPOSE animpose;
            
            //NAME
            size_t animPoseBoneNamelen=0;
            file.read((char*)&animPoseBoneNamelen,sizeof(animPoseBoneNamelen));
            animpose.boneName.resize(animPoseBoneNamelen);
            file.read((char*)&animpose.boneName[0],animPoseBoneNamelen);
            
            //BONE POSE MATRIX
            int bonePoseMatrixSize=0;
            file.read((char*)&bonePoseMatrixSize,sizeof(int));
            std::vector<float> tempBonePoseMatrix(bonePoseMatrixSize,0);
            
            //copy temp to anim2
            animpose.poseMatrix=tempBonePoseMatrix;
            file.read((char*)&animpose.poseMatrix[0], bonePoseMatrixSize*sizeof(float));
            
            keyframe.animPoseMatrix.push_back(animpose);
            
        }
        
        animation.keyframes.push_back(keyframe);
    }
    
    //COUT
//    std::cout<<"Animation Name: "<<animation.name<<std::endl;
//    std::cout<<"FPS: "<<animation.fps<<std::endl;
//
//    for(auto n:animation.poseTransform){
//        std::cout<<n<<" , ";
//    }
//
//    for(auto n:animation.keyframes){
//
//        std::cout<<"TIME: "<<n.time<<std::endl;
//
//        for(auto m:n.animPoseMatrix){
//
//            std::cout<<"NAME: "<<m.boneName<<std::endl;
//
//            for(auto p:m.poseMatrix){
//                std::cout<<p<<" , ";
//            }
//        }
//    }
    
}

void AnimDataConverter::writeBinaryToFile(std::string filepath){
    
    std::ofstream file(filepath, std::ios::out | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }

    writeAnimDataToFile(file);
       
    std::cout<<"Animation data was converted into binary."<<std::endl;
    
    file.close();
    
}

void AnimDataConverter::writeAnimDataToFile(std::ofstream &file){
    
    //ANIMATION NAME
    //get the size of the string
    size_t animNameLen=animationData.name.size();
    file.write((char*)&animNameLen,sizeof(animNameLen));
    file.write((char*)&animationData.name[0],animNameLen);
    
    //ANIMATION TRANSFORM
    int animTransformSize=(int)animationData.poseTransform.size();
    file.write((char*)&animTransformSize,sizeof(int));
    file.write((char*)&animationData.poseTransform[0],animTransformSize*sizeof(float));
        
    //FPS
    float fpsSize=(float)animationData.fps;
    file.write((char*)&fpsSize,sizeof(float));
    file.write((char*)&animationData.fps,sizeof(fpsSize));
    
    //Keyframe count
    int keyframeCountSize=(int)animationData.keyframeCount;
    file.write((char*)&keyframeCountSize,sizeof(int));
    file.write((char*)&animationData.keyframeCount,sizeof(keyframeCountSize));
    
    for(int i=0;i<keyframeCountSize;i++){
        
        //TIME
        float timeSize=(float)animationData.keyframes.at(i).time;
        file.write((char*)&timeSize,sizeof(timeSize));
        file.write((char*)&animationData.keyframes.at(i),sizeof(timeSize));
        
        //BONE COUNT
        int boneCountSize=(int)animationData.keyframes.at(i).boneCount;
        file.write((char*)&boneCountSize,sizeof(boneCountSize));
        file.write((char*)&animationData.keyframes.at(i).boneCount,sizeof(boneCountSize));
        
        for (int j=0; j<boneCountSize; j++) {
            
            //NAME
            size_t poseNameLen=animationData.keyframes.at(i).animPoseMatrix.at(j).boneName.size();
            file.write((char*)&poseNameLen,sizeof(poseNameLen));
            file.write((char*)&animationData.keyframes.at(i).animPoseMatrix.at(j).boneName[0],poseNameLen);
            
            //POSE MATRIX
            int animPoseTransformSize=(int)animationData.keyframes.at(i).animPoseMatrix.at(j).poseMatrix.size();
            file.write((char*)&animPoseTransformSize,sizeof(int));
            file.write((char*)&animationData.keyframes.at(i).animPoseMatrix.at(j).poseMatrix[0],animPoseTransformSize*sizeof(float));
            
        }
        
    }
    
    
}

void AnimDataConverter::parseXML(){
    
    tinyxml2::XMLNode *root=doc.FirstChildElement("UntoldEngine");
    
    //Get Mesh ID
    tinyxml2::XMLElement *node=root->FirstChildElement("asset")->FirstChildElement("meshes");
    if (node!=NULL) {
        
        for (tinyxml2::XMLElement *child=node->FirstChildElement("mesh"); child!=NULL; child=child->NextSiblingElement("mesh")) {
            
                tinyxml2::XMLElement *animations=child->FirstChildElement("animations");
                
                if (animations!=NULL) {
                    
                    //get the modeler animation transform
                    tinyxml2::XMLElement *modelerAnimationTransform=animations->FirstChildElement("modeler_animation_transform");
                    
                    //load the modeler animation transform
                    if (modelerAnimationTransform!=NULL) {
                        
                        std::string modelerAnimationTransformString=modelerAnimationTransform->GetText();
                        
                        loadData(animationData.poseTransform ,modelerAnimationTransformString);
                        
                    }
                    
                    //iterate through all animations
                    for (tinyxml2::XMLElement *animationChild=animations->FirstChildElement("animation"); animationChild!=NULL; animationChild=animationChild->NextSiblingElement("animation")) {
                        
                        //get animation name
                        animationData.name=animationChild->Attribute("name");
                        
                        //fps
                        std::string animationFPS=animationChild->Attribute("fps");
                        animationData.fps=std::stof(animationFPS);
                        
                        //keyframe count
                        std::string keyframeCount=animationChild->Attribute("keyframe_count");
                        animationData.keyframeCount=stoi(keyframeCount);
                        
                         for (tinyxml2::XMLElement *keyframe=animationChild->FirstChildElement("keyframe"); keyframe!=NULL; keyframe=keyframe->NextSiblingElement("keyframe")) {
                          
                             //KEYFRAME DATA
                             KEYFRAME keyframeData;
                             
                             //get keyframe
                             keyframeData.time=std::stof(keyframe->Attribute("time"));
                             
                             keyframeData.boneCount=std::stoi(keyframe->Attribute("bone_count"));
                             
                             for (tinyxml2::XMLElement *boneTransform=keyframe->FirstChildElement("pose_matrix"); boneTransform!=NULL; boneTransform=boneTransform->NextSiblingElement("pose_matrix")) {
                                 
                                 //BONE POSE MATRIX
                                 ANIMPOSE animPose;
                                 
                                 //get bone Pose name
                                 animPose.boneName=boneTransform->Attribute("name");
                                 
                                 //get bone Pose transform
                                 std::string boneTransformString=boneTransform->GetText();
                                 
                                 loadData(animPose.poseMatrix, boneTransformString);
                                 
                                 keyframeData.animPoseMatrix.push_back(animPose);
                                 
                             }
                             
                             animationData.keyframes.push_back(keyframeData);
                             
                         }
                    }
                    
                }
            
        }
        
    }
    
}
