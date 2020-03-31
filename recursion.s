.data
    prompt: .asciiz "Input: "
    validString: .space 21
    userInput: .space 101
    invalidInput: .asciiz "Invalid input"
    testString: .asciiz "Test"
.text

main:
#prompt the user for a input
    li $v0, 4
    la $a0, prompt
    syscall

#store the characters inputted by the users
    li $v0, 8 #systemcalls
    la $a0, userInput
    syscall
    li $t0, 32
    li $s0, 0 #counter

    li $s2, 0 #for the number of char its been through
    la $t1, userInput 
    li $s3, 0 #tracks total num of valid chars
    li $s4, 0 #counter for the number of spaces before the input
    lb $s1, 0($a1)
    # li $s3, 0 #index of the valid string

removeleadandtrail:
    # beq $s1, 32, skip #if the character is a space it will go to this label
    # beq $s1, 9, skip
    beq $s1, 49, makenewstring
    # ble $s1, 57, makenewstring
    # bge $s1, 88, makenewstring #goes to X
    # ble $s1, 120, makenewstrng
    # beq $s1, 10, print

# skip:
#     bge $s2, 1, invalid

# j removeleadandtrail

# invalid:
#     li $v0, 4
#     la $a0, invalidInput
#     syscall

makenewstring:
    # sw $s1, validString($s3)
    addi $s2,$s2, 1 #moving the index
    addi $s1, $s1, 1 
    addi $s3, $s3, 1

    li $v0, 4
    la $a0, testString
    syscall

j removeleadandtrail

# print:
#     li $v0, 4
#     la $a0, ($s3)
#     syscall
