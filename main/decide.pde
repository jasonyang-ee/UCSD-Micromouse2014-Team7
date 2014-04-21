void decide()
{
if (distFront < 50) //if it is less than 50, then there is a wall
 FrontWall = 1;
  else FrontWall = 0;
  
if (distRight < 50)
  RightWall = 2;
   else RightWall = 0;

if (distLeft < 50)
 LeftWall = 4;
 else LeftWall = 0;

WallCase = FrontWall + RightWall + LeftWall; // this adds up the value to give us the scenario of the wall

switch(WallCase) {

  //FFL = Floodfill number on the left, FFR = Floodfill number on the Right, FFF = Floodfill number in Front
 
case (0) : //No Walls
  if ((FFL < FFR) && (FFL < FFF)) //turn left, when FFL is smallest
    motorLeft_go(-1);
    motorRight_go(1);
    
    else if (FFR <FFL && FFR < FFF)  //turn right, FFR is smallest
     motorLeft_go(1);
     motorRight_go(-1);
     
     else if (FFR==FFL && FFR < FFF)  //turn right, FFR and FFL equals and smallest, and less than FFF 
       motorLeft_go(1);
       motorRight_go(-1);
     
     else 
     motorLeft_go(1);  //otherwise go straight
     motorRight_go(1);
     break;
  
case(1) :  //One Wall in Front
  if (FFL < FFR)  //turn left, FFL is smallest
    motorLeft_go(-1);
    motorRight_go)(1);
   
  else  // otherwise turn right
    motorLeft_go(1);
    motorRigh_go(-1);
  break;
  
case(2) :  //One Wall on the Right 
  if (FFL < FFF)  
    motorLeft_go(-1);
    motorRight_go(1);
  else
    motorLeft_go(1);
    motorRight_go(1);
  break;  

case(3) :  //One wall on the Right, one in Front
  motorLeft_go(-1);
  motorRight_go(1);

break;

case(4) :  //One wall on the left
  if (FFR < FFF)
    motorLeft_go(1);
    motorRight_go(-1);
  else
    motorLeft_go(1);
    motorRight_go(1);
    break;
    
case(5) :  //One Wall the the left, one in front
  motorLeft_go(1);
  motorRight_go(-1);
  break;
  
case(6) : //One wall on the left, one on the Right 
  motorLeft_go(1);
  motorRight_go(1);
break;

//this case makes it turns 180
case(7) :  //surrounded by 3 walls
  motorLeft_go(10);
  motorRight_go(-10);
break;

}
}
