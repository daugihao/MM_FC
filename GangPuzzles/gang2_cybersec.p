#include <futurocube>

/**********************************/
#define I1   0xFFEE0000
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,2,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   I1,0,0,    //icon
                                   0,I1,I1,   //icon
                                   0,I1,I1,    //icon
                                   /******/
                                   ''gang2_cybersec'',  //app name sound (does not need to exists)
                                   ''gang2_cybersec_intro'']   //explanation name sound (does not need to exists)
		
new solution = 141
new equation[54] = [0,0,0,0,0,0,0,0,0, 0,WHITE,0,WHITE,WHITE,WHITE,0,WHITE,0, I1,I1,I1,0,I1,I1,I1,I1,I1, I1,0,0,I1,I1,I1,I1,I1,I1, 0,I1,I1,0,I1,0,I1,I1,0, 0,I1,0,0,I1,0,0,I1,0]


//this function draws up to three digit number, same as score		
draw_score(number)
{
	new h=number/100
	number%=100
	new t=number/10
	number%=10
	new o=number

	DrawDigit(27,h)
	DrawDigit(9,t)
	DrawDigit(18,o)
}

draw()
{
    ClearCanvas()
    /* draw painting */
    for (new i = 0; i < 54; i++)
    {
        SetColor(equation[i])
        DrawPoint(i)
    }
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
    /*********************************************************************/
	
	RegAllSideTaps()
	
	new side = 0
	new answer = 0
	
	for(;;)
	{
		if (eTapSideOK())
		{
			SetTimer(0,8000)
			answer = 0
		}
		ClearCanvas()
		draw()
		AckMotion()
		
		if (GetTimer(0)!=0)
		{
			SetColor(WHITE)
			Play("drip")
			DrawCube()
			FlashCanvas(1,3,0)
			WaitPlayOver()
		}
		
		while(GetTimer(0)!= 0)
		{
			if (eTapToSide())
				{
					SetTimer(0,8000)
					side = eTapSide()
					Play("drip")
					if (side == 2) // units side
					{
						answer = answer + 1
					}
					if (side == 1) // tens side
					{
						answer = answer + 10
					}
					if (side == 3) // hundreds side
					{
						answer = answer + 100
					}
					if (answer > 999)
					{
						answer = 0
					}
					//printf("Side Tapped: %i\r\n", side)
				}
			ClearCanvas()
			
			SetColor(WHITE)
			SetIntensity(5)
			DrawSide(4)
			DrawSide(5)
			DrawSide(0)
			
			AckMotion()
			SetColor(I1)
			SetIntensity(255)
			draw_score(answer)
			PrintCanvas()
			
			Sleep(200)
			
			if (GetTimer(0) < 200)
			{
				Play("uff")
				WaitPlayOver()
			}
			
			if (answer == solution)
			{
				PuzzleComplete()
			}
		}
	}
}   