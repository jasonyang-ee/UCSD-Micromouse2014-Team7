void PID_follower()
{
  if(distDiagonalRight > 200 && distDiagonalLeft > 200 && (distRight > 60 || distLeft > 60))
    modeFollow = followNone;
  else if(distDiagonalRight > 200 && distDiagonalLeft < 200 && (distRight > 60 || distLeft > 60))
    modeFollow = followDiagonalLeft;
  else if(distDiagonalRight < 200 && distDiagonalLeft > 200 && (distRight > 60 || distLeft > 60))
    modeFollow = followDiagonalRight;
  else if(distRight < 60 && distLeft < 60)
    modeFollow = followSide;
  
}


