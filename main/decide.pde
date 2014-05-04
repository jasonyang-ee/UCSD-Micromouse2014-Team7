void decide()
{ 
  if(priorityRight)
  {
    switch(wallCase) 
    {
      case (wallNone): //No Walls
        if ((FFF <= FFR) && (FFF <= FFL) && (FFF <= FFB))
          PIDmode = modeStraightOne;
        else if ((FFR <= FFF) && (FFR <= FFL) && (FFR <= FFB))
          PIDmode = modeTurnRight;  
        else if ((FFL <= FFF) && (FFL <= FFR) && (FFL <= FFB))
          PIDmode = modeTurnLeft;
        else
          PIDmode = modeTurnBack;
       break;
        
      case(wallFront) :  //One Wall in Front
        if ((FFR <= FFL) && (FFR <= FFB))   //turn Right, FFL is smallest
          PIDmode = modeTurnRight;
        else if ((FFL <= FFR) && (FFL <= FFB))          // otherwise turn right
          PIDmode = modeTurnLeft;
        else
          PIDmode = modeTurnBack;
       break;
        
      case(wallRight):  //One Wall on the Right 
        if ((FFF <= FFL) && (FFF <= FFB))
          PIDmode = modeStraightOne;
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
          PIDmode = modeStraightOne;
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
          PIDmode = modeStraightOne;
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
  else
  {
    switch(wallCase) 
    {
      case (wallNone): //No Walls
        if ((FFF <= FFR) && (FFF <= FFL) && (FFF <= FFB))
          PIDmode = modeStraightOne;
        else if ((FFL <= FFF) && (FFL <= FFR) && (FFL <= FFB))
          PIDmode = modeTurnLeft;  
        else if ((FFR <= FFF) && (FFR <= FFR) && (FFR <= FFB))
          PIDmode = modeTurnRight;
        else
          PIDmode = modeTurnBack;
       break;
        
      case(wallFront) :  //One Wall in Front
        if ((FFL <= FFR) && (FFL <= FFB))   //turn Right, FFL is smallest
          PIDmode = modeTurnLeft;
        else if ((FFR <= FFL) && (FFR <= FFB))          // otherwise turn right
          PIDmode = modeTurnRight;
        else
          PIDmode = modeTurnBack;
       break;
        
      case(wallRight) :  //One Wall on the Right 
        if ((FFF <= FFL) && (FFF <= FFB))
          PIDmode = modeStraightOne;
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
          PIDmode = modeStraightOne;
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
          PIDmode = modeStraightOne;
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
}
  
  
  
  
  
