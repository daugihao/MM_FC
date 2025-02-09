#include <futurocube>
#include <constants>

/**********************************/
#define I1   cGREEN
#define CG   cGREEN
#define CR   cRED
#define CB   cBLUE
#define CO   0xFF1C0000
#define CW   WHITE
#define CY   0xFFD50000
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,1,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   I1,I1,I1,    //icon
                                   0,I1,0,   //icon
                                   0,I1,0,    //icon
                                   /******/
                                   ''gang1_curators'',  //app name sound (does not need to exists)
                                   ''gang1_curators_intro'']   //explanation name sound (does not need to exists)

new cursorColor = CG
new cursor = 0
new cube[54] = [0]
new solution[54] = [CO,CO,CG,CB,CY,CW,CO,CR,CW, CB,CO,CB,CW,CW,CW,CY,CY,CR, CW,CR,CY,CG,CO,CY,CB,CG,CG, CY,CB,CW,CO,CR,CR,CR,CY,CG, CR,CB,CO,CB,CG,CW,CB,CG,CR, CW,CY,CG,CR,CB,CG,CY,CO,CO]
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
	Play("passcube_solved")
	SetColor(I1)
	DrawCube()
	
	for(;;)
	{
		if (IsPlayOver())
		{
			Play("snd1")
		}
		FlashCanvas(1,3,0)
		Sleep(1000)
	}
}


main()
{
    /*********************************************************************/
    ICON(icon)  //this register icon bytefiled and compiler won't remove it
	SetVolume(VOLUME)
    /*********************************************************************/
    
    new taptype = 0, motion = 0
    new colors[] = [CG, CR, CB, CO, CW, CY]
    new cci = 0
    RegAllSideTaps()
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
					Play("bubble")
                }
            case 2: /* top - paint spot or side */
                {
                    Push(cube)
                    cube[_i(cursor)] = cursorColor
                    Play("ballhit")
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