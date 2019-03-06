#include <futurocube>

/**********************************/
#define I1   0xFFEE0000
/**********************************/
//next lines defines icon and allows CUBE MANAGER to move the script across CUBE MENUS 
//it is not mandatory, but if missing, position of script cannot be modified
/**********************************/
new icon[]=[ICON_MAGIC1,ICON_MAGIC2,          //MANDATORY START
                                   0,1,       //default app placement 
                                              //Use CUBE MANAGER to move the app
                                              //across the cube and to MYCUBE SECTION
                                   /******/
                                   I1,0,0,    //icon
                                   0,I1,I1,   //icon
                                   0,I1,I1,    //icon
                                   /******/
                                   ''gang2_cybersecurity'',  //app name sound (does not need to exists)
                                   ''gang2_cybersecurity_intro'']   //explanation name sound (does not need to exists)
		
//this function draws up to three digit number, same as score		
draw_score(side, number)
{
	new i
	new h=number/100
	number%=100
	new t=number/10
	number%=10
	new o=number

	DrawDigit(27,h)
	DrawDigit(9,t)
	DrawDigit(18,o)
}
								   
main()
{
	/*********************************************************************/
    ICON(icon)  //this register icon bytefiled and compiler won't remove it
    /*********************************************************************/
	
	new i = 0
	
	for(;;)
	{
		for(i=0;i<999;i++)
		{
			Sleep(1000)
			ClearCanvas()
			draw_score(0,i)
			PrintCanvas()
			printf("Number printed: %i\r\n",i)
		}
	}
}   