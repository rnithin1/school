#include <stdio.h>

int main (){
	for (int t = 0; t < 800000; t++) {
		putchar (t * ((t >> 9|t >> 13) & 25 & t >> 6));
	}

	return 0;
}


//(and (sound) (or (shift 4) (shift 13))