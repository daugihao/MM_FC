#include <futurocube>
#include <constants>

/**********************************/
#define I1   cRED

#define CB   cBLUE
#define CG   cGREEN
#define CY   0xFFD50000
#define CO   0xFF1C0000
#define CR   cRED

#define CW   WHITE
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

new cursorColor = WHITE
new cursor = 0
new wirecount = 14
new cube[54] = [0]
new solution[54] = [CW,CW,CB,CY,CW,CW,CY,CO,CY, CY,CO,CG,CY,CW,CW,CW,CW,CB, 0,0,CW,CW,0,0,0,0,0, CW,CW,CW,CW,CY,CW,CO,CY,CW, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0]

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
	SetIntensity(30)
    if (drawc) DrawPoint(cursor)
    /* blit */
    PrintCanvas()
	SetIntensity(256)
}

SayScore(number)
{
	new h=number/100
	number%=100 // remainder when divided by 100
	new t=number/10
	new o
	if (t <= 2)
	{
		number%=20
		o=number
	}
	else
	{
		number%=10
		o=number
	}
	//printf("%i,%i,%i\r\n",h,t,o)
	
	switch (h)
	{
		case 1:
		{
			Play("100")
		}
		case 2:
		{
			Play("200")
		}
		case 3:
		{
			Play("300")
		}
		case 4:
		{
			Play("400")
		}
		case 5:
		{
			Play("500")
		}
		case 6:
		{
			Play("600")
		}
		case 7:
		{
			Play("700")
		}
		case 8:
		{
			Play("800")
		}
		case 9:
		{
			Play("900")
		}
	}
	WaitPlayOver()
	switch (t)
	{
		case 2:
		{
			Play("_s_20")
		}
		case 3:
		{
			Play("_s_30")
		}
		case 4:
		{
			Play("_s_40")
		}
		case 5:
		{
			Play("_s_50")
		}
		case 6:
		{
			Play("_s_60")
		}
		case 7:
		{
			Play("_s_70")
		}
		case 8:
		{
			Play("_s_80")
		}
		case 9:
		{
			Play("_s_90")
		}
	}
	WaitPlayOver()
	switch (o)
	{
		case 1:
		{
			Play("_s_1")
		}
		case 2:
		{
			Play("_s_2")
		}
		case 3:
		{
			Play("_s_3")
		}
		case 4:
		{
			Play("_s_4")
		}
		case 5:
		{
			Play("_s_5")
		}
		case 6:
		{
			Play("_s_6")
		}
		case 7:
		{
			Play("_s_7")
		}
		case 8:
		{
			Play("_s_8")
		}
		case 9:
		{
			Play("_s_9")
		}
		case 10:
		{
			Play("_s_10")
		}
		case 11:
		{
			Play("_s_11")
		}
		case 12:
		{
			Play("_s_12")
		}
		case 13:
		{
			Play("_s_13")
		}
		case 14:
		{
			Play("_s_14")
		}
		case 15:
		{
			Play("_s_15")
		}
		case 16:
		{
			Play("_s_16")
		}
		case 17:
		{
			Play("_s_17")
		}
		case 18:
		{
			Play("_s_18")
		}
		case 19:
		{
			Play("_s_19")
		}
	}
	WaitPlayOver()
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
	
    for(;;)
    {
		//Introduce game
		Play("sparkies_intro")
		WaitPlayOver()
		
		//Reset variables
		cube = [CB,CG,CB,CY,CR,CO,CY,CO,CY, CY,CO,CG,CY,CR,CY,CB,CG,CB, 0,0,CW,CW,0,0,0,0,0, CG,CB,CY,CR,CY,CO,CO,CY,CY, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0]
		wirecount = 14
		
		while (wirecount > 0)
		{
			cursor=_i(GetCursor())
			//printf("Cursor: %i\r\n", cursor)
			if ((cube[cursor] != 0) && (cube[cursor] != CW))
			{
				cube[cursor] = CW
				wirecount--
				printf("Count: %i\r\n", wirecount)
				draw()
				SayScore(wirecount)
				
			}
			draw()
			Sleep(100)
		}
		
		Play("sparkies_testing")
		WaitPlayOver()
		Sleep(500)
		//Checking cube against solution
		if (cube == solution)
		{
			PuzzleComplete()
		}
		else
		{
			Play("incorrect_passcode")
			WaitPlayOver()
		}
    }
}   