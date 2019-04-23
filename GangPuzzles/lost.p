#include <futurocube>
#include <constants>

new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,0,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   0,0,0,    //icon
                                   0,0,0,   //icon
                                   0,0,0,    //icon
                                   /******/
                                   ''404error'',  //app name sound (does not need to exists)
                                   '''']   //explanation name sound (does not need to exists)

main() 
{
	ICON(icon)  //this register icon bytefiled and compiler won't remove it
	SetVolume(VOLUME)
	
	StartGameMenu()
}