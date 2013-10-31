#ifndef CELL_H
#define CELL_H
#include "global.h"

class Cell{
public:
  bool wall[4];
  bool visit;
  bool goal;
  int floodValue;

  volatile Cell *cellNorth;
  volatile Cell *cellEast;
  volatile Cell *cellSouth;
  volatile Cell *cellWest;
};

//==========  Direction Code  ==========//
//            N          0
//          W   E  ==  3   1
//            S          2
//======================================//

#endif
