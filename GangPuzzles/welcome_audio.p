#include <futurocube>
#include <constants>

/**********************************/
#define I1   0xFFE50000 //Yellow
#define I2   0xFF00F200 //Pink
#define I3   0x00000000 //Black
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,0,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   0,0,0,    //icon
                                   0,WHITE,0,   //icon
                                   0,0,0,    //icon
                                   /******/
                                   ''welcome_audio'',  //app name sound (does not need to exists)
                                   ''welcome_audio_intro'']   //explanation name sound (does not need to exists)

main() 
{
	ICON(icon)  //this register icon bytefiled and compiler won't remove it
	SetVolume(VOLUME)
	
	RegAllTaps()
	
	new sidevar = 0
	
	Play("welcome_speech")
	for(;;) 
	{
		Sleep()
		if (IsPlayOver())
		{
			if (eTapToTop())
			{
			Play("welcome_speech")
			}
			AckMotion()
		}
		else 
		{
			Sleep()
			SetColor(I1)
			DrawCube()
			SetColor(I2)
			
			sidevar = _side(GetCursor())
			//printf("side: %d, square: %d, index: %d\r\n",_side(c), _square(c), _i(c))
			SetColor(I3)
			DrawSide(sidevar)
			
			SetColor(I2)
			DrawPoint(sidevar*9 + 0)
			DrawPoint(sidevar*9 + 2)
			DrawPoint(sidevar*9 + 4)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 7)
			DrawFlicker(sidevar*9 + 8)
			
			PrintCanvas()
			AckMotion()
		}
	}
	
}