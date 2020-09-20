//
//  MeshDataConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/13/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "MeshDataConverter.h"
#include "ConvexHullAlgorithm.h"

MeshDataConverter::MeshDataConverter(){
    
}

MeshDataConverter::~MeshDataConverter(){
    
}

void MeshDataConverter::parseXML(){
     
     tinyxml2::XMLNode *root=doc.FirstChildElement("UntoldEngine");
     
     //Get Mesh ID
     tinyxml2::XMLElement *node=root->FirstChildElement("asset")->FirstChildElement("meshes");
     
     if (node!=NULL) {
         
         //set the number of meshes in the scene
         std::string meshesCount=node->Attribute("meshes_count");
         models.meshesCount=stoi(meshesCount);
         
         for (tinyxml2::XMLElement *child=node->FirstChildElement("mesh"); child!=NULL; child=child->NextSiblingElement("mesh")) {
             
             
                 std::string meshName=child->Attribute("name");
             
                 tinyxml2::XMLElement *vertices=child->FirstChildElement("vertices");
                 tinyxml2::XMLElement *normal=child->FirstChildElement("normal");
                 tinyxml2::XMLElement *uv=child->FirstChildElement("uv");
                 tinyxml2::XMLElement *index=child->FirstChildElement("index");
                 tinyxml2::XMLElement *preHullVertices=child->FirstChildElement("prehullvertices");
                 tinyxml2::XMLElement *materialIndex=child->FirstChildElement("material_index");
                 tinyxml2::XMLElement *diffuseColor=child->FirstChildElement("diffuse_color");
                 tinyxml2::XMLElement *specularColor=child->FirstChildElement("specular_color");
                 tinyxml2::XMLElement *diffuseIntensity=child->FirstChildElement("diffuse_intensity");
                 tinyxml2::XMLElement *specularIntensity=child->FirstChildElement("specular_intensity");
                 tinyxml2::XMLElement *specularHardness=child->FirstChildElement("specular_hardness");
                 tinyxml2::XMLElement *texture=child->FirstChildElement("texture_image");
                 tinyxml2::XMLElement *localMatrix=child->FirstChildElement("local_matrix");
                 tinyxml2::XMLElement *armature=child->FirstChildElement("armature");
                 tinyxml2::XMLElement *dimension=child->FirstChildElement("dimension");
                 tinyxml2::XMLElement *meshVertices=child->FirstChildElement("mesh_vertices");
                 tinyxml2::XMLElement *meshEdgesIndex=child->FirstChildElement("mesh_edges_index");
                 tinyxml2::XMLElement *meshFacesIndex=child->FirstChildElement("mesh_faces_index");
                 
                 //Set name
                 MODEL model;
                 model.name=meshName;

                 if (vertices!=NULL) {
                     
                     std::string data=vertices->GetText();
                     loadData(model.vertices, data);
                     
                 }
                 
                 if (normal!=NULL) {

                     std::string data=normal->GetText();
                     loadData(model.normals, data);

                 }

                 if (uv!=NULL) {

                     std::string data=uv->GetText();
                     loadData(model.uv, data);

                 }

                 if (index!=NULL) {

                     std::string data=index->GetText();
                     loadData(model.index, data);

                 }
                 
                 if (preHullVertices!=NULL) {
                     
                     std::vector<float> preConvexHullVertices;
                     
                     std::string data=preHullVertices->GetText();
                     
                     loadData(preConvexHullVertices, data);
                     
                     //Compute the Convex Hull
                     ConvexHullAlgorithm cv;
                     
                     cv.computeConvexHull(preConvexHullVertices,model.convexHullVertices,model.convexHullEdges,model.convexHullFaces);
                 
                 }
                 
                 
                 if (materialIndex!=NULL) {
                     
                     std::string data=materialIndex->GetText();
                     loadData(model.materialIndex, data);
                     
                 }
                 
                 if (diffuseColor!=NULL) {
                     
                     std::string diffuseColorString=diffuseColor->GetText();
                     loadData(model.diffuseColor, diffuseColorString);
                     
                 }
                 
                 
                 if (specularColor!=NULL) {
                     
                     std::string specularColorString=specularColor->GetText();
                     loadData(model.specularColor, specularColorString);
                     
                 }
                 
                 if (diffuseIntensity!=NULL) {
                     
                     std::string diffuseIntensityString=diffuseIntensity->GetText();
                     loadData(model.diffuseIntensity, diffuseIntensityString);
                     
                 }
                 
                 if (specularIntensity!=NULL) {
                     
                     std::string specularIntensityString=specularIntensity->GetText();
                     loadData(model.specularIntensity, specularIntensityString);
                     
                 }
                 
                 if (specularHardness!=NULL) {
                     
                     std::string specularHardnessString=specularHardness->GetText();
                     loadData(model.specularHardness, specularHardnessString);
                     
                 }
                 
                 if(texture!=NULL){
                     
                     std::string textureString=texture->GetText();
                     model.textureImage=textureString;
                     
                 }
                 
                 if (localMatrix!=NULL) {
                     
                     std::string bodyTransformatioMatrix=localMatrix->GetText();
                     loadData(model.localMatrix,bodyTransformatioMatrix);
                 }
                 
                 if (dimension!=NULL) {
                     std::string data=dimension->GetText();
                     loadData(model.dimension, data);
                 }
                 
                 if (meshVertices!=NULL) {
                                     
                     std::string data=meshVertices->GetText();
                     loadData(model.meshVertices, data);
                     
                 }
                 
                 if (meshEdgesIndex!=NULL) {
                     
                     std::string data=meshEdgesIndex->GetText();
                     loadData(model.meshEdgesIndex, data);
                     
                 }
                 
                 if (meshFacesIndex!=NULL) {
                     
                     std::string data=meshFacesIndex->GetText();
                     loadData(model.meshFacesIndex, data);
                     
                 }
             
             ///LOAD ARMARUTE
             if (armature!=NULL) {
                 
                 ARMATURE modelArmature;
                 
                 //read the Bind Shape Matrix
                 tinyxml2::XMLElement *bindShapeMatrix=armature->FirstChildElement("bind_shape_matrix");
                 
                 if (bindShapeMatrix!=NULL) {
                     std::string bindShapeMatrixString=bindShapeMatrix->GetText();
                     
                     loadData(modelArmature.bindShapeMatrix, bindShapeMatrixString);
                     
                 }
                 
                 //iterate through all the bones in the armature
                 for (tinyxml2::XMLElement *bone=armature->FirstChildElement("bone"); bone!=NULL; bone=bone->NextSiblingElement("bone")) {
                 
                     std::string boneParentName=bone->Attribute("parent");
                     std::string boneChildName=bone->Attribute("name");
                     
                     //if bone is root, then create a bone with parent set to root
                     BONES modelBones;
                     
                     modelBones.name=boneChildName;
                     modelBones.parent=boneParentName;
                     
                     //add the local matrix
                     
                     tinyxml2::XMLElement *boneMatrixLocal=bone->FirstChildElement("local_matrix");
                     
                     if (boneMatrixLocal!=NULL) {
                         
                         std::string matrixLocalString=boneMatrixLocal->GetText();
                         
                         loadData(modelBones.localMatrix, matrixLocalString);
                     }
                     
                     //add the bind pose Matrix
                     
                     tinyxml2::XMLElement *bindPoseMatrix=bone->FirstChildElement("bind_pose_matrix");
                     if (bindPoseMatrix!=NULL) {
                         
                         std::string bindPoseMatrixString=bindPoseMatrix->GetText();
                         
                         loadData(modelBones.bindPoseMatrix, bindPoseMatrixString);
                     }
                     
                     //add the bind pose inverse matrix
                     
                     tinyxml2::XMLElement *bindPoseInverseMatrix=bone->FirstChildElement("inverse_bind_pose_matrix");
                     
                     if (bindPoseInverseMatrix!=NULL) {
                         
                         std::string bindPoseInverseMatrixString=bindPoseInverseMatrix->GetText();
                        
                         loadData(modelBones.inversePoseMatrix, bindPoseInverseMatrixString);
                     }
                     
                    
                     //add the vertex weights
                     
                     tinyxml2::XMLElement *vertexWeights=bone->FirstChildElement("vertex_weights");
                     
                     if (vertexWeights!=NULL) {
                         
                         std::string vertexWeightsString=vertexWeights->GetText();
                         
                         loadData(modelBones.vertexWeights, vertexWeightsString);
                     }
                     
                     //add bone to armature
                     modelArmature.bones.push_back(modelBones);
                     
                 }//end for
                 
                 //set armature
                 model.armature=modelArmature;
                 model.armature.numberOfBones=(int)modelArmature.bones.size();
                 
             }
         
         //push model
         models.gameModels.push_back(model);

         }
      
            
     }

}

void MeshDataConverter::writeMeshDataToFile(std::ofstream &file,MODEL &uModel){
    
    //WRITE MODEL NAME
    //get the size of the string
    size_t modelNameLen=uModel.name.size();
    file.write((char*)&modelNameLen,sizeof(modelNameLen));
    file.write((char*)&uModel.name[0],modelNameLen);
    
    //WRITE VERTICES
    
    int verticesSize=(int)uModel.vertices.size();
    file.write((char*)&verticesSize,sizeof(int));
    file.write((char*)&uModel.vertices[0],verticesSize*sizeof(float));
    
    //WRITE NORMALS
    
    int normalsSize=(int)uModel.normals.size();
    
    file.write((char*)&normalsSize,sizeof(int));
    
    file.write((char*)&uModel.normals[0],normalsSize*sizeof(float));
    
    //WRITE UVs
    
    int uvSize=(int)uModel.uv.size();
    
    file.write((char*)&uvSize,sizeof(int));
    
    file.write((char*)&uModel.uv[0],uvSize*sizeof(float));
    
    //WRITE INDEX
    
    int indexSize=(int)uModel.index.size();
    
    file.write((char*)&indexSize,sizeof(int));
    
    file.write((char*)&uModel.index[0],indexSize*sizeof(int));
   
    //WRITE CONVEX HULL VERTICES
    int convexHullVerticesSize=(int)uModel.convexHullVertices.size();
    
    file.write((char*)&convexHullVerticesSize,sizeof(int));
    
    file.write((char*)&uModel.convexHullVertices[0],convexHullVerticesSize*sizeof(float));

    //WRITE CONVEX HULL EDGES
    int convexHullEdgesSize=(int)uModel.convexHullEdges.size();
    
    file.write((char*)&convexHullEdgesSize,sizeof(int));
    
    file.write((char*)&uModel.convexHullEdges[0],convexHullEdgesSize*sizeof(float));
    
    //WRITE CONVEX HULL FACES
    int convexHullFacesSize=(int)uModel.convexHullFaces.size();
    
    file.write((char*)&convexHullFacesSize,sizeof(int));
    
    file.write((char*)&uModel.convexHullFaces[0],convexHullFacesSize*sizeof(float));
    
    //WRITE MATERIAL INDEX
    
    int materialIndexSize=(int)uModel.materialIndex.size();
    
    file.write((char*)&materialIndexSize,sizeof(int));
    
    file.write((char*)&uModel.materialIndex[0],materialIndexSize*sizeof(int));
    
    //WRITE DIFFUSE COLOR
    
    int diffuseColorSize=(int)uModel.diffuseColor.size();
    
    file.write((char*)&diffuseColorSize,sizeof(int));
    
    file.write((char*)&uModel.diffuseColor[0],diffuseColorSize*sizeof(float));
    
    //WRITE SPECULAR COLOR
    
    int specularColorSize=(int)uModel.specularColor.size();
    
    file.write((char*)&specularColorSize,sizeof(int));
    
    file.write((char*)&uModel.specularColor[0],specularColorSize*sizeof(float));
    
    //WRITE DIFFUSE INTENSITY
    
    int diffuseIntensitySize=(int)uModel.diffuseIntensity.size();
    
    file.write((char*)&diffuseIntensitySize,sizeof(int));
    
    file.write((char*)&uModel.diffuseIntensity[0],diffuseIntensitySize*sizeof(float));
    
    //WRITE SPECULAR INTENSITY
    
    int specularIntensitySize=(int)uModel.specularIntensity.size();
    
    file.write((char*)&specularIntensitySize,sizeof(int));
    
    file.write((char*)&uModel.specularIntensity[0],specularIntensitySize*sizeof(float));
    
    //WRITE SPECULAR HARDNESS
    
    int specularHardnessSize=(int)uModel.specularHardness.size();
    
    file.write((char*)&specularHardnessSize,sizeof(int));
    
    file.write((char*)&uModel.specularHardness[0],specularHardnessSize*sizeof(float));
    
    //WRITE TEXTURE IMAGE
    //get the size of the string
    size_t textureNamelen=uModel.textureImage.size();
    file.write((char*)&textureNamelen,sizeof(textureNamelen));
    file.write((char*)&uModel.textureImage[0],textureNamelen);
    
    //WRITE LOCAL MATRIX
    
    int localMatrixSize=(int)uModel.localMatrix.size();
    
    file.write((char*)&localMatrixSize,sizeof(int));
    
    file.write((char*)&uModel.localMatrix[0],localMatrixSize*sizeof(float));
    
    //WRITE DIMENSION
    
    int dimensionSize=(int)uModel.dimension.size();
    
    file.write((char*)&dimensionSize,sizeof(int));
    
    file.write((char*)&uModel.dimension[0],dimensionSize*sizeof(float));
    
    //WRITE MESH VERTICES
    int meshVerticesSize=(int)uModel.meshVertices.size();
    
    file.write((char*)&meshVerticesSize,sizeof(int));
    
    file.write((char*)&uModel.meshVertices[0],meshVerticesSize*sizeof(int));
    
    //WRITE MESH EDGES INDEX
    int meshEdgesSize=(int)uModel.meshEdgesIndex.size();
    
    file.write((char*)&meshEdgesSize,sizeof(int));
    
    file.write((char*)&uModel.meshEdgesIndex[0],meshEdgesSize*sizeof(int));
    
    //WRITE MESH FACES INDEX
    int meshFaceSize=(int)uModel.meshFacesIndex.size();
    
    file.write((char*)&meshFaceSize,sizeof(int));
    
    file.write((char*)&uModel.meshFacesIndex[0],meshFaceSize*sizeof(int));

    //WRITE ARMATURE
    //WRITE NUMBER OF BONES
    int numberOfBonesSize=(int)uModel.armature.numberOfBones;
    file.write((char*)&numberOfBonesSize,sizeof(int));
    file.write((char*)&uModel.armature.numberOfBones,sizeof(numberOfBonesSize));
    
    if (numberOfBonesSize>0) {
        
        //WRITE BIND SHAPE MATRIX
        
        int bindShapeMatrixSize=(int)uModel.armature.bindShapeMatrix.size();
        
        file.write((char*)&bindShapeMatrixSize,sizeof(int));
        
        file.write((char*)&uModel.armature.bindShapeMatrix[0],bindShapeMatrixSize*sizeof(float));
        
        //WRITE BONES
        for(auto n:uModel.armature.bones){
        
            //write name
            //get the size of the string
            size_t boneNameLen=n.name.size();
            file.write((char*)&boneNameLen,sizeof(boneNameLen));
            file.write((char*)&n.name[0],boneNameLen);
            
            //write parent
            size_t boneParentNameLen=n.parent.size();
            file.write((char*)&boneParentNameLen,sizeof(boneParentNameLen));
            file.write((char*)&n.parent[0],boneParentNameLen);
            
            //write local matrix
            int boneLocalMatrixSize=(int)n.localMatrix.size();
            
            file.write((char*)&boneLocalMatrixSize,sizeof(int));
            
            file.write((char*)&n.localMatrix[0],boneLocalMatrixSize*sizeof(float));
            
            //write bind pose matrix
            int boneBindPoseMatrixSize=(int)n.bindPoseMatrix.size();
            
            file.write((char*)&boneBindPoseMatrixSize,sizeof(int));
            
            file.write((char*)&n.bindPoseMatrix[0],boneBindPoseMatrixSize*sizeof(float));
            
            //write inverse pose matrix
            int boneInversePoseMatrixSize=(int)n.inversePoseMatrix.size();
            
            file.write((char*)&boneInversePoseMatrixSize,sizeof(int));
            
            file.write((char*)&n.inversePoseMatrix[0],boneInversePoseMatrixSize*sizeof(float));
            
            //write rest pose matrix
            int boneRestPoseMatrixSize=(int)n.restPoseMatrix.size();
            
            file.write((char*)&boneRestPoseMatrixSize,sizeof(int));
            
            file.write((char*)&n.restPoseMatrix[0],boneRestPoseMatrixSize*sizeof(float));
            
            //write vertex weights
            int boneVertexWeightsSize=(int)n.vertexWeights.size();
            
            file.write((char*)&boneVertexWeightsSize,sizeof(int));
            
            file.write((char*)&n.vertexWeights[0],boneVertexWeightsSize*sizeof(float));
            
        }
    }
}

void MeshDataConverter::readMeshDataFile(std::ifstream &file, MODEL &uModel){
    
    //READ NAME
    size_t modelNamelen=0;
    file.read((char*)&modelNamelen,sizeof(modelNamelen));
    uModel.name.resize(modelNamelen);
    file.read((char*)&uModel.name[0],modelNamelen);
    
    //READ VERTICES
    int verticesSize=0;
    file.read((char*)&verticesSize,sizeof(int));
    std::vector<float> tempVertices(verticesSize,0);
    
    //copy temp to model2
    uModel.vertices=tempVertices;
    file.read((char*)&uModel.vertices[0], verticesSize*sizeof(float));
    
    //READ NORMALS
    int normalsSize=0;
    file.read((char*)&normalsSize,sizeof(int));
    std::vector<float> tempNormals(normalsSize,0);
    
    //copy temp to model2
    uModel.normals=tempNormals;
    file.read((char*)&uModel.normals[0], normalsSize*sizeof(float));

    //READ UVs
    int uvSize=0;
    file.read((char*)&uvSize,sizeof(int));
    std::vector<float> tempUV(uvSize,0);
    
    //copy temp to model2
    uModel.uv=tempUV;
    file.read((char*)&uModel.uv[0], uvSize*sizeof(float));
    
    //READ INDEX
    int indexSize=0;
    file.read((char*)&indexSize,sizeof(int));
    std::vector<int> tempIndex(indexSize,0);
    
    //copy temp to model2
    uModel.index=tempIndex;
    file.read((char*)&uModel.index[0], indexSize*sizeof(int));
    
    //READ CONVEX HULL VERTICES
    int convexHullVerticesSize=0;
    file.read((char*)&convexHullVerticesSize,sizeof(int));
    std::vector<float> tempConvexHullVertices(convexHullVerticesSize,0);
    
    //copy temp to model2
    uModel.convexHullVertices=tempConvexHullVertices;
    file.read((char*)&uModel.convexHullVertices[0], convexHullVerticesSize*sizeof(float));
    
    //READ CONVEX HULL EDGES
    int convexHullEdgesSize=0;
    file.read((char*)&convexHullEdgesSize,sizeof(int));
    std::vector<float> tempConvexHullEdges(convexHullEdgesSize,0);
    
    //copy temp to model2
    uModel.convexHullEdges=tempConvexHullEdges;
    file.read((char*)&uModel.convexHullEdges[0], convexHullEdgesSize*sizeof(float));
    
    //READ CONVEX HULL FACES
    int convexHullFacesSize=0;
    file.read((char*)&convexHullFacesSize,sizeof(int));
    std::vector<float> tempConvexHullFaces(convexHullFacesSize,0);
    
    //copy temp to model2
    uModel.convexHullFaces=tempConvexHullFaces;
    file.read((char*)&uModel.convexHullFaces[0], convexHullFacesSize*sizeof(float));
    
    //READ MATERIAL INDEX
    int materialIndexSize=0;
    file.read((char*)&materialIndexSize,sizeof(int));
    std::vector<int> tempMaterialIndex(materialIndexSize,0);
    
    //copy temp to model2
    uModel.materialIndex=tempMaterialIndex;
    file.read((char*)&uModel.materialIndex[0], materialIndexSize*sizeof(int));
    
    
    //READ DIFFUSE COLOR
    int diffuseColorSize=0;
    file.read((char*)&diffuseColorSize,sizeof(int));
    std::vector<float> tempDiffuseColor(diffuseColorSize,0);
    
    //copy temp to model2
    uModel.diffuseColor=tempDiffuseColor;
    file.read((char*)&uModel.diffuseColor[0], diffuseColorSize*sizeof(float));
    
    
    //READ SPECULAR COLOR
    int specularColorSize=0;
    file.read((char*)&specularColorSize,sizeof(int));
    std::vector<float> tempSpecularColor(specularColorSize,0);
    
    //copy temp to model2
    uModel.specularColor=tempSpecularColor;
    file.read((char*)&uModel.specularColor[0], specularColorSize*sizeof(float));
    
    
    //READ DIFFUSE INTENSITY
    int diffuseIntensitySize=0;
    file.read((char*)&diffuseIntensitySize,sizeof(int));
    std::vector<float> tempDiffuseIntensity(diffuseIntensitySize,0);
    
    //copy temp to model2
    uModel.diffuseIntensity=tempDiffuseIntensity;
    file.read((char*)&uModel.diffuseIntensity[0], diffuseIntensitySize*sizeof(float));
    
    
    //READ SPECULAR INTENSITY
    int specularIntensitySize=0;
    file.read((char*)&specularIntensitySize,sizeof(int));
    std::vector<float> tempSpecularIntensity(specularIntensitySize,0);
    
    //copy temp to model2
    uModel.specularIntensity=tempSpecularIntensity;
    file.read((char*)&uModel.specularIntensity[0], specularIntensitySize*sizeof(float));
    
    
    //READ SPECULAR HARDNESS
    int specularHardnessSize=0;
    file.read((char*)&specularHardnessSize,sizeof(int));
    std::vector<float> tempSpecularHardness(specularHardnessSize,0);
    
    //copy temp to model2
    uModel.specularHardness=tempSpecularHardness;
    file.read((char*)&uModel.specularHardness[0], specularHardnessSize*sizeof(float));
    
    
    //READ TEXTURE IMAGE
    size_t textureNamelen=0;
    file.read((char*)&textureNamelen,sizeof(textureNamelen));
    uModel.textureImage.resize(textureNamelen);
    file.read((char*)&uModel.textureImage[0],textureNamelen);
    
    //READ LOCAL MATRIX
    int localMatrixSize=0;
    file.read((char*)&localMatrixSize,sizeof(int));
    std::vector<float> tempLocalMatrix(localMatrixSize,0);
    
    //copy temp to model2
    uModel.localMatrix=tempLocalMatrix;
    file.read((char*)&uModel.localMatrix[0], localMatrixSize*sizeof(float));
    
    
    //READ DIMENSION
    int dimensionSize=0;
    file.read((char*)&dimensionSize,sizeof(int));
    std::vector<float> tempDimension(dimensionSize,0);
    
    //copy temp to model2
    uModel.dimension=tempDimension;
    file.read((char*)&uModel.dimension[0], dimensionSize*sizeof(float));
    
    
    //READ MESH VERTICES
    int meshVerticesSize=0;
    file.read((char*)&meshVerticesSize,sizeof(int));
    std::vector<float> tempMeshVertices(meshVerticesSize,0);
    
    //copy temp to model2
    uModel.meshVertices=tempMeshVertices;
    file.read((char*)&uModel.meshVertices[0], meshVerticesSize*sizeof(float));
    
    //READ MESH EDGES INDEX
    int meshEdgesIndexSize=0;
    file.read((char*)&meshEdgesIndexSize,sizeof(int));
    std::vector<int> tempMeshEdges(meshEdgesIndexSize,0);
    
    //copy temp to model2
    uModel.meshEdgesIndex=tempMeshEdges;
    file.read((char*)&uModel.meshEdgesIndex[0], meshEdgesIndexSize*sizeof(int));
    
    //READ MESH FACES INDEX
    int meshFacesIndexSize=0;
    file.read((char*)&meshFacesIndexSize,sizeof(int));
    std::vector<int> tempMeshFaceIndex(meshFacesIndexSize,0);
    
    //copy temp to model2
    uModel.meshFacesIndex=tempMeshFaceIndex;
    file.read((char*)&uModel.meshFacesIndex[0], meshFacesIndexSize*sizeof(int));
    
    //READ ARMATURE
    //READ NUMBER OF BONES
    int numberOfBonesSize=0;
    file.read((char*)&numberOfBonesSize,sizeof(int));
    file.read((char*)&uModel.armature.numberOfBones, sizeof(numberOfBonesSize));
    
    if(numberOfBonesSize>0){
        
        //READ BIND SHAPE MATRIX
        int bindShapeMatrixSize=0;
        file.read((char*)&bindShapeMatrixSize,sizeof(int));
        std::vector<float> tempBindShapeMatrix(bindShapeMatrixSize,0);
        
        //copy temp to model2
        uModel.armature.bindShapeMatrix=tempBindShapeMatrix;
        file.read((char*)&uModel.armature.bindShapeMatrix[0], bindShapeMatrixSize*sizeof(float));
        
        //READ BONES
        
        for(int i=0;i<numberOfBonesSize;i++){
            
            BONES bones;

            //name
            size_t modelBoneNamelen=0;
            file.read((char*)&modelBoneNamelen,sizeof(modelBoneNamelen));
            bones.name.resize(modelBoneNamelen);
            file.read((char*)&bones.name[0],modelBoneNamelen);
            
            //parent
            size_t modelBoneParentNamelen=0;
            file.read((char*)&modelBoneParentNamelen,sizeof(modelBoneParentNamelen));
            bones.parent.resize(modelBoneParentNamelen);
            file.read((char*)&bones.parent[0],modelBoneParentNamelen);
            
            //local matrix
            int boneLocalMatrixSize=0;
            file.read((char*)&boneLocalMatrixSize,sizeof(int));
            std::vector<float> tempBoneLocalMatrix(boneLocalMatrixSize,0);
           
            //copy temp to model2
            bones.localMatrix=tempBoneLocalMatrix;
            file.read((char*)&bones.localMatrix[0], boneLocalMatrixSize*sizeof(float));
            
            //bind pose matrix
            int boneBindPoseMatrixSize=0;
            file.read((char*)&boneBindPoseMatrixSize,sizeof(int));
            std::vector<float> tempBoneBindPoseMatrix(boneBindPoseMatrixSize,0);

            //copy temp to model2
            bones.bindPoseMatrix=tempBoneBindPoseMatrix;
            file.read((char*)&bones.bindPoseMatrix[0], boneBindPoseMatrixSize*sizeof(float));
            
            //inverse pose matrix
            int boneInversePoseMatrixSize=0;
            file.read((char*)&boneInversePoseMatrixSize,sizeof(int));
            std::vector<float> tempBoneInversePoseMatrix(boneInversePoseMatrixSize,0);

            //copy temp to model2
            bones.inversePoseMatrix=tempBoneInversePoseMatrix;
            file.read((char*)&bones.inversePoseMatrix[0], boneInversePoseMatrixSize*sizeof(float));
            
            //rest pose matrix
            int boneRestPoseMatrixSize=0;
            file.read((char*)&boneRestPoseMatrixSize,sizeof(int));
            std::vector<float> tempBoneRestPoseMatrix(boneRestPoseMatrixSize,0);

            //copy temp to model2
            bones.restPoseMatrix=tempBoneRestPoseMatrix;
            file.read((char*)&bones.restPoseMatrix[0], boneRestPoseMatrixSize*sizeof(float));
            
            //vertex weights
            int boneVertexWeightsSize=0;
            file.read((char*)&boneVertexWeightsSize,sizeof(int));
            std::vector<float> tempBoneVertexWeights(boneVertexWeightsSize,0);

            //copy temp to model2
            bones.vertexWeights=tempBoneVertexWeights;
            file.read((char*)&bones.vertexWeights[0], boneVertexWeightsSize*sizeof(float));
            
            uModel.armature.bones.push_back(bones);
            
        }
    }
    
}

bool MeshDataConverter::writeBinaryToFile(std::string filepath){
    
    std::ofstream file(filepath, std::ios::out | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        return false;
        
    }

    //WRITE THE NUMBER OF MESHES
    int numberOfMeshesSize=(int)models.meshesCount;
    file.write((char*)&numberOfMeshesSize,sizeof(int));
    
    for(auto n:models.gameModels){
        
        writeMeshDataToFile(file, n);
        
    }
    
    file.close();
    
    return true;
}

void MeshDataConverter::readBinaryFile(std::string filepath){
    
    std::ifstream infile(filepath, std::ios::in | std::ios::binary );
    
    if(!infile){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }
    
    infile.seekg(0);
    
    //READ NUMBER OF MESHES IN SCENE
    int numberOfMeshesSize=0;
    infile.read((char*)&numberOfMeshesSize,sizeof(int));
    
    
    for(int i=0;i<numberOfMeshesSize;i++){
        
        MODEL uModel;
        
        readMeshDataFile(infile, uModel);
        
//        if(uModel.armature.bones.size()>0){
//
//            std::cout<<"number of bones: "<<uModel.armature.numberOfBones<<std::endl;
//
//
//            std::cout<<"bind shape matrix\n"<<std::endl;
//            for(auto n:uModel.armature.bindShapeMatrix){
//
//                std::cout<<n<<' ';
//
//            }
//
//            std::cout<<"bones\n"<<std::endl;
//            for(auto n:uModel.armature.bones){
//
//                std::cout<<"Name: "<<n.name<<std::endl;
//                std::cout<<"Parent: "<<n.parent<<std::endl;
//
//                std::cout<<"local matrix\n"<<std::endl;
//                for(auto m:n.localMatrix){
//
//                    std::cout<<m<<' ';
//
//                }
//
//
//                std::cout<<"bind pose matrix\n"<<std::endl;
//                for(auto m:n.bindPoseMatrix){
//
//                    std::cout<<m<<' ';
//
//                }
//
//                std::cout<<"inverse pose matrix\n"<<std::endl;
//                for(auto m:n.inversePoseMatrix){
//
//                    std::cout<<m<<' ';
//
//                }
//
//                std::cout<<"rest pose matrix\n"<<std::endl;
//                for(auto m:n.restPoseMatrix){
//
//                    std::cout<<m<<' ';
//
//                }
//
//                std::cout<<"vertex weights\n"<<std::endl;
//                for(auto m:n.vertexWeights){
//
//                    std::cout<<m<<' ';
//
//                }
//
//
//            }
//        }
        
        /*
        std::cout<<"vertices\n"<<std::endl;
        for(auto n:uModel.vertices){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"normals\n"<<std::endl;
        for(auto n:uModel.normals){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"uvs\n"<<std::endl;
        for(auto n:uModel.uv){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"index\n"<<std::endl;
        for(auto n:uModel.index){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"prehull\n"<<std::endl;
        for(auto n:uModel.prehullVertices){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"material index\n"<<std::endl;
        for(auto n:uModel.materialIndex){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"diffuse color\n"<<std::endl;
        for(auto n:uModel.diffuseColor){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"specular color\n"<<std::endl;
        for(auto n:uModel.specularColor){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"diffuse intensity\n"<<std::endl;
        for(auto n:uModel.diffuseIntensity){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"specular intensity\n"<<std::endl;
        for(auto n:uModel.specularIntensity){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"specular hardness\n"<<std::endl;
        for(auto n:uModel.specularHardness){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"Texture: "<<uModel.textureImage<<std::endl;
        
        std::cout<<"local matrix\n"<<std::endl;
        for(auto n:uModel.localMatrix){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"dimension\n"<<std::endl;
        for(auto n:uModel.dimension){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"mesh vertices\n"<<std::endl;
        for(auto n:uModel.meshVertices){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"mesh edges\n"<<std::endl;
        for(auto n:uModel.meshEdgesIndex){
            
            std::cout<<n<<' ';
            
        }
        
        std::cout<<"mesh faces\n"<<std::endl;
        for(auto n:uModel.meshFacesIndex){
            
            std::cout<<n<<' ';
            
        }
        */
    }
    
    infile.close();
    
}
