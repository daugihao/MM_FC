#include <futurocube>

/**********************************/
#define I1   0xFF1C0000
#define CA   cGREEN
#define CB   cRED
#define CC   cBLUE
#define CD   0xFF1C0000
#define CE   WHITE
#define CF   0xFFD50000
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
                                   0,0,0,   //icon
                                   I1,I1,I1,    //icon
                                   /******/
                                   ''gang3_synthesisers'',  //app name sound (does not need to exists)
                                   ''gang3_synthesisers_intro'']   //explanation name sound (does not need to exists)

new solution[5] = [6,2,3,1,6]

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
	new counter = 0
	new answer[5] = [0,0,0,0,0]
	new tDelay = 300
	
	for(;;)
	{
		SetColor(CE)
		SetIntensity(5)
		DrawCube()
		PrintCanvas()
		SetIntensity(255)
		
		if (eTapSideOK())
		{
			side = eTapSide()
			answer[counter] = side+1
			counter++
			
			ClearCanvas()
			if (side == 0)
			{
				Play("_c2")
				SetColor(CA)
				DrawSide(side)
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 1)
			{
				Play("_d2")
				SetColor(CB)
				DrawSide(side)
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 2)
			{
				Play("_e2")
				SetColor(CC)
				DrawSide(side)
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 3)
			{
				Play("_f2")
				SetColor(CD)
				DrawSide(side)
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 4)
			{
				Play("_g2")
				SetColor(CE)
				DrawSide(side)
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 5)
			{
				Play("_h2")
				SetColor(CF)
				DrawSide(side)
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			printf("Answer: %i,%i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3],answer[4])
		}
		AckMotion()
		Sleep(tDelay)
		
		if (answer == solution)
		{
			PuzzleComplete()
		}
		
		if (counter == 5)
		{
			Play("uff")
			WaitPlayOver()
			Play("incorrect_passcode")
			WaitPlayOver()
			AckMotion()
			SetColor(CE)
			FlashCanvas(1,3,0)
			Sleep(tDelay)
			answer = [0,0,0,0,0]
			counter = 0
			printf("Answer: %i,%i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3],answer[4])
		}
	}
	
}   