/***********************************************************************************************************
// Author: MATOBAKELE A. Lehlohonolo
// Student No.: 202000345
// Purpose: The program that determines and prints the first 10 reversible prime squares in c
// Contact: lehlonotobaka@gmail.com
************************************************************************************************************/

#include<iostream>
#include<stdbool.h>
using namespace std;
#include <stdio.h>
#include <math.h>


bool isPrime(int num)     // return true if a number is prime
{
  bool flag = 0;
  int factors = 0; // Keeps track of factors of num
  for (int i = 1; i <= num; i++)
  {
    if (num % i == 0) // check for a factor of a sqrt of a number
    {
      factors++;
    }
  }
  if (factors == 2) // A prime number has two factors only
  {
    flag = 1;
  }
  return flag;
}

int squareNum(int num)     // return (num * num)
{
  return (num * num); 
}

int numReverse(int num)       // return the reverse of num
{
  int result, reverse = 0;
  while (num > 0)
  {
    result = num % 10;
    reverse = (reverse * 10) + result;
    num /= 10;
  }
  return reverse;
}


bool isSquareNum(int num, int i)      // return true if num is a square num
{
  bool flag = 0;
  if (squareNum(numReverse(i)) == num)
    flag = true;
  return flag;
}



bool isNotPalindrome(int num)    // return true if num is not a palindrome
{
  bool flag = true;
  if (num == numReverse(num))
  {
    flag = false;
  }
  return flag;
}

void printReversiblePrimeNumbers()    // print a list of reversible prime squares to the screen
{
  int index = 0, count = 1, v=1;
  bool set = false;
  printf("The first 10 reversible prime squares are:\n");
  for (int i = 0; i < count; i++) {
    if (isPrime(i))
    {
      int num = squareNum(i);
      int numRev = numReverse(num);
      if (isNotPalindrome(num) && isPrime(numReverse(i)) && isSquareNum(numRev, i))
      {
        set = 1;
        if (set && (index < 10))
        {  
		   
          printf("(%d)%i \n",0+v, num);
          v++;
          index++;
        }
      }
    }
    count++;
    if (index == 10) return; // Exit the non return type function
  }
}


int main()
{
  printReversiblePrimeNumbers();
  return 0;
}
