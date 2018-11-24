/**
 * main.c
 * A small blinky example.
 *
 * @author Nathan Campos <nathan@innoveworkshop.com>
 */

#include <xc.h>
#include <pic12f683.h>

#define _XTAL_FREQ 4000000

/**
 * The usual main entry point.
 */
void main(void) {
	TRISIO = 0x00;
	
	while (1) {
		GPIObits.GP2 = 0;
		__delay_ms(500);
		GPIObits.GP2 = 1;
		__delay_ms(500);
	}
}

