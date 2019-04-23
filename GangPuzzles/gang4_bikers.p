#include <futurocube>
#include <constants>

/**********************************/
#define I1   0xFFD50000
#define CY   0xFFD50000
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,4,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   I1,I1,I1,    //icon
                                   I1,0 ,I1,   //icon
                                   I1,I1,I1,    //icon
                                   /******/
                                   ''gang4_bikers'',  //app name sound (does not need to exists)
                                   ''gang4_bikers_intro'']   //explanation name sound (does not need to exists)

new solution[4] = [2,1,2,1]
new NReset = 10
new answer[4] = [NReset,NReset,NReset,NReset]
new tDelay = 800
new tSideCheckDelay = 10

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

DisplayCompass()
{
	SetColor(WHITE)
	DrawSide(4)
	SetColor(CY)
	
	//North	
	DrawPoint(0)
	DrawPoint(3)
	DrawPoint(6)
	DrawPoint(4)
	DrawPoint(2)
	DrawPoint(5)
	DrawPoint(8)
	//East
	DrawPoint(18)
	DrawPoint(19)
	DrawPoint(20)
	DrawPoint(22)
	DrawPoint(23)
	DrawPoint(24)
	DrawPoint(25)
	DrawPoint(26)
	//South
	DrawPoint(11)
	DrawPoint(10)
	DrawPoint(13)
	DrawPoint(16)
	DrawPoint(15)
	//West
	DrawPoint(27)
	DrawPoint(28)
	DrawPoint(29)
	DrawPoint(30)
	DrawPoint(31)
	DrawPoint(32)
	DrawPoint(33)
	DrawPoint(35)
		
	PrintCanvas()
}

StateCompass(dir)
{
	switch (dir)
		{
			case 0:
			{
				Play("north")
			}
			case 2:
			{
				Play("east")
			}
			case 1:
			{
				Play("south")
			}
			case 3:
			{
				Play("west")
			}
		}
	WaitPlayOver()
	Sleep(500)
	Play("position_return")
	WaitPlayOver()
}

Emphasis()
{
	FlashCanvas(1,3,0)
	Sleep(tDelay)
	PrintCanvas()
}


main()
{
    /*********************************************************************/
    ICON(icon)  //this register icon bytefiled and compiler won't remove it
	SetVolume(VOLUME)
    /*********************************************************************/
	
    SetIntensity(256)
    
    for(;;)
    {	
		//Reset answer
		answer = [NReset,NReset,NReset,NReset]
		//Display rough compass image
		DisplayCompass()
		
		Sleep(500)
		Play("rotate")
		WaitPlayOver()
		Sleep(500)
		
		//QUESTION 1!
		//Wait for puzzle to be oriented correctly to start
		while(_side(GetCursor()) != 4)
		{
			Sleep(tSideCheckDelay)
		}
		Emphasis()
		
		//Ask first question
		Play("question1")
		printf("Asking first question!\r\n")
		WaitPlayOver()
	
		//Wait for puzzle to be oriented to the answer for Q1
		while(answer[0] == NReset)
		{
			if((_side(GetCursor()) != 4) & (_side(GetCursor()) != 5))
			{
				//Register answer
				answer[0] = _side(GetCursor())
				printf("Registering first answer!\r\n")
				printf("Answer: %i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3])
			}
		}
		Emphasis()
		
		//State answer and ask to return to centre
		StateCompass(answer[0])
		
		
		//QUESTION 2!
		//Wait for puzzle to be oriented correctly to start
		while(_side(GetCursor()) != 4)
		{
			Sleep(tSideCheckDelay)
		}
		Emphasis()
		
		//Ask second question
		Play("question2")
		printf("Asking second question!\r\n")
		WaitPlayOver()
		
		//Wait for puzzle to be oriented to the answer for Q2
		while(answer[1] == NReset)
		{
			if((_side(GetCursor()) != 4) & (_side(GetCursor()) != 5))
			{
				//Register answer
				answer[1] = _side(GetCursor())
				printf("Registering first answer!\r\n")
				printf("Answer: %i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3])
			}
		}
		Emphasis()
		
		//State answer and ask to return to centre
		StateCompass(answer[1])
		
		
		//QUESTION 3!
		//Wait for puzzle to be oriented correctly to start
		while(_side(GetCursor()) != 4)
		{
			Sleep(tSideCheckDelay)
		}
		Emphasis()
		
		//Ask third question
		Play("question3")
		printf("Asking third question!\r\n")
		WaitPlayOver()
		
		//Wait for puzzle to be oriented to the answer for Q3
		while(answer[2] == NReset)
		{
			if((_side(GetCursor()) != 4) & (_side(GetCursor()) != 5))
			{
				//Register answer
				answer[2] = _side(GetCursor())
				printf("Registering first answer!\r\n")
				printf("Answer: %i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3])
			}
		}
		Emphasis()
		
		//State answer and ask to return to centre
		StateCompass(answer[2])
		
		
		//QUESTION 4!
		//Wait for puzzle to be oriented correctly to start
		while(_side(GetCursor()) != 4)
		{
			Sleep(tSideCheckDelay)
		}
		Emphasis()
		
		//Ask fourth question
		Play("question4")
		printf("Asking fourth question!\r\n")
		WaitPlayOver()
		
		//Wait for puzzle to be oriented to the answer for Q4
		while(answer[3] == NReset)
		{
			if((_side(GetCursor()) != 4) & (_side(GetCursor()) != 5))
			{
				//Register answer
				answer[3] = _side(GetCursor())
				printf("Registering first answer!\r\n")
				printf("Answer: %i,%i,%i,%i\r\n",answer[0],answer[1],answer[2],answer[3])
			}
		}
		Emphasis()
		
		//State answer and ask to return to centre
		StateCompass(answer[3])
		
		Sleep(500)
		Play("checking_code")
		WaitPlayOver()
		Sleep(1000)
		
		//Check answer
		printf("Checking full answer against solution!\r\n")
		if (answer == solution)
		{
			PuzzleComplete()
		}
		else
		{
			Play("uff")
			WaitPlayOver()
			Play("incorrect_passcode")
			WaitPlayOver()
		}
    }
}   