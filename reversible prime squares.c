/***********************************************************************************************************
// Author: MATOBAKELE A. Lehlohonolo
// Student No.: 202000345
// Purpose: The program that determines and prints the first 10 reversible prime squares in c
// Contact: lehlonotobaka@gmail.com
************************************************************************************************************/

#include<iostream>
#include<stdbool.h>
using namespace std;



int Reverseprime[10];      //declaration
	int num=1;              //declaration    
	int square;             //declaration

bool primNum(int n){
	int temp=0;
	for(int i=1; i<=n; i++){
		if(n%i==0)
			temp++;
	}
	return (temp==2? true:false);
}

int Reversenum(int n)
{
	int reverse=0;
	while(n!=0)
	{
		reverse=reverse*10+n%10;
		n/=10;
	}
	return reverse;
}
bool checkpal(int n, int m)
{
	if(n==m)
		return true;
	else 
		return false;
}

bool CheckSquare(int m)
{
	bool check=false;
	for(int i=1; i<=m; i++){
		if(m/i==i && m%i==0){
			if(primNum(i)){
				check=true;
			}
			else {
				check=false;
			}
		}
}
	return check;
}
	// return false;

int main(){

	
	
	printf("The first 10 squares are:\n");
	for(int i=0; i<=9; i++){
		
		while(i<10){
			if(primNum(num))
			{
			
				square=num*num;
				if(checkpal(square, Reversenum(square))){
				
					num++;          //incriment
				}
				else{
					if(CheckSquare(Reversenum(square)))
					  {
					  
					  	Reverseprime[i]=square;
					  	num++;
					  	break;
					  }
					  else{
					  	num++;
					  }
					
				}				
				 
			}
			else num++;
		
		}
	}

		for(int i=0; i<10; i++)
	{

		printf("(%d)%d\n",i+1, Reverseprime[i] );
	}
	return 0;

}
