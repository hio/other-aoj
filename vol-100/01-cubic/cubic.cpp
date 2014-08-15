#include <iostream>
using namespace std;

int cubic(int num)
{
	return num * num * num;
}

int main()
{
	int num;
	cin >> num;
	if( !cin )
	{
		return 1;
	}
	cout << cubic(num) << endl;
	return 0;
}
