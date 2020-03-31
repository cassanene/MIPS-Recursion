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

removeleadandtrail:
    lb $t2, 0($a0)
    beq $t2, 10, print #print after the string is done
    beq $t2, 32, skip #if the character is a space it will go to this label
    beq $t2, 9, skip
    ble $s1, 57, countValid
    # bge $s1, 88, countValid #goes to X
    # ble $s1, 120, makenewstrng


skip:
    addi $s1, $s1, 1 #adding 1 to the number of tabs and spaces before
    bge $s0, 1, invalid #counter for the length of the 

j removeleadandtrail

invalid:
    li $v0, 4
    la $a0, invalidInput
    syscall

countValid:
    addi $s0,$s0, 1
    addi $a0, $a0, 1 #move index

    li $v0, 4
    la $a0, testString
    syscall

j removeleadandtrail

# print:
#     li $v0, 4
#     la $a0, ($s3)
#     syscall
