

void decide()
{
  wallCase = 0;

  //Checks Walls for Case  
  if(distFront < 50)  wallCase += wallFront;
  if(distRight < 50)  wallCase += wallRight;
  if(distLeft < 50)  wallCase += wallLeft;

  //FF = Flood Fill Value Left/Right/Front/Back
  
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
      
//    case(1) :  //One Wall in Front
//      if (FFL < FFR)
//      {  //turn left, FFL is smallest
//        motorLeft_go(-1);
//        motorRight_go(1);
//      }
//      else
//    {  // otherwise turn right
//        motorLeft_go(1);
//        motorRight_go(-1);
//    }
//      break;
//      
//    case(2) :  //One Wall on the Right 
//      if (FFL < FFF)  
//      {
//        motorLeft_go(-1);
//        motorRight_go(1);
//      }
//      else
//        motorLeft_go(1);
//        motorRight_go(1);
//      break;  
//    
//    case(3) :  //One wall on the Right, one in Front
//      motorLeft_go(-1);
//      motorRight_go(1);
//    
//    break;
//    
//    case(4) :  //One wall on the left
//      if (FFR < FFF)
//        motorLeft_go(1);
//        motorRight_go(-1);
//      else
//        motorLeft_go(1);
//        motorRight_go(1);
//        break;
//        
//    case(5) :  //One Wall the the left, one in front
//      motorLeft_go(1);
//      motorRight_go(-1);
//      break;
//      
//    case(6) : //One wall on the left, one on the Right 
//      motorLeft_go(1);
//      motorRight_go(1);
//    break;
//    
//    //this case makes it turns 180
//    case(7) :  //surrounded by 3 walls
//      motorLeft_go(10);
//      motorRight_go(-10);
//    break;
  }
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
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
