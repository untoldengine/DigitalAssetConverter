//
//  CommonProtocols.h
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/13/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef CommonProtocols_h
#define CommonProtocols_h

#include <string.h>
#include <vector>

typedef struct {
    std::string name;
    std::string parent;
    std::vector<float> localMatrix;
    std::vector<float> bindPoseMatrix;
    std::vector<float> inversePoseMatrix;
    std::vector<float> restPoseMatrix;
    std::vector<float> vertexWeights;
}BONES;

typedef struct{
    int numberOfBones=0;
    std::vector<float> bindShapeMatrix;
    std::vector<BONES> bones;
}ARMATURE;

typedef struct{
    std::string boneName;
    std::vector<float> poseMatrix;
}ANIMPOSE;

typedef struct{
    float time=0.0;
    int boneCount=0;
    std::vector<ANIMPOSE> animPoseMatrix;
}KEYFRAME;

typedef struct{
    std::string name;
    float fps=0.0;
    int keyframeCount=0;
    std::vector<float> poseTransform;
    std::vector<KEYFRAME> keyframes;
}ANIMATIONS;

typedef struct{
    
    std::string name;
    std::vector<float> vertices;
    std::vector<float> normals;
    std::vector<float> uv;
    std::vector<int> index;
    std::vector<float> convexHullVertices;
    std::vector<float> convexHullEdges;
    std::vector<float> convexHullFaces;
    std::vector<int> materialIndex;
    std::vector<float> diffuseColor;
    std::vector<float> specularColor;
    std::vector<float> diffuseIntensity;
    std::vector<float> specularIntensity;
    std::vector<float> specularHardness;
    std::string textureImage;
    std::vector<float> localMatrix;
    std::vector<float> dimension;
    std::vector<float> meshVertices;
    std::vector<int> meshEdgesIndex;
    std::vector<int> meshFacesIndex;
    ARMATURE armature;
    
}MODEL;

typedef struct{
    
    int meshesCount=0;
    std::vector<MODEL> gameModels;
    
}MODELS;


typedef struct{
    
    std::string name;
    unsigned int width=0;
    unsigned int height=0;
    std::vector<unsigned char> image;

}TEXTURES;

typedef struct{
    
    std::string name;
    std::vector<float> positionVariance;
    float speed=0.0;
    float speedVariance=0.0;
    float lifeSpan=0.0;
    float angle=0.0;
    float angleVariance=0.0;
    std::vector<float> gravity;
    float radialAcceleration=0.0;
    float tangentialAcceleration=0.0;
    float radialAccelerationVariance=0.0;
    float tangentialAccelerationVariance=0.0;
    std::vector<float> startColor;
    std::vector<float> startColorVariance;
    std::vector<float> finishColor;
    std::vector<float> finishColorVariance;
    int maxParticles=0;
    float startParticleSize=0.0;
    float startParticleSizeVariance=0.0;
    float finishParticleSize=0.0;
    float finishParticleSizeVariance=0.0;
    float duration=0.0;
    float maxRadius=0.0;
    float maxRadiusVariance=0.0;
    float minRadius=0.0;
    float minRadiusVariance=0.0;
    float rotatePerSecond=0.0;
    float rotatePerSecondVariance=0.0;
    int blendFunctionSource=0;
    int blendFunctionDestination=0;
    float rotationStart=0.0;
    float rotationStartVariance=0.0;
    float rotationEnd=0.0;
    float rotationEndVariance=0.0;
    std::string texture;
    
}PARTICLES;

typedef struct{
    
    /**
     @brief Font character ID
     */
    int ID;
    
    /**
     @brief Font character x-coordinate position
     */
    float x;
    
    /**
     @brief Font character y-coordinate position
     */
    float y;
    
    /**
     @brief Font character width
     */
    float width;
    
    /**
     @brief Font character height
     */
    float height;
    
    /**
     @brief Font character x-offset position
     */
    float xoffset;
    
    /**
     @brief Font character y-offset position
     */
    float yoffset;
    
    /**
     @brief Font character x-advance
     */
    float xadvance;
    
    /**
     @brief Font character letter name
     */
     std::string letter;
    
}CHARACTERDATA;

typedef struct{
    
    std::string name;
    int fontSize;
    float fontAtlasWidth;
    float fontAtlasHeight;
    std::string texture;
    int charCount;
    std::vector<CHARACTERDATA> characterData;
    
}FONTDATA;

typedef struct{

    std::string name;
    float energy;
    std::vector<float> color;
    std::vector<float> localMatrix;
    
}DIRECTIONALLIGHT;


typedef struct{
    
    std::string name;
    float energy;
    float falloutDistance;
    float constantCoefficient;
    float linearCoefficient;
    float quadraticCoefficient;
    std::vector<float> color;
    std::vector<float> localMatrix;
    
}POINTLIGHT;

typedef struct{
    int numberOfDirectionalLights;
    int numberOfPointLights;
    std::vector<DIRECTIONALLIGHT> directionalLights;
    std::vector<POINTLIGHT> pointLights;
    
}LIGHTS;

//CONVEX HULL STRUCTURES
typedef struct CONVEXHULLVERTEXSTRUCT CONVEXVERTEX;
typedef CONVEXVERTEX *CONVEXHULLVERTEX;

typedef struct CONVEXHULLEDGESTRUCT CONVEXEDGE;
typedef CONVEXEDGE *CONVEXHULLEDGE;

typedef struct CONVEXHULLFACESTRUCT CONVEXFACE;
typedef CONVEXFACE *CONVEXHULLFACE;

/**
 @brief The CONVEXHULLVERTEXSTRUCT structure holds vertices information used for the construction of the convex-hull
 */
struct CONVEXHULLVERTEXSTRUCT{
    /**
     @brief Array containing the components of the vertex
     */
    float v[3];
    
    /**
     @brief total number of vertices
     */
    int vNum;
    
    /**
     @brief duplicate convex hull edge
     */
    CONVEXHULLEDGE duplicate;
    
    /**
     @brief Boolean variable which is used to flag the convex-hull algorithm that the vertex is on-Hull
     */
    bool onHull;
    
    /**
     @brief Boolean variable which is used to flag the convex-hull algorithm that the vertex has been processed
     */
    bool processed;
    
    /**
     @brief Pointer to the Next vertex
     */
    CONVEXHULLVERTEX next;
    
    /**
     @brief Pointer to the Previous vertex
     */
    CONVEXHULLVERTEX prev;
    
};

/**
 @brief The CONVEXHULLEDGESTRUCT structure holds edges information used during the construction of the convex-hull
 */
struct CONVEXHULLEDGESTRUCT{
    /**
     @brief Array of faces adjacent to the edge
     */
    CONVEXHULLFACE adjFace[2];
    
    /**
     @brief Array of endpoint vertices composing the edge
     */
    CONVEXHULLVERTEX endPts[2];
    
    /**
     @brief New face in convex-hull
     */
    CONVEXHULLFACE newFace;
    
    /**
     @brief Boolean variable which informs the convex-hull algorithm that the edge should be deleted
     */
    bool shouldDelete;
    
    /**
     @brief Pointer to the the Next edge
     */
    CONVEXHULLEDGE next;
    
    /**
     @brief Pointer to the Previous edge
     */
    CONVEXHULLEDGE prev;
};

/**
 @brief The CONVEXHULLFACESTRUCT structure holds faces information used during the construction of the convex-hull
 */
struct CONVEXHULLFACESTRUCT{
    /**
     @brief Array of edges composing the current face
     */
    CONVEXHULLEDGE edge[3];
    
    /**
     @brief Array of vertices composing the current face
     */
    CONVEXHULLVERTEX vertex[3];
    
    /**
     @brief Boolean algebra which informs the convex-hull algorithm that the face is seen by a point
     */
    bool visible;
    
    /**
     @brief Pointer to the Next face
     */
    CONVEXHULLFACE next;
    
    /**
     @brief Pointer to the Previous face
     */
    CONVEXHULLFACE prev;
};


#endif /* CommonProtocols_h */
