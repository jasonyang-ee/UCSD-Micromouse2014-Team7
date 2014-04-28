void decide()
{
  wallCase = 0;

  //Checks Walls for Case  
  if(distFront < 50)  wallCase += wallFront;
  if(distRight < 80)  wallCase += wallRight;
  if(distLeft < 80)  wallCase += wallLeft;

  //FF = Flood Fill Value Left/Right/Front/Back
  
  //For Testing Only//
  FFF = 1;
  FFR = 2;
  FFL = 3;
  FFB = 4;
  
//  neighbor();
  
  switch(wallCase) 
  {
    case (wallNone): //No Walls
      if ((FFF <= FFR) && (FFF <= FFL) && (FFF <= FFB))
        PIDmode = modeStraight;
      else if ((FFR <= FFF) && (FFR <= FFL) && (FFR <= FFB))
        PIDmode = modeTurnRight;  
      else if ((FFL <= FFF) && (FFL <= FFR) && (FFL <= FFB))
        PIDmode = modeTurnLeft;
      else
        PIDmode = modeTurnBack;
     break;
      
    case(wallFront) :  //One Wall in Front
      if ((FFL <= FFR) && (FFL <= FFB))   //turn left, FFL is smallest
        PIDmode = modeTurnLeft;
      else if ((FFR <= FFL) && (FFR <= FFB))          // otherwise turn right
        PIDmode = modeTurnRight;
      else
        PIDmode = modeTurnBack;
     break;
      
    case(wallRight) :  //One Wall on the Right 
      if ((FFF <= FFL) && (FFF <= FFB))
        PIDmode = modeStraight;
      else if ((FFL <= FFF) && (FFL <= FFB))
        PIDmode = modeTurnLeft;
      else
        PIDmode = modeTurnBack;
     break;  
    
    case(wallFrontRight) :  //One wall on the Right, one in Front
      if (FFL <= FFB)
        PIDmode = modeTurnLeft;
      else
        PIDmode = modeTurnBack;
     break;
    
    case(wallLeft) :  //One wall on the left
      if ((FFF <= FFR) && (FFF <= FFB))
        PIDmode = modeStraight;
      else if ((FFR <= FFF) && (FFR <= FFB))
        PIDmode = modeTurnRight;
      else
        PIDmode = modeTurnBack;
     break;
        
    case(wallFrontLeft) :  //One Wall the the left, one in front
      if (FFR <= FFB)
        PIDmode = modeTurnRight;
      else
        PIDmode = modeTurnBack;
     break;
      
    case(wallRightLeft) : //One wall on the left, one on the Right 
      if (FFF <= FFB)
        PIDmode = modeStraight;
      else
        PIDmode = modeTurnBack;
     break;
    
    //this case makes it turns 180
    case(wallAll) :  //surrounded by 3 walls
        PIDmode = modeTurnBack;
     break;
  }
  return;
}

//void neighbor ()
//{
//  switch(compass)
//  {
//    case north:
//      FFF = maze[LOC(currentX,currentY+1)].fill_order;
//      FFR = maze[LOC(currentX+1,currentY)].fill_order;
//      FFL = maze[LOC(currentX-1,currentY)].fill_order;
//      FFB = maze[LOC(currentX,currentY-1)].fill_order;
//      break;
//    case east:
//      FFF = maze[LOC(currentX+1,currentY)].fill_order;
//      FFR = maze[LOC(currentX,currentY-1)].fill_order;
//      FFL = maze[LOC(currentX,currentY+1)].fill_order;
//      FFB = maze[LOC(currentX-1,currentY)].fill_order;
//      break;
//    case west:
//      FFF = maze[LOC(currentX-1,currentY)].fill_order;
//      FFR = maze[LOC(currentX,currentY+1)].fill_order;
//      FFL = maze[LOC(currentX,currentY-1)].fill_order;
//      FFB = maze[LOC(currentX+1,currentY)].fill_order;
//      break;
//    case south:
//      FFF = maze[LOC(currentX,currentY-1)].fill_order;
//      FFR = maze[LOC(currentX-1,currentY)].fill_order;
//      FFL = maze[LOC(currentX+1,currentY)].fill_order;
//      FFB = maze[LOC(currentX,currentY+1)].fill_order;
//      break;
//  }
//}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
