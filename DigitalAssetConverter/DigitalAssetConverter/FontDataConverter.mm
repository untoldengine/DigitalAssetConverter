//
//  FontDataConverter.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 9/26/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "FontDataConverter.h"

FontDataConverter::FontDataConverter(){
    
}

FontDataConverter::~FontDataConverter(){
    
}

void FontDataConverter::parseXML(){
    
    tinyxml2::XMLNode* font = doc.FirstChildElement("font");
    
    tinyxml2::XMLElement* infoElem = font->FirstChildElement("info");
    const char* infoFontSize=infoElem->Attribute("size");
    
    tinyxml2::XMLElement* commonElem = font->FirstChildElement("common");
    const char* lineHeight=commonElem->Attribute("lineHeight");
    const char* base=commonElem->Attribute("base");
    const char* atlasWidth=commonElem->Attribute("scaleW");
    const char* atlasHeight=commonElem->Attribute("scaleH");
    
    float lineHeightValue=atof(lineHeight);
    float baseValue=atof(base);
    
    float yOffsetReScale=lineHeightValue-baseValue;
    
    fonts.fontAtlasWidth=atof(atlasWidth);
    fonts.fontAtlasHeight=atof(atlasHeight);
    

    tinyxml2::XMLElement* pagesElem = font->FirstChildElement("pages");
    tinyxml2::XMLElement* pageElem=pagesElem->FirstChildElement("page");
    
    //texture for font
    fonts.texture=pageElem->Attribute("file");
    
    //remove the extension for the filename for font
    size_t lastindex = fonts.texture.find_last_of(".");
    fonts.name = fonts.texture.substr(0, lastindex);
    
    tinyxml2::XMLElement* elem = font->FirstChildElement("chars");
    
    const char* charCount=elem->Attribute("count");
    fonts.charCount=atoi(charCount);
    
    fonts.fontSize=atoi(infoFontSize);
    
    for(tinyxml2::XMLElement* subElem = elem->FirstChildElement("char"); subElem != NULL; subElem = subElem->NextSiblingElement("char"))
    {
        
        //set up the characterData
        CHARACTERDATA ufontData;
        
        const char* ID = subElem->Attribute("id");
        ufontData.ID=atoi(ID);
        
        const char* x=subElem->Attribute("x");
        ufontData.x=atof(x);
        
        const char* y=subElem->Attribute("y");
        ufontData.y=atof(y);
        
        const char* width=subElem->Attribute("width");
        ufontData.width=atof(width);
        
        const char* height=subElem->Attribute("height");
        ufontData.height=atof(height);
        
        const char* xoffset=subElem->Attribute("xoffset");
        ufontData.xoffset=atof(xoffset);
        
        const char* yoffset=subElem->Attribute("yoffset");
        ufontData.yoffset=atof(yoffset);
        
        
        const char* xadvance=subElem->Attribute("xadvance");
        ufontData.xadvance=atof(xadvance);
        
        const char* letter=subElem->Attribute("letter");
        
        std::string letterToString(letter);
        
        if (strcmp(letter, "space") == 0) {

            ufontData.letter=std::string(" ");

        }else{


            ufontData.letter=letterToString;

            if (strcmp(letter,"y")==0||strcmp(letter,"p")==0||strcmp(letter,"g")==0||strcmp(letter,"q")==0||strcmp(letter,"j")==0) {


                ufontData.yoffset=yOffsetReScale+ufontData.yoffset;

            }
        }
        
        
        fonts.characterData.push_back(ufontData);
    }
    

}

void FontDataConverter::writeFontDataToFile(std::ofstream &file){
    
    //WRITE Font NAME
    //get the size of the string
    size_t fontNameLen=fonts.name.size();
    file.write((char*)&fontNameLen,sizeof(fontNameLen));
    file.write((char*)&fonts.name[0],fontNameLen);
    
    //font size
    int fontSize=(int)fonts.fontSize;
    file.write((char*)&fontSize,sizeof(int));
    file.write((char*)&fonts.fontSize,sizeof(fontSize));
    
    //Font ATLAS Width
    float atlasWidth=(float)fonts.fontAtlasWidth;
    file.write((char*)&atlasWidth,sizeof(float));
    file.write((char*)&fonts.fontAtlasWidth,sizeof(atlasWidth));
    
    //Font ATLAS Height
    float atlasHeight=(float)fonts.fontAtlasHeight;
    file.write((char*)&atlasHeight,sizeof(float));
    file.write((char*)&fonts.fontAtlasHeight,sizeof(atlasHeight));
    
    //texture
    //get the size of the string
    size_t textureNameLen=fonts.texture.size();
    file.write((char*)&textureNameLen,sizeof(textureNameLen));
    file.write((char*)&fonts.texture[0],textureNameLen);
    
    //WRITE NUMBER OF Characters
    int numberOfCharSize=(int)fonts.charCount;
    file.write((char*)&numberOfCharSize,sizeof(int));
    file.write((char*)&fonts.charCount,sizeof(numberOfCharSize));
    
    for (int i=0;i<numberOfCharSize;i++) {
        
        //id
        int fontIDLen=(int)fonts.characterData.at(i).ID;
        file.write((char*)&fontIDLen,sizeof(fontIDLen));
        file.write((char*)&fonts.characterData.at(i).ID,sizeof(fontIDLen));
        
        //x-position
        float fontXPosLen=(float)fonts.characterData.at(i).x;
        file.write((char*)&fontXPosLen,sizeof(fontXPosLen));
        file.write((char*)&fonts.characterData.at(i).x,sizeof(fontXPosLen));
        
        //y-position
        float fontYPosLen=(float)fonts.characterData.at(i).y;
        file.write((char*)&fontYPosLen,sizeof(fontYPosLen));
        file.write((char*)&fonts.characterData.at(i).y,sizeof(fontYPosLen));

        //width
        float fontWidthLen=(float)fonts.characterData.at(i).width;
        file.write((char*)&fontWidthLen,sizeof(fontWidthLen));
        file.write((char*)&fonts.characterData.at(i).width,sizeof(fontWidthLen));

        //height
        float fontHeightLen=(float)fonts.characterData.at(i).height;
        file.write((char*)&fontHeightLen,sizeof(fontHeightLen));
        file.write((char*)&fonts.characterData.at(i).height,sizeof(fontHeightLen));

        //x-offset
        float fontXOffsetLen=(float)fonts.characterData.at(i).xoffset;
        file.write((char*)&fontXOffsetLen,sizeof(fontXOffsetLen));
        file.write((char*)&fonts.characterData.at(i).xoffset,sizeof(fontXOffsetLen));

        //y-offset
        float fontYOffsetLen=(float)fonts.characterData.at(i).yoffset;
        file.write((char*)&fontYOffsetLen,sizeof(fontYOffsetLen));
        file.write((char*)&fonts.characterData.at(i).yoffset,sizeof(fontYOffsetLen));

        //x advance
        float fontXAdvanceLen=(float)fonts.characterData.at(i).xadvance;
        file.write((char*)&fontXAdvanceLen,sizeof(fontXAdvanceLen));
        file.write((char*)&fonts.characterData.at(i).xadvance,sizeof(fontXAdvanceLen));
        
        size_t letterLen=fonts.characterData.at(i).letter.size();
        file.write((char*)&letterLen,sizeof(letterLen));
        file.write((char*)&fonts.characterData.at(i).letter[0],letterLen);
    }
    
}

bool FontDataConverter::writeBinaryToFile(std::string filepath){
    
    std::ofstream file(filepath, std::ios::out | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        return false;
        
    }

    writeFontDataToFile(file);
       
    //std::cout<<"Font's data was converted into binary."<<std::endl;
    file.close();
    return true;
    
}

void FontDataConverter::readBinaryFile(std::string filepath){
    
    std::ifstream file(filepath, std::ios::in | std::ios::binary );
    
    if(!file){
        
        std::cerr<<"File "<<filepath<<"does not exist"<<std::endl;
        
        exit(1);
        
    }
    
    file.seekg(0);
    
    FONTDATA fonts;
    
    //READ NAME
    size_t fontNamelen=0;
    file.read((char*)&fontNamelen,sizeof(fontNamelen));
    fonts.name.resize(fontNamelen);
    file.read((char*)&fonts.name[0],fontNamelen);
    
    //font size
    int fontSize=0;
    file.read((char*)&fontSize,sizeof(int));
    file.read((char*)&fonts.fontSize, sizeof(fontSize));
    
    //Font ATLAS Width
    float atlasWidthSize=0;
    file.read((char*)&atlasWidthSize,sizeof(float));
    file.read((char*)&fonts.fontAtlasWidth, sizeof(atlasWidthSize));
    
    //Font ATLAS Height
    float atlasHeightSize=0;
    file.read((char*)&atlasHeightSize,sizeof(float));
    file.read((char*)&fonts.fontAtlasHeight, sizeof(atlasHeightSize));
    
    //texture
    //get the size of the string
     size_t fontTexturelen=0;
     file.read((char*)&fontTexturelen,sizeof(fontTexturelen));
     fonts.texture.resize(fontTexturelen);
     file.read((char*)&fonts.texture[0],fontTexturelen);
    
    //WRITE NUMBER OF Characters
    int charCountSize=0;
    file.read((char*)&charCountSize,sizeof(int));
    file.read((char*)&fonts.charCount, sizeof(charCountSize));
    
    for (int i=0; i<charCountSize; i++) {
        
        CHARACTERDATA characterData;
        
        //id int
        int idSize=0;
        file.read((char*)&idSize,sizeof(int));
        file.read((char*)&characterData.ID, sizeof(idSize));
        
        //x-position float
        float xPositionSize=0;
        file.read((char*)&xPositionSize,sizeof(float));
        file.read((char*)&characterData.x, sizeof(xPositionSize));
        
        //y-position
        float yPositionSize=0;
        file.read((char*)&yPositionSize,sizeof(float));
        file.read((char*)&characterData.y, sizeof(yPositionSize));

        //width
        float widthSize=0;
        file.read((char*)&widthSize,sizeof(float));
        file.read((char*)&characterData.width, sizeof(widthSize));

        //height
        float heightSize=0;
        file.read((char*)&heightSize,sizeof(float));
        file.read((char*)&characterData.height, sizeof(heightSize));

        //x-offset
        float xOffsetSize=0;
        file.read((char*)&xOffsetSize,sizeof(float));
        file.read((char*)&characterData.xoffset, sizeof(xOffsetSize));

        //y-offset
        float yOffsetSize=0;
        file.read((char*)&yOffsetSize,sizeof(float));
        file.read((char*)&characterData.yoffset, sizeof(yOffsetSize));

        //x advance
        float xAdvanceSize=0;
        file.read((char*)&xAdvanceSize,sizeof(float));
        file.read((char*)&characterData.xadvance, sizeof(xAdvanceSize));
        
        //letter
        size_t letterlen=0;
        file.read((char*)&letterlen,sizeof(letterlen));
        characterData.letter.resize(letterlen);
        file.read((char*)&characterData.letter[0],letterlen);
        
        fonts.characterData.push_back(characterData);
        
    }
    
}
