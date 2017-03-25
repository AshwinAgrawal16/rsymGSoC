library(inline)
library(Rcpp)
fx=cxxfunction(,plugin="Rcpp",include='#include<Rcpp.h>
               #include<bits/stdc++.h>
               
               typedef struct test {
               double A;
               double B;
                } CStruct;
               
               CStruct* C=new CStruct;
               
               void ini(void){
               C->A=0;
               C->B=0;
               }

               void set(double a,double b){
               C->A=a;
               C->B=b;
               }
               
               double getA(void){
               double outA = C->A;
               return outA;
               }
               double getB(void){
                double outB = C->B;
               return outB;
               }

               void del(void){
               
               delete C;
               }
               RCPP_MODULE(ex1){
               using namespace Rcpp;
               function("ini",&ini);
               function("set",&set);
               function("getA",&getA);
               function("getB",&getB);
               function("ini",&ini);
               function("del",&del);

               }')
Mod=Module("ex1",getDynLib(fx))
ini<-Mod$ini
f<-Mod$set
a<-Mod$getA
b<-Mod$getB
del<-Mod$del
ini()    #initialize the values
a()      #display the values
b()
f(10,20) #update the values
a()      #display the values
b() 
del()    #delete the struct
