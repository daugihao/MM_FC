#include <futurocube>
#include <constants>

/**********************************/
#define I1              WHITE
#define I2              cBLUE
#define I3              cGREEN
#define I4              0x00000000 //Black
#define timeDoSecs      1500
#define timeRestSecs    300
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
	
	new time_max = timeDoSecs
	new time_secs = timeDoSecs
	new is_do = 1
	
	new paused = 1
	new top_side = 4
	new top = 4
	new bottom = 5
	new sidevar
	
	for(;;) {
		Sleep()
		AckMotion()
		sidevar = _side(GetCursor())
		
		printf("Status:\r\n")
		printf("is_do: %i, paused: %i, top_side: %i\r\n", is_do, paused, top_side) 
		
		if (eTapToSide()) {
			SayMinsRemaining(CalculateMins(time_secs, time_max))
		}
		
		if (eTapToTop()) {
			if (paused == 0) {
				paused = 1
			}
			else if (paused == 1) {
				paused = 0
			}
		}
		
		if (sidevar == top) {
			is_do = 1
			time_max = timeDoSecs
			if (top_side == bottom) {
				paused = 1
				top_side = top
				time_secs = time_max
			}
		}
		if (sidevar == bottom) {
			is_do = 0
			time_max = timeRestSecs
			if (top_side == top) {
				paused = 1
				top_side = bottom
				time_secs = time_max
			}
			
		}
		
		// Set cube to be fully one colour
		if (is_do == 1) {
			DrawTimerSide(I3, 8-9*time_secs/time_max)
		} else {
			DrawTimerSide(I2, 8-9*time_secs/time_max)
		}
	
		// Set top side to show pulsing button
		if (paused == 1) {
			SetColor(I1)
			DrawPulsingTop(top_side)
		}
		
		PrintCanvas()
		if (paused == 0) {
			Sleep(1000)
			//printf("Time remaining: %i\r\n", time_secs)
			if (time_secs > 0) {
				time_secs--
			}
		} else {
			Sleep(10)
		}
		ClearCanvas()
		
		if (time_secs == 0) {
			Vibrate(100)
			paused = 1
			time_secs = time_max
		}
	}
}

DrawTimerSide(color, proportion) {
	SetColor(color)
	DrawSide(0)
	DrawSide(1)
	DrawSide(2)
	DrawSide(3)
	//printf("Proportion: %i\r\n", proportion)
	SetColor(I4)
	for (new i = 0; i < proportion; i++) {
		DrawPoint(_w(0,i))
		DrawPoint(_w(1,i))
		DrawPoint(_w(2,i))
		DrawPoint(_w(3,i))
	}
}

DrawPulsingTop(sidevar) {
	DrawFlicker(sidevar*9 + 4)
}

CalculateMins(time_secs, time_max) {
	if (time_secs == time_max) {
		return time_secs/60
	} else {
		return time_secs/60 + 1
	}
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