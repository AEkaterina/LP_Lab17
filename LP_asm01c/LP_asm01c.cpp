#include <iostream>

#pragma comment (lib, "..\\Debug\\LP_asm01a.lib")

using namespace std;

extern "C"			//связ. по типу С, чтобы обойти декорирование в языке С++ при объявлении и определении функций
{
	int _stdcall getmin(int*, int);
	int _stdcall getmax(int*, int);
}

int main()
{
	int arr[10] = { -1, 25, 23, -4, 2, 5, 3, -31, 16, 27 };
	int min = getmin(arr, sizeof(arr) / sizeof(int));
	int max = getmax(arr, sizeof(arr) / sizeof(int));
	cout << "getmax - getmin = " << max - min << endl;
	return 0;
}