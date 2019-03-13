#include <futurocube>

/**********************************/
#define I1   0xFFD50000
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
new answer[4] = [0,0,0,0]

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
	
    SetIntensity(256)
    
    for(;;)
    {
        
		
		if (answer == solution)
		{
			PuzzleComplete()
		}
    }
}   