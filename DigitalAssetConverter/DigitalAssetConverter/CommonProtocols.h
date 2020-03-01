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
