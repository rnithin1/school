
int main(int t) {
	for(;;t++)putchar(t&t%255 - (t*3&t>>13&t>>6));
	return 0;
}

