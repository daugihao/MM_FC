#include <futurocube>
#include <constants>

/**********************************/
#define I1              WHITE
#define I2              cBLUE
#define I3              cGREEN
#define I4              0x00000000 //Black
#define timeDoSecs      25
#define timeRestSecs    5
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
                                   0,I1,0,   //icon
                                   0,0,0,    //icon
                                   /******/
                                   '''',  //app name sound (does not need to exists)
                                   '''']   //explanation name sound (does not need to exists)

main() {
	ICON(icon)  //this register icon bytefiled and compiler won't remove it
	SetVolume(VOLUME)
	
	RegAllTaps()
	
	new time_secs = timeDoSecs
	new is_do = 1
	new paused = 1
	new sidevar = 0
	
	for(;;) {
		Sleep()
		AckMotion()
		sidevar = _side(GetCursor())
		
		if (eTapToSide()) {
			SayMinsRemaining(CalculateMins(time_secs))
		}
		
		if (eTapToTop()) {
			if (paused == 0) {
				paused = 1
			}
			else if (paused == 1) {
				paused = 0
			}
		}
		
		// Set cube to be fully one colour
		if (is_do == 1) {
			SetColor(I3) // Do
		} else {
			SetColor(I2) // Rest
		}
		DrawCube()
		
		// Clear the top side
		sidevar = _side(GetCursor())
		SetColor(I4)
		DrawSide(sidevar)
	
		// Set top side to show pulsing button
		if (paused == 1) {
			SetColor(I1)
			DrawPulsingTop(sidevar)
		}
		PrintCanvas()
		if (paused == 0) {
			Sleep(1000)
			printf("%i\r\n", time_secs)
			if (time_secs > 0) {
				time_secs--
			}
		}
	}
}

DrawPulsingTop(sidevar) {
	DrawFlicker(sidevar*9 + 4)
}

CalculateMins(time_secs) {
	return time_secs/1
}

SayMinsRemaining(number) {
	new h=number/100
	number%=100 // remainder when divided by 100
	new t=number/10
	new o
	if (t <= 2) {
		number%=20
		o=number
	} else {
		number%=10
		o=number
	}
	
	WaitPlayOver()
	switch (h) {
		case 1: {
			Play("100")
		}
		case 2: {
			Play("200")
		}
		case 3: {
			Play("300")
		}
		case 4: {
			Play("400")
		}
		case 5: {
			Play("500")
		}
		case 6: {
			Play("600")
		}
		case 7: {
			Play("700")
		}
		case 8: {
			Play("800")
		}
		case 9: {
			Play("900")
		}
	}
	WaitPlayOver()
	switch (t) {
		case 2: {
			Play("_s_20")
		}
		case 3: {
			Play("_s_30")
		}
		case 4: {
			Play("_s_40")
		}
		case 5: {
			Play("_s_50")
		}
		case 6: {
			Play("_s_60")
		}
		case 7: {
			Play("_s_70")
		}
		case 8: {
			Play("_s_80")
		}
		case 9: {
			Play("_s_90")
		}
	}
	WaitPlayOver()
	switch (o) {
		case 1: {
			Play("_s_1")
		}
		case 2: {
			Play("_s_2")
		}
		case 3: {
			Play("_s_3")
		}
		case 4: {
			Play("_s_4")
		}
		case 5: {
			Play("_s_5")
		}
		case 6: {
			Play("_s_6")
		}
		case 7: {
			Play("_s_7")
		}
		case 8: {
			Play("_s_8")
		}
		case 9: {
			Play("_s_9")
		}
		case 10: {
			Play("_s_10")
		}
		case 11: {
			Play("_s_11")
		}
		case 12: {
			Play("_s_12")
		}
		case 13: {
			Play("_s_13")
		}
		case 14: {
			Play("_s_14")
		}
		case 15: {
			Play("_s_15")
		}
		case 16: {
			Play("_s_16")
		}
		case 17: {
			Play("_s_17")
		}
		case 18: {
			Play("_s_18")
		}
		case 19: {
			Play("_s_19")
		}
	}
}