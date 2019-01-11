/*
example_3_walker.p

This example shows how walk with walker by taping to sides. If tap from same
side is detected, walker continues his direction. Orientation of walker can
be optionally displayed by debug function DrawTail. If tap from bottom is detected, red color
cube is displayed. AdjustCanvas is used to demonstrate how to fade without using FlashCanvas.    

*/

#include <futurocube>

new player
new up_down

main()
{
  RegAllSideTaps()          
  player=GetCursor()
      
  for (;;)
  {
    AdjCanvas(-1)       //dimming of canvas
    
    if (Motion())       //motion detected
    {
        if (WalkerTap(player,up_down)==0)     //tap is from same or opposite side
        {
          if (up_down==1) WalkerMove(player)  //same side, move
          else                                //opposite, red cube
          { 
            SetColor(RED)
            Vibrate(200)
            DrawCube()
          }
        }
        AckMotion()
    }
    
    SetColor(WHITE)
    DrawPoint(player)
    PrintCanvas()
    Sleep()
    }
 }   
   