#include <xc.h>
#include <pic12f683.h>

#define _XTAL_FREQ 4000000

void main(void) {
	TRISIO = 0x00;
	
	while(1) {
		GPIObits.GP2 = 0;
		__delay_ms(100);
		GPIObits.GP2 = 1;
		__delay_ms(100);
	}
}
