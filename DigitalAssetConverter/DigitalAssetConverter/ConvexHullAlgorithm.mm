//
//  ConvexHullAlgorithm.cpp
//  DigitalAssetConverter
//
//  Created by Harold Serrano on 2/27/20.
//  Copyright © 2020 Untold Engine Studios. All rights reserved.
//

#include "ConvexHullAlgorithm.h"
#include <stdlib.h>
#include "Numerical.h"
#include "Constants.h"

ConvexHullAlgorithm::ConvexHullAlgorithm(){
    vertexHead=NULL;
    edgeHead=NULL;
    faceHead=NULL;
}

ConvexHullAlgorithm::~ConvexHullAlgorithm(){
    
}

void ConvexHullAlgorithm::computeConvexHull(std::vector<float> &uVertices, std::vector<float> &uConvexHullVertices, std::vector<float> &uConvexHullEdges, std::vector<float> &uConvexHullFaces){
    
    readVertices(uVertices);
    
    if(doubleTriangle()){
        
        if(constructHull()){
            
            //Do check on final data
            if(checkIfConvexHullIsValid()){
                
                //load vertices
                loadComputedCHVertices(uConvexHullVertices);
                //load edges
                loadComputedCHEdges(uConvexHullEdges);
                //load faces
                loadComputedCHFaces(uConvexHullFaces);
                
            }
        }else{
            
        }
        
    }
    
}

void ConvexHullAlgorithm::readVertices(std::vector<float> &uVertices){
    
    CONVEXHULLVERTEX preConvexHullVertex = nullptr;
    int vNum=0;
    
    for (int i=0; i<uVertices.size(); ) {
        
        preConvexHullVertex=makeNullVertex();
        preConvexHullVertex->v[0]=uVertices.at(i);
        preConvexHullVertex->v[1]=uVertices.at(i+1);
        preConvexHullVertex->v[2]=uVertices.at(i+2);
        
        preConvexHullVertex->vNum=vNum++;
        
        i=i+3;
        
    }
    
}

CONVEXHULLVERTEX ConvexHullAlgorithm::makeNullVertex(){
    
    //create vertex
    CONVEXVERTEX *uVertex=(CONVEXVERTEX*)malloc(sizeof(CONVEXVERTEX));
    uVertex->duplicate=NULL;
    uVertex->onHull=false;
    uVertex->processed=false;
    
    //add vertex
    if (vertexHead) {
        uVertex->next=vertexHead;
        uVertex->prev=vertexHead->prev;
        vertexHead->prev=uVertex;
        uVertex->prev->next=uVertex;
        
    }else{
        vertexHead=uVertex;
        vertexHead->next=vertexHead->prev=uVertex;
    }
    
    return uVertex;
}

CONVEXHULLEDGE ConvexHullAlgorithm::makeNullEdge(){
    
    //create edge
    CONVEXEDGE *uEdge=(CONVEXEDGE*)malloc(sizeof(CONVEXEDGE));
    uEdge->adjFace[0]=uEdge->adjFace[1]=uEdge->newFace=NULL;
    uEdge->endPts[0]=uEdge->endPts[1]=NULL;
    uEdge->shouldDelete=false;
    
    //add edge
    if (edgeHead) {
        uEdge->next=edgeHead;
        uEdge->prev=edgeHead->prev;
        edgeHead->prev=uEdge;
        uEdge->prev->next=uEdge;
        
    }else{
        edgeHead=uEdge;
        edgeHead->next=edgeHead->prev=uEdge;
    }
    
    return uEdge;
}

CONVEXHULLFACE ConvexHullAlgorithm::makeNullFace(){
    
    //create face
    CONVEXFACE *uFace=(CONVEXFACE*)malloc(sizeof(CONVEXFACE));
    
    for (int i=0; i<3; i++) {
        
        uFace->edge[i]=NULL;
        uFace->vertex[i]=NULL;
        
    }
    
    uFace->visible=false;
    
    //add face
    if (faceHead) {
        uFace->next=faceHead;
        uFace->prev=faceHead->prev;
        faceHead->prev=uFace;
        uFace->prev->next=uFace;
        
    }else{
        faceHead=uFace;
        faceHead->next=faceHead->prev=uFace;
    }
    
    return uFace;
}

bool ConvexHullAlgorithm::doubleTriangle(){
    
    CONVEXHULLVERTEX  v0, v1, v2, v3;
    CONVEXHULLFACE    f0, f1 = NULL;
    
    double vol=0.0;
    
    /* Find 3 noncollinear points. */
    v0 = vertexHead;
    while (collinear( v0, v0->next, v0->next->next)){
        if ((v0 = v0->next) == vertexHead){
            printf("Error computing Convex Hull: All points in input data are Collinear.");
            return false;
        }
    }
    v1 = v0->next;
    v2 = v1->next;
    
    /* Mark the vertices as processed. */
    v0->processed = true;
    v1->processed = true;
    v2->processed = true;
    
    /* Create the two "twin" faces. */
    f0 = makeFace( v0, v1, v2, f1 );
    f1 = makeFace( v2, v1, v0, f0 );
    
    /* Link adjacent face fields. */
    f0->edge[0]->adjFace[1] = f1;
    f0->edge[1]->adjFace[1] = f1;
    f0->edge[2]->adjFace[1] = f1;
    f1->edge[0]->adjFace[1] = f0;
    f1->edge[1]->adjFace[1] = f0;
    f1->edge[2]->adjFace[1] = f0;
    
    /* Find a fourth, noncoplanar point to form tetrahedron. */
    v3 = v2->next;
    vol = volumeSign( f0, v3 );
    while ( !vol )   {
        if ( ( v3 = v3->next ) == v0 ){
            printf("Error computing Convex Hull: All points in input data are coplanar.");
            return false;
        }
        vol = volumeSign( f0, v3 );
    }
    
    /* Insure that v3 will be the first added. */
    vertexHead = v3;
    
    return true;
}

bool ConvexHullAlgorithm::collinear(CONVEXHULLVERTEX a, CONVEXHULLVERTEX b, CONVEXHULLVERTEX c){
    
    Numerical comparison;
    
    bool isCollinear=false;
    
    isCollinear=(comparison.areEqual((c->v[2] - a->v[2]) * (b->v[1] - a->v[1]) -
                                    (b->v[2] - a->v[2]) * (c->v[1] - a->v[1]), 0.0, zeroEpsilon) && comparison.areEqual((b->v[2] - a->v[2] ) * (c->v[0] - a->v[0]) -(b->v[0] - a->v[0]) * (c->v[2] - a->v[2]), 0.0, zeroEpsilon)&& comparison.areEqual((c->v[1] - a->v[1])-(b->v[1] - a->v[1]) * (c->v[0] - a->v[0] ), 0.0, zeroEpsilon));
    
    return isCollinear;
    
}

CONVEXHULLFACE ConvexHullAlgorithm::makeFace(CONVEXHULLVERTEX v0, CONVEXHULLVERTEX v1, CONVEXHULLVERTEX v2, CONVEXHULLFACE fold){
    
    CONVEXHULLFACE f;
    CONVEXHULLEDGE e0,e1,e2;
    
    //create edges of the initial triangle
    if (!fold) {
        e0=makeNullEdge();
        e1=makeNullEdge();
        e2=makeNullEdge();
    }else{ //copy from fold in reverse order
        e0=fold->edge[2];
        e1=fold->edge[1];
        e2=fold->edge[0];
    }
    
    e0->endPts[0]=v0;
    e0->endPts[1]=v1;
    
    e1->endPts[0]=v1;
    e1->endPts[1]=v2;
    
    e2->endPts[0]=v2;
    e2->endPts[1]=v0;
    
    
    //create face for triangle
    f=makeNullFace();
    f->edge[0]=e0;
    f->edge[1]=e1;
    f->edge[2]=e2;
    
    f->vertex[0]=v0;
    f->vertex[1]=v1;
    f->vertex[2]=v2;
    
    //Link edges to face
    e0->adjFace[0]=e1->adjFace[0]=e2->adjFace[0]=f;
    
    return f;
    
}

bool ConvexHullAlgorithm::constructHull(){
    
    CONVEXHULLVERTEX v,vnext;
   
    v=vertexHead;
    
    do{
        vnext=v->next;
        if (!v->processed) {
            v->processed=true;
            addOne(v);
            cleanUp(&vnext);
            //perform test on each iteration
            if(!checkIfConvexHullIsValid()){
                return false;
            }
        }
        v=vnext;
    }while (v!=vertexHead);
    
    return true;
}

double ConvexHullAlgorithm::volumeSign(CONVEXHULLFACE f, CONVEXHULLVERTEX p){
    
    double  vol;
    double  ax, ay, az, bx, by, bz, cx, cy, cz;
    
    ax = f->vertex[0]->v[0] - p->v[0];
    ay = f->vertex[0]->v[1] - p->v[1];
    az = f->vertex[0]->v[2] - p->v[2];
    bx = f->vertex[1]->v[0] - p->v[0];
    by = f->vertex[1]->v[1] - p->v[1];
    bz = f->vertex[1]->v[2] - p->v[2];
    cx = f->vertex[2]->v[0] - p->v[0];
    cy = f->vertex[2]->v[1] - p->v[1];
    cz = f->vertex[2]->v[2] - p->v[2];
    
    vol =   ax * (by*cz - bz*cy)
    + ay * (bz*cx - bx*cz)
    + az * (bx*cy - by*cx);
    
    /* The volume should be an integer. */
    /*
    if      ( vol >  0.5 )  return  1;
    else if ( vol < -0.5 )  return -1;
    else                    return  0;
     */
    
    return vol;
}

bool ConvexHullAlgorithm::addOne(CONVEXHULLVERTEX p){
    CONVEXHULLFACE  f;
    CONVEXHULLEDGE  e, temp;
    double       vol;
    bool      vis = false;
    
    /* Mark faces visible from p. */
    f = faceHead;
    
    do {
        vol = volumeSign( f, p );
        if ( vol < 0 ) {
            f->visible = true;
            vis = true;
        }
        f = f->next;
    } while ( f != faceHead );
    
    /* If no faces are visible from p, then p is inside the hull. */
    if ( !vis ) {
        p->onHull = false;
        return false;
    }
    
    /* Mark edges in interior of visible region for deletion.
     Erect a newface based on each border edge. */
    e = edgeHead;
    do {
        temp = e->next;
        if ( e->adjFace[0]->visible && e->adjFace[1]->visible ){
        /* e interior: mark for deletion. */
            e->shouldDelete = true;
        }else if ( e->adjFace[0]->visible || e->adjFace[1]->visible ){
    
        /* e border: make a new face. */
            e->newFace = makeConeFace( e, p );
        }
        e = temp;

    } while ( e != edgeHead );

    return true;

}

CONVEXHULLFACE ConvexHullAlgorithm::makeConeFace(CONVEXHULLEDGE e, CONVEXHULLVERTEX p){
    
    CONVEXHULLEDGE  new_edge[2];
    CONVEXHULLFACE  new_face;
    
    int       i, j;
    
    /* Make two new edges (if don't already exist). */
    for ( i=0; i < 2; ++i ){
        
    /* If the edge exists, copy it into new_edge. */
        if ( !( new_edge[i] = e->endPts[i]->duplicate) ) {
            
            /* Otherwise (duplicate is NULL), MakeNullEdge. */
            new_edge[i] = makeNullEdge();
            new_edge[i]->endPts[0] = e->endPts[i];
            new_edge[i]->endPts[1] = p;
            e->endPts[i]->duplicate = new_edge[i];
            
        }
    
    }
    /* Make the new face. */
    new_face = makeNullFace();
    new_face->edge[0] = e;
    new_face->edge[1] = new_edge[0];
    new_face->edge[2] = new_edge[1];
    makeCcw( new_face, e, p );
    
    /* Set the adjacent face pointers. */
    for ( i=0; i < 2; ++i )
        for ( j=0; j < 2; ++j )
        /* Only one NULL link should be set to new_face. */
            if ( !new_edge[i]->adjFace[j] ) {
                new_edge[i]->adjFace[j] = new_face;
                break;
            }
    
    return new_face;
}

void ConvexHullAlgorithm::makeCcw(CONVEXHULLFACE f,CONVEXHULLEDGE e,CONVEXHULLVERTEX p)
{
    CONVEXHULLFACE  fv;   /* The visible face adjacent to e */
    int    i;    /* Index of e->endpoint[0] in fv. */
    CONVEXHULLEDGE  s=nullptr;    /* Temporary, for swapping */
    
    if  ( e->adjFace[0]->visible )
        fv = e->adjFace[0];
    else fv = e->adjFace[1];
    
    /* Set vertex[0] & [1] of f to have the same orientation
     as do the corresponding vertices of fv. */
    for ( i=0; fv->vertex[i] != e->endPts[0]; ++i )
        ;
    /* Orient f the same as fv. */
    if ( fv->vertex[ (i+1) % 3 ] != e->endPts[1] ) {
        f->vertex[0] = e->endPts[1];
        f->vertex[1] = e->endPts[0];
    }
    else {
        f->vertex[0] = e->endPts[0];
        f->vertex[1] = e->endPts[1];
        swapEdges( s, f->edge[1], f->edge[2] );
    }
    /* This swap is tricky. e is edge[0]. edge[1] is based on endpt[0],
     edge[2] on endpt[1].  So if e is oriented "forwards," we
     need to move edge[1] to follow [0], because it precedes. */
    
    f->vertex[2] = p;
}

void ConvexHullAlgorithm::swapEdges(CONVEXHULLEDGE t, CONVEXHULLEDGE x, CONVEXHULLEDGE y){
    t=x;
    x=y;
    y=t;
}

void ConvexHullAlgorithm::cleanUp(CONVEXHULLVERTEX *pvnext){
    
    cleanEdges();
    cleanFaces();
    cleanVertices(pvnext);
}

void ConvexHullAlgorithm::cleanEdges(){
    
    CONVEXHULLEDGE   e;    /* Primary index into edge list. */
    CONVEXHULLEDGE  t;    /* Temporary edge pointer. */
    
    /* Integrate the newface's into the data structure. */
    /* Check every edge. */
    e = edgeHead;
    do {
        if ( e->newFace ) {
            if ( e->adjFace[0]->visible )
                e->adjFace[0] = e->newFace;
            else    e->adjFace[1] = e->newFace;
            e->newFace = NULL;
        }
        e = e->next;
    } while ( e != edgeHead );
    
    /* Delete any edges marked for deletion. */
    while ( edgeHead && edgeHead->shouldDelete ) {
        e = edgeHead;
        deleteEdge(e);
        
    }
    e = edgeHead->next;
    do {
        if ( e->shouldDelete ) {
            t = e;
            e = e->next;
            deleteEdge(t);
        }
        else e = e->next;
    } while ( e != edgeHead );
    
}

void ConvexHullAlgorithm::cleanFaces(){
    
    CONVEXHULLFACE f;    /* Primary pointer into face list. */
    CONVEXHULLFACE t;    /* Temporary pointer, for deleting. */
    
    while ( faceHead && faceHead->visible ) {
        f = faceHead;
        deleteFace(f);
    }
    f = faceHead->next;
    do {
        if ( f->visible ) {
            t = f;
            f = f->next;
            deleteFace(t);
        }
        else f = f->next;
    } while ( f != faceHead );
    
}

void ConvexHullAlgorithm::cleanVertices(CONVEXHULLVERTEX *pvnext){
    
    CONVEXHULLEDGE e;
    CONVEXHULLVERTEX v, t;
    
    /* Mark all vertices incident to some undeleted edge as on the hull. */
    e = edgeHead;
    do {
        e->endPts[0]->onHull = e->endPts[1]->onHull = true;
        e = e->next;
    } while (e != edgeHead);
    
    /* Delete all vertices that have been processed but
     are not on the hull. */
    while ( vertexHead && vertexHead->processed && !vertexHead->onHull ) {
        /* If about to delete vnext, advance it first. */
        v = vertexHead;
        if( v == *pvnext )
            *pvnext = v->next;
        deleteVertex(v);
    }
    v = vertexHead->next;
    do {
        if ( v->processed && !v->onHull ) {
            t = v;
            v = v->next;
            if( t == *pvnext )
                *pvnext = t->next;
            deleteVertex(t);
        }
        else v = v->next;
    } while ( v != vertexHead );
    
    /* Reset flags. */
    v = vertexHead;
    do {
        v->duplicate = NULL;
        v->onHull = false;
        v = v->next;
    } while ( v != vertexHead );
    
}

void ConvexHullAlgorithm::deleteEdge(CONVEXHULLEDGE p){
    
    if (edgeHead) {
        
        if (edgeHead==edgeHead->next) {
            edgeHead=NULL;
        }else if (p==edgeHead){
            edgeHead=edgeHead->next;
        }
        
        p->next->prev=p->prev;
        p->prev->next=p->next;
        
        free((char*) p);
        p=NULL;
    }
    
}

void ConvexHullAlgorithm::deleteFace(CONVEXHULLFACE p){
    
    if (faceHead) {
        
        if (faceHead==faceHead->next) {
            faceHead=NULL;
        }else if (p==faceHead){
            faceHead=faceHead->next;
        }
        
        p->next->prev=p->prev;
        p->prev->next=p->next;
        
        free((char*) p);
        p=NULL;
    }
}

void ConvexHullAlgorithm::deleteVertex(CONVEXHULLVERTEX p){
    
    if (vertexHead) {
        
        if (vertexHead==vertexHead->next) {
            vertexHead=NULL;
        }else if (p==vertexHead){
            vertexHead=vertexHead->next;
        }
        
        p->next->prev=p->prev;
        p->prev->next=p->next;
        
        free((char*) p);
        p=NULL;
    }
    
}

bool ConvexHullAlgorithm::checkIfConvexHullIsValid(){
    
    return (checkIfConsistencyPassed()&&checkIfConvexityPassed()&&checkIfEulerFormulaPassed());
}

bool ConvexHullAlgorithm::checkIfConsistencyPassed(){
    
    CONVEXHULLEDGE e;
    int i, j;
    
    Numerical comparison;
    
    
    e = edgeHead;
    
    do {
        /* find index of endpoint[0] in adjacent face[0] */
        for ( i = 0; e->adjFace[0]->vertex[i] != e->endPts[0]; ++i )
            ;
        
        /* find index of endpoint[0] in adjacent face[1] */
        for ( j = 0; e->adjFace[1]->vertex[j] != e->endPts[0]; ++j )
            ;
        
        /* check if the endpoints occur in opposite order */
        if ( !( e->adjFace[0]->vertex[ (i+1) % 3 ] ==
               e->adjFace[1]->vertex[ (j+2) % 3 ] ||
               e->adjFace[0]->vertex[ (i+2) % 3 ] ==
               e->adjFace[1]->vertex[ (j+1) % 3 ] )  )
            break;
        e = e->next;
        
    } while ( e != edgeHead );
    
    if ( e != edgeHead ){
        
        printf("Error computing Convex Hull: Convex Hull Consistency Edges test failed.");
        return false;
    }
    
    return true;
}

bool ConvexHullAlgorithm::checkIfConvexityPassed(){
    
    CONVEXHULLFACE    f;
    CONVEXHULLVERTEX  v;
    double               vol;
    
    
    f = faceHead;
    
    do {
        v = vertexHead;
        do {
            if ( v->processed ) {
                vol = volumeSign( f, v );
                if ( vol < 0 )
                    break;
            }
            v = v->next;
        } while ( v != vertexHead );
        
        f = f->next;
        
    } while ( f != faceHead);
    
    if ( f != faceHead){
        
        printf("Error computing Convex Hull: Convex Hull Convexity Test failed.");
        return false;

    }
    
    return true;
}

bool ConvexHullAlgorithm::checkIfEulerFormulaPassed(){
    
    CONVEXHULLVERTEX  v=vertexHead;
    CONVEXHULLEDGE    e=edgeHead;
    CONVEXHULLFACE    f=faceHead;
    
    int V = 0, E = 0 , F = 0;
    
    //count all vertices, edges and faces
    if ( (v = vertexHead) )
        do {
            if (v->processed) V++;
            v = v->next;
        } while ( v != vertexHead);
    if ( (e = edgeHead))
        do {
            E++;
            e = e->next;
        } while ( e != edgeHead);
    if ( (f = faceHead))
        do {
            F++;
            f  = f ->next;
        } while ( f  != faceHead);
    
    
    //check euler's equation of polygon
    if ( (V - E + F) != 2 ){
        printf("Error computing Convex Hull: Convex Hull failed to pass Euler's Formula test: V-E+F != 2 .");
        return false;
    }
    
    if ( F != (2 * V - 4) ){
        
        printf("Error computing Convex Hull: Convex Hull failed to pass Euler's Formula test: F=%d != 2V-4=%d; V=%d .",
                    F, 2*V-4, V);
        
        return false;
        
    }
    
    if ( (2 * E) != (3 * F)){
        printf("Error computing Convex Hull: Convex Hull failed to pass Euler's Formula test: 2E=%d != 3F=%d; E=%d, F=%d .",
                    2*E, 3*F, E, F);
        
        return false;
    }
    
    return true;
}

void ConvexHullAlgorithm::loadComputedCHVertices(std::vector<float> &uConvexHullVertices){
    
    CONVEXHULLVERTEX temp;
    
    temp = vertexHead;
    
    if (vertexHead) do {
        
        uConvexHullVertices.push_back(vertexHead->v[0]);
        uConvexHullVertices.push_back(vertexHead->v[1]);
        uConvexHullVertices.push_back(vertexHead->v[2]);
        
        vertexHead = vertexHead->next;
        
    } while ( vertexHead != temp );
    
}

void ConvexHullAlgorithm::loadComputedCHEdges(std::vector<float> &uConvexHullEdges){
    
    CONVEXHULLEDGE temp;
    
    temp = edgeHead;
    
    if (edgeHead) do {
        
        //PointA
        uConvexHullEdges.push_back(edgeHead->endPts[0]->v[0]);
        uConvexHullEdges.push_back(edgeHead->endPts[0]->v[1]);
        uConvexHullEdges.push_back(edgeHead->endPts[0]->v[2]);
        
        //PointB
        uConvexHullEdges.push_back(edgeHead->endPts[1]->v[0]);
        uConvexHullEdges.push_back(edgeHead->endPts[1]->v[1]);
        uConvexHullEdges.push_back(edgeHead->endPts[1]->v[2]);
        
        edgeHead = edgeHead->next;
        
    } while (edgeHead != temp );
    
}

void ConvexHullAlgorithm::loadComputedCHFaces(std::vector<float> &uConvexHullFaces){
    
    CONVEXHULLFACE  temp;
    
    temp = faceHead;
    
    if (faceHead) do {
                
        //PointA
        uConvexHullFaces.push_back(faceHead->vertex[0]->v[0]);
        uConvexHullFaces.push_back(faceHead->vertex[0]->v[1]);
        uConvexHullFaces.push_back(faceHead->vertex[0]->v[2]);
        
        //PointB
        uConvexHullFaces.push_back(faceHead->vertex[1]->v[0]);
        uConvexHullFaces.push_back(faceHead->vertex[1]->v[1]);
        uConvexHullFaces.push_back(faceHead->vertex[1]->v[2]);
        
        //PointC
        uConvexHullFaces.push_back(faceHead->vertex[2]->v[0]);
        uConvexHullFaces.push_back(faceHead->vertex[2]->v[1]);
        uConvexHullFaces.push_back(faceHead->vertex[2]->v[2]);
        
        faceHead= faceHead->next;
        
    } while ( faceHead != temp );
    
}
