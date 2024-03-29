.data
# BASE = 34
# RANGE 24 - X
    prompt: .asciiz "Input: "
    validString: .space 21
    userInput: .space 101
    invalidInput: .asciiz "Invalid input"
    testString: .asciiz "Test"
.text
.globl main
main:
#prompt the user for a input
    li $v0, 4
    la $a0, prompt
    syscall

#store the characters inputted by the users
    li $v0, 8 #systemcalls
    la $a0, userInput
    li $a1, 101
    syscall

    li $s0, 0 #counter for the length of the valid string
    li $s1, 0 #counter for the length before 
    li $s3, 0 #counter trailing

    lb $t2, 0($a0)
checkstringLength:
    beqz $a1, lengthCounted 
	addi $t0, $t0, 1 
	addi $a0, $a0, 1 
j checkstringLength 


    li $t1, 0 #index of valid char
    subu $t2,$t0,1 #index of last valud string
    la $s6, $a0


removeLead:
    lb $t7,($s6) 
    bgt $s6, 32, leadFinish
	beq $s6, 9, skipLead 
	beq $s6, 32, skipLead

skipLead:
    addi $t1, $t1, 1 
	addi $s6, $s6, 1
j skipLead 

leadFinish:
    subu $s6,$s6,$t1 
    addu $s6,$s6,$t2

removeTrailing:
    lb $a3, ($s6) 
    bgt $a3, 32, trailFinish
	beq $a3, 9, skipTrail 
	beq $a3, 32, skipTrail 

skipTrail:
    addi $t2, $t2, -1
	addi $s6,$s6, -1
j skipTrail

trailFinish:
    subu $t3,$t2,$t1 
    addi $t3,$t3,1 
    li $s6, 0 
    la $s6, $a0
    addu $s6,$s6,$t1

bgt $t3, 20, invalid
beqz $t3, invalid

li $s7, 0 #making a counter for the loop

validityLoop:
    beq $s7, $t3
    lb $a2, 0($s6)
    beq $a2, 9, invalid
    beq $a2, 32, invalid
    ble $a2, 58, validz9
    ble $a2, 88, validup #goes to X
    ble $a2, 120, validlow

invalid:
    li $v0, 4
    la $a0, invalidInput
    syscall

validz9:
    ble $t2, 47, invalid
    addi $s6,$s6, 1
    addi $s7, $s7, 1 #move index

j validityLoop

validup:
    ble $t2, 64, invalid
    addi $s6,$s6, 1
    addi $s7, $s7, 1 #move index
j validityLoop

validlow:
    ble $t2, 96, invalid
    bge $t2, 89, invalid
    addi $s6,$s6, 1
    addi $s7, $s7, 1 #move index
j validityLoop


recursion:
    li $t5, 0
    li $s2, 24 #base
    li $s6, 0
    la $s6, $a0
