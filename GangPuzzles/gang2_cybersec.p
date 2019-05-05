#include <futurocube>
#include <constants>

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
		
new solution = 47
new equation[54] = [CY,0,0,0,0,0,0,0,CY, CY,0,CY,0,CY,0,CY,0,CY, 0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0, CY,0,0,0,CY,0,0,0,CY, CY,CY,CY,0,CY,0,CY,CY,CY]

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

value_speech(counter)
{
	switch (counter)
	{
		case 0: Play("value_first")
		case 1: Play("value_second")
		case 2: Play("value_third")
		case 3: Play("value_fourth")
		case 4: Play("value_fifth")		
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
    
	RegAllSideTaps()
	
	new side = 0
	new counter = 0
	new answer[5] = [0,0,0,0,0]
	new answerval = 0
	new tDelay = 300
	
	for(;;)
	{
		draw()
		
		if (eTapSideOK())
		{
			side = eTapSide()
			if (side == 0)
			{
				value_speech(counter)
				answer[counter] = 2
				counter++
				
				Play("_s_2")
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 1)
			{
				value_speech(counter)
				answer[counter] = 5
				counter++
				
				Play("_s_5")
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 4)
			{
				value_speech(counter)
				answer[counter] = 3
				counter++
				
				Play("_s_3")
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			if (side == 5)
			{
				value_speech(counter)
				answer[counter] = 7
				counter++
				
				Play("_s_7")
				FlashCanvas(1,3,0)
				WaitPlayOver()
			}
			printf("Answer: %i,%i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3],answer[4])
		}
		AckMotion()
		Sleep(tDelay)
		
		
		if (counter == 5)
		{
			Sleep(500)
			Play("checking_code")
			WaitPlayOver()
			Sleep(1000)
			answerval = 5*answer[0] + 6*answer[1] - answer[2]*(answer[3]-answer[4]) + 11 
			if (answerval == solution)
			{
				PuzzleComplete()
			}
			else
			{
				Play("uff")
				WaitPlayOver()
				Play("incorrect_passcode")
				WaitPlayOver()
				AckMotion()
				FlashCanvas(1,3,0)
				Sleep(tDelay)
				answer = [0,0,0,0,0]
				counter = 0
				printf("Answer: %i,%i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3],answer[4])
			}
		}
	}
}   