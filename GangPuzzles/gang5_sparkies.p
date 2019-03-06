#include <futurocube>

/**********************************/
#define I1   0xFF00E100
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,5,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   0,I1,0,    //icon
                                   I1,I1,I1,   //icon
                                   I1,I1,I1,    //icon
                                   /******/
                                   ''gang5_sparkies'',  //app name sound (does not need to exists)
                                   ''gang5_sparkies_intro'']   //explanation name sound (does not need to exists)

new cursorColor = 0xD9150000
new cursor = 0
new cube[54] = [0]
new paint_var[]=[VAR_MAGIC1,VAR_MAGIC2,''paint_canvas'']
new history[54*10]


draw(drawc=1)
{
    ClearCanvas()
    /* draw painting */
    for (new i = 0; i < 54; i++)
    {
        SetColor(cube[i])
        DrawPoint(i)
    }
    /* draw cursor */
    SetColor(cursorColor)
    if (drawc) DrawPoint(cursor)
    /* blit */
    PrintCanvas()
}

draw_play()
{
    AckMotion()
    new j
    for (;;)
    {
       draw(0)
       AdjCanvas(-100+j)
       j+=10
       if (j>200) j=-100
       PrintCanvas()
       Sleep()
       if (IsPlayOver()) Play("snd1")
       if (Motion())
       {
         if (_is(Motion(),TAP_DOUBLE)) 
         { 
             Quiet()
             AckMotion()
             break
         }
         AckMotion()
      }
   }
}



main()
{
    /*********************************************************************/
    ICON(icon)  //this register icon bytefiled and compiler won't remove it
    /*********************************************************************/
    
    RegisterVariable(paint_var)
    new taptype = 0, motion = 0
    new colors[] = [0xD9150000, cGREEN, cBLUE, cRED, WHITE, 0x00000000, cORANGE, cMAGENTA, cPURPLE]
    new cci = 0
    RegAllSideTaps()
    RegMotion(TAP_DOUBLE)
    SetDoubleTapLength(400)
    SetIntensity(256)
    PushPopInit(history)
    
        
    if (LoadVariable(''paint_canvas'',cube)) draw_play()  
    
    for(;;)
    {
        Sleep()
        cursor=GetCursor()
        /* input handling */
        motion = Motion()
        
        if (motion)
        {
            taptype = GetTapType(cursor)
            
            switch (taptype)
            {
            case 1: /* side - switch color */
                {
                    if (motion & (1 << TAP_DOUBLE))
                    {
                      draw_play()
                    }
                    else
                    {
                      cci = (cci + 1) % sizeof(colors)
                      cursorColor = colors[cci]
                    }
                }
            case 2: /* top - paint spot or side */
                {
                    if (motion & (1 << TAP_DOUBLE))
                    {
                        new ci = _i(cursor)
                        Play("drip")
                        for (new i = (ci / 9) * 9; i <(ci / 9 + 1) * 9; i++)
                            cube[i] = cursorColor
                    } 
                    else
                    {
                        Push(cube)
                        cube[_i(cursor)] = cursorColor
                        Play("ballhit")
                    }
                }
            case 3: /* bottom - clear */
                {
                    if (motion & (1 << TAP_DOUBLE))
                    {
                        Play("soko_step1")
                        Push(cube)
                        cellset(cube)
                    }
                    else
                    {
                      if (PPReady()>=54)
                      {
                       Pop(cube)
                       Play("startapp")
                      }
                      else Play("uff")
                      
                    }
                }
            }
            StoreVariable(''paint_canvas'',cube)    //variable is stored in RAM, until system needs
                                                   //to put it into FLASH. That is the reason why
                                                   //we can write the same variable number of times   
        }
        AckMotion()
        draw()
    }
}   