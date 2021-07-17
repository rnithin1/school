#include <stdlib.h>

int main (t) {
	
	for (;;t++) {
		putchar((t*9&t>>4|t*5&t>>7|t*3&t/1024)-1);
	}
}



// #inferno (t * 3) 
// #beach (t>>3&t*3)

// play 0 10 inferno
// play 2 10 beach


// ( (t * 9 &  t >> 4 | t * 5 & t >> 7 | t * 3 & t / 1024) - 1)