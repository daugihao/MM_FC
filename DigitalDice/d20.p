#include <futurocube>
#include <constants>

/**********************************/
#define I1   cPURPLE
#define I2   WHITE
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
                                   I1,0,I1,    //icon
                                   I1,0,I1,   //icon
                                   I1,0,I1,    //icon
                                   /******/
                                   ''_c_20SDICE'',  //app name sound (does not need to exists)
                                   '''']   //explanation name sound (does not need to exists)

main() {
	ICON(icon)  //this register icon bytefiled and compiler won't remove it
	SetVolume(VOLUME)
	
	RegAllTaps()
	
	new sidevar = 0
	new NDice = 1
	new xDie = 20
	new maxRolls = 9
	
	Play("_s_1")
	for(;;) {
		Sleep()
		AckMotion()
		sidevar = _side(GetCursor())
		
		// Adding one more dice to the roll
		if (eTapToSide()) {
			NDice++
			if (NDice > maxRolls) {
				NDice = 1
			}
			PlayNDice(NDice)
		}
		
		// 
		if (eTapToTop()) {
			SayScore(CalculateScore(NDice, xDie))
		}
		
		// Update display accordingly
		SetColor(I1)
		DrawCube()
		
		sidevar = _side(GetCursor())
		SetColor(I3)
		DrawSide(sidevar)
	
		SetColor(I2)
		DrawNDice(NDice, sidevar)	
		PrintCanvas()
	}
}

PlayNDice(N) {
	switch(N) {
		case 1: Play("_s_1")
		case 2: Play("_s_2")
		case 3: Play("_s_3")
		case 4: Play("_s_4")
		case 5: Play("_s_5")
		case 6: Play("_s_6")
		case 7: Play("_s_7")
		case 8: Play("_s_8")
		case 9: Play("_s_9")
		default: Sleep()
	}
}

DrawNDice(N, sidevar) {
	switch(N) {
		case 1: {
			DrawFlicker(sidevar*9 + 4)
		}
		case 2: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 8)
		}
		case 3: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 4)
			DrawFlicker(sidevar*9 + 8)
		}
		case 4: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 2)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 8)
		}
		case 5: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 2)
			DrawFlicker(sidevar*9 + 4)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 8)
		}
		case 6: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 2)
			DrawFlicker(sidevar*9 + 3)
			DrawFlicker(sidevar*9 + 5)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 8)
		}
		case 7: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 2)
			DrawFlicker(sidevar*9 + 3)
			DrawFlicker(sidevar*9 + 4)
			DrawFlicker(sidevar*9 + 5)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 8)
		}
		case 8: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 1)
			DrawFlicker(sidevar*9 + 2)
			DrawFlicker(sidevar*9 + 3)
			DrawFlicker(sidevar*9 + 5)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 7)
			DrawFlicker(sidevar*9 + 8)
		}
		case 9: {
			DrawFlicker(sidevar*9 + 0)
			DrawFlicker(sidevar*9 + 1)
			DrawFlicker(sidevar*9 + 2)
			DrawFlicker(sidevar*9 + 3)
			DrawFlicker(sidevar*9 + 4)
			DrawFlicker(sidevar*9 + 5)
			DrawFlicker(sidevar*9 + 6)
			DrawFlicker(sidevar*9 + 7)
			DrawFlicker(sidevar*9 + 8)
		}
	}
}

CalculateScore(NDice, xDie) {
	new total = 0
	for(new i=1; i<=NDice; i++) {
		total += GetRnd(xDie) + 1
	}
	return total
}

SayScore(number) {
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
	//printf("%i,%i,%i\r\n",h,t,o)
	
	Play("_s_SCOREIS")
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