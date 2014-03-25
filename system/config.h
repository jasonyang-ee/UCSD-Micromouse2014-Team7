#ifndef CONFIG_H
#define CONFIG_H

//Compass Description
#define north 0
#define east 1
#define south 2
#define west 3

//Direction Description
#define front 0
#define right 1
#define back 2
#define left 3

//systemMode - ex: if(systemMode == debug) {}
#define debug 1
#define goTest 2
#define turnTest 3

//systemStage - ex: if(systemStage == prep) {}
#define prep 1
#define driving 2
#define breaking 3


#endif
