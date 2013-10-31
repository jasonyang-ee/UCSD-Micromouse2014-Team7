#ifndef SEARCH_H
#define SEARCH_H
#include "global.h"
#include <list>

class Search{
public:
  std::list<int> wallState;
  void stateMachine();
};

#endif
