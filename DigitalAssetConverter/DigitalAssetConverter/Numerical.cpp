//
//  Numerical.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/27/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "Numerical.hpp"

Numerical::Numerical(){
    
}

Numerical::~Numerical(){

}

bool Numerical::areEqualAbs(float uNumber1, float uNumber2, float uEpsilon){
    
    return (fabs(uNumber1-uNumber2)<=uEpsilon);
    
}


bool Numerical::areEqualRel(float uNumber1, float uNumber2, float uEpsilon){
    
    return (fabs(uNumber1-uNumber2)<=uEpsilon*std::max(fabs(uNumber1),fabs(uNumber2)));
    
}


bool Numerical::areEqual(float uNumber1, float uNumber2, float uEpsilon){
    
    return (fabs(uNumber1-uNumber2)<=uEpsilon*std::max(1.0f,std::max(fabs(uNumber1),fabs(uNumber2))));
    
}
