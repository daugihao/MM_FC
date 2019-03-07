#include <futurocube>

/**********************************/
#define I1   cBLUE
#define CY   0xFFD50000
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
new equation[54] = [0,0,0,0,0,0,0,0,0, 0,WHITE,0,WHITE,WHITE,WHITE,0,WHITE,0, CY,CY,CY,0,CY,CY,CY,CY,CY, CY,0,0,CY,CY,CY,CY,CY,CY, 0,CY,CY,0,CY,0,CY,CY,0, 0,CY,0,0,CY,0,0,CY,0]


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
			WaitPlayOver()
			DrawCube()
			FlashCanvas(1,3,0)
			Play("code_entry")
			WaitPlayOver()
		}
		
		while(GetTimer(0)!= 0)
		{
			if (eTapToSide())
				{
					SetTimer(0,8000)
					side = eTapSide()
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

					SayScore(answer)
					//printf("Side Tapped: %i\r\n", side)
				}
			ClearCanvas()
			
			SetColor(WHITE)
			SetIntensity(5)
			DrawSide(4)
			DrawSide(5)
			DrawSide(0)
			
			AckMotion()
			SetColor(CY)
			SetIntensity(255)
			draw_score(answer)
			PrintCanvas()
			
			Sleep(200)
			
			if (GetTimer(0) < 200)
			{
				Play("uff")
				WaitPlayOver()
				Play("incorrect_passcode")
				WaitPlayOver()
			}
			
			if (answer == solution)
			{
				PuzzleComplete()
			}
		}
	}
}   