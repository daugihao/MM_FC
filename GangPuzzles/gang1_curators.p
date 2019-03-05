#include <futurocube>

/**********************************/
#define I1   0x11FF0000
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,3,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   I1,I1,I1,    //icon
                                   0,I1,0,   //icon
                                   0,I1,0,    //icon
                                   /******/
                                   ''gang4_fixers'',  //app name sound (does not need to exists)
                                   ''gang4_fixers_intro'']   //explanation name sound (does not need to exists)

new cursorColor = 0xD9150000
new cursor = 0
new cube[54] = [0]
new solution[54] = [cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED, cRED]
new history[54*10] = []


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

PuzzleComplete()
{
	Play("snd1")
	SetColor(I1)
	DrawCube()
	
	for(;;)
	{
	}
}


main()
{
    /*********************************************************************/
    ICON(icon)  //this register icon bytefiled and compiler won't remove it
    /*********************************************************************/
    
    new taptype = 0, motion = 0
    new colors[] = [cRED, cGREEN, cBLUE, WHITE, cORANGE, cPURPLE]
    new cci = 0
    RegAllSideTaps()
    RegMotion(TAP_DOUBLE)
    SetDoubleTapLength(400)
    SetIntensity(256)
    PushPopInit(history)
    
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
                    cci = (cci + 1) % sizeof(colors)
                    cursorColor = colors[cci]
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
        }
        AckMotion()
        draw()
		
		if (cube == solution)
		{
			PuzzleComplete()
		}
    }
}   