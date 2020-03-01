//
//  Numerical.hpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/27/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#ifndef Numerical_hpp
#define Numerical_hpp

#include <stdio.h>
#include <algorithm>
#include <cmath>

/**
 @brief The Numerical provides numerical robustness in floating point comparison and rounding errors
 */
class Numerical {
    
private:
    
public:
    
    /**
     @brief Default constructor
     */
    Numerical();
    
    /**
     @brief Default destructor
     */
    ~Numerical();
    
    /**
     @brief Method which compares if two floating value are equal using absolute comparison
     
     @param uNumber1 Floating value to compare
     @param uNumber2 Floating value to compare
     @param uEpsilon Epsilon used in comparison
     
     @return Returns true if two floating value are equal
     */
    bool areEqualAbs(float uNumber1, float uNumber2, float uEpsilon);
    
    /**
     @brief Method which compares if two floating value are equal using relative comparison
     
     @param uNumber1 Floating value to compare
     @param uNumber2 Floating value to compare
     @param uEpsilon Epsilon used in comparison
     
     @return Returns true if two floating value are equal
     */
    bool areEqualRel(float uNumber1, float uNumber2, float uEpsilon);
    
    /**
     @brief Method which compares if two floating value are equal
     
     @param uNumber1 Floating value to compare
     @param uNumber2 Floating value to compare
     @param uEpsilon Epsilon used in comparison
     
     @return Returns true if two floating value are equal
     */
    bool areEqual(float uNumber1, float uNumber2, float uEpsilon);
    
};
#endif /* Numerical_hpp */
