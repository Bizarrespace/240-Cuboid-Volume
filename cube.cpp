//Author information
//  Author name: Long Vu 
//  Author email: Longvu2000@csu.fullerton.edu
//  Section number: 5

//===== Begin code area ===========================================================================================================

#include <cstdio>

extern "C" double volume();

int main() {

  printf("\nWelcome to the cuboids programmed by by Long Vu\n\n");
  double vol;
  vol = volume();
  printf("\nFunction main received this number %lf and will view it.", vol);
  printf("\nWe strive to please the customer. Enjoy your cuboids. \n\n");
  return 0;
}