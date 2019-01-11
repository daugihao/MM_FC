#include <futurocube>

#define colour1   0xFF1C0000
#define colour2   0x001CFF00

main() {    
	printf("hello world\r\n")
    for(;;) {
		ClearCanvas()
		Sleep()
		SetColor(colour1)
		DrawSquare(GetCursor())
		SetColor(colour2)
		DrawPoint(GetCursor())
		PrintCanvas()
    }
}   