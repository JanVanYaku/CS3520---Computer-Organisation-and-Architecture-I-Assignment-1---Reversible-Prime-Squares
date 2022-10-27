#***********************************************************************************************************
# Author: MATOBAKELE A. Lehlohonolo
# Student No.: 202000345
# Purpose: The program that determines and prints the first 10 reversible prime squares in assembly language
# Contact: lehlonotobaka@gmail.com
#************************************************************************************************************
##############################################################
#      In essence we want to print:
#The first 10 reversible prime squares are:
#(1)169
#(2)961
#(3)12769
#(4)96721
#(5)1042441
#(6)1062961
#(7)1216609
#(8)1442401
#(9)1692601
#(10)9066121
########################################################

.data
      msg: .asciiz "The first 10 reversible prime squares are:: \n"
      newLine: .asciiz "\n"
.text
.globl main
main:
            # Display message
      ori $v0, $zero, 4
      la $a0, msg
      syscall
            # Function call
      jal printReversiblePrimeNumbers
            # Exit program
      ori $v0, $zero, 10
      syscall
# Implementation of isPrime(int num)
isPrime:
      li $v0, 0 # bool flag = 0
      li $t1, 1 # int i = 1
      li $t2, 2 # Set factors to two - prime has two factors
      is_prime_loop:
            bgt $t1, $a0, checkFactors
            div $a0, $t1
            mfhi $t3 
            bne $t3, $zero, endOfForLoop_prime
            addi $t9, $t9, 1 # factors++ - increase number of factors by 1
            addi $t1, $t1, 1 # i++
            j is_prime_loop
      endOfForLoop_prime:
            addi $t1, $t1, 1 # i++
            j is_prime_loop 
      checkFactors:
            ori $t3, $zero, 1
            beq $t9, $t2, True # is number of factors 2?
            j exitIsPrime
      True:
            addu $v0, $zero, $t3
      exitIsPrime:
            addu $t9, $zero, $zero
            jr $ra
# Implementation of squareNum(int num)
squareNum:
      mult $a0, $a0
      mflo $v0
      jr $ra
# Implementation of isSquareNum(int num, i)
isSquareNum:
      addi $sp, $sp, -12
      sw $ra, 0($sp)
      sw $s6, 4($sp)
      sw $s7, 8($sp)

      ori $v1, $zero, 0 # bool flag = 0
      addu $a0, $t6, $zero
      jal squareNum
      bne $v0, $s6, isFalse # (sqtrNum(num) != num)
      isTrue:
            addu $v0, $v1, $zero
            addi $v0, $v0, 1 # flag = true
            j exitIsSquareNum
      isFalse:
            addu $v0, $zero,$zero
            j exitIsSquareNum
      exitIsSquareNum:
            lw $s7, 8($sp)
            lw $s6, 4($sp)
            lw $ra, 0($sp)
            addi $sp, $sp, 12
            jr $ra
# Implementation of numReverse
numReverse:
      addi $v0, $zero, 0 # int reverse = 0
      loopNumReverse:
            slti $t2, $a0, 1
            bne $t2, $zero, exitNumReverse
            ori $t2, $zero, 10 # store 10 into register $t2
            div $a0, $t2
            mfhi $t0
            mult $v0, $t2 # reverse * 10
            mflo $t1 # $t1 = reverse * 10
            add $v0, $t1, $t0 # reverse = (reverse * 10) + result
            div $a0, $t2 # num / 10
            mflo $a0 # num = num / 10
            j loopNumReverse 
      exitNumReverse:
            jr $ra
# Implementation of isNotPalindrome(int num)
isNotPalindrome:
      addi $sp, $sp, -8
      sw $ra, 0($sp)
      sw $s0, 4($sp)
      addu $s0, $zero, $a0 # $s0 <- argument
      ori $v1, $zero, 1 # bool flag = true
      jal numReverse # a function call: numReverse(num)
      add $t0, $v0, $zero # store the result of the function call in $t0
      addu $v0, $zero, $v1
      bne $s0, $t0, exitIsNotPalindrome # if ($a0 != $t0) goto exit
      addu $v0, $zero, $zero # if (num == numReverse(num)) set flag = false
      exitIsNotPalindrome:
            lw $s0, 4($sp)
            lw $ra, 0($sp)
            addi $sp, $sp, 8
            jr $ra
# Implementation of printReversiblePrimeNumbers()    
printReversiblePrimeNumbers:
      addi $sp, $sp, -36
      sw $ra, 0($sp)
      sw $s0, 4($sp)    # holds $a0
      sw $s1, 8($sp)    # holds SIZE
      sw $s2, 12($sp)   # holds index
      sw $s3, 16($sp)   # holds count
      sw $s4, 20($sp)   # holds set (bool type variable)
      sw $s5, 24($sp)   # hold the value 1 for comparison
      sw $s6, 28($sp)
      sw $s7, 32($sp)

      ori $s1, $zero, 10  # int SIZE = 10
      ori $s2, $zero, 0   # int index = 0
      ori $s3, $zero, 1   # int count = 1
      ori $s4, $zero, 0   # bool set = false
      ori $s5, $zero, 1   # load value 1 into $s5
      ori $s7, $zero, 0   # int i = 0
      print_forLoop:
            slt $t7, $s3, $s7
            bne $t7, $zero, end_forLoop
            addu $a0, $zero, $s7     # $a0 <- i
                  # call isPrime
            jal isPrime       # check whether 'i' is a prime number
            bne $v0, $s5, isNotPrime
                  # call squareNum
            jal squareNum
            addu $s0, $zero, $v0     # $s0, <- square(int i) , num = $s0
                  # call numReverse
            addu $a0, $zero, $s0
            jal numReverse
            addu $s6, $zero, $v0     # #s6 <- numReverse(int num) , numRev = $s6
                  # call isNotPalindrome
            addu $a0, $zero, $s0     # $a0 <- num
            jal isNotPalindrome
            addu $t7, $zero, $v0     # $t7 <- isNotPalindrome(int num)
                  # call numReverse
            addu $a0, $zero, $s7     # $a0 <- i
            jal numReverse
            addu $t6, $zero, $v0     # $t6 <- numReverse(i)
                  # call isSquareNum
            addu $a0, $zero, $s6     
            jal isSquareNum   # isSquareNum($s6, $s7)
            addu $t4, $zero, $v0     # $t4 <- isSquareNum($s6, $s7)
                  # call is prime
            addu $a0, $zero, $t6     # $a0 <- numReverse(i)
            jal isPrime
            addu $t5, $zero, $v0     # $t5 <- isPrime(sqrtNum(numReverse(num)))
                  # inner if statement
            and $t8, $t4, $t5  
            and $s4, $t7, $t8
            bne $s4, $s5, isNotPrime
            addu $s4, $zero, $s5     # set = 1 == $s4 <- 1
                  # innermost if statement
            slt $t9, $s2, $s1 #  true if index < SIZE
            bne $s4, $t9, isNotPrime
                  # print a new line
            ori $v0, $zero, 4
            la $a0, newLine
            syscall
                  # print num - reversiblePrimeSquare
            addu $v0, $zero, $s0
            add $a0, $zero, $v0
            ori $v0, $zero, 1
            syscall
                  # continue
            addi $s2, $s2, 1   # index++
      isNotPrime:
            addi $s3, $s3, 1   # count++
            addi $s7, $s7, 1   # i++
            bne $s2, $s1, print_forLoop   # index != SIZE
            j end_forLoop
      end_forLoop:
            lw $s7, 32($sp)
            lw $s6, 28($sp)
            lw $s5, 24($sp)
            lw $s4, 20($sp)
            lw $s3, 16($sp)
            lw $s2, 12($sp)
            lw $s1, 8($sp)
            lw $s0, 4($sp)
            lw $ra 0($sp)
            addi $sp, $sp, 36
            jr $ra
