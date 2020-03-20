.data
    prompt: .asciiz "Input: "
    validString: .space 21
    userInput: .space 101
    invalidInput: .sciiz "Invalid input"
.text

main:
// prompt the user for a input
    li $v0, 4
    la $a0, prompt
    syscall

#store the characters inputted by the users
    li $v0, 8 #systemcalls
    la $a0, userInput
    li $a1, 101
    la $s1, $a1
    syscall

    li $s2, 0 #for the number of char its been through
    la, $s3, validString
removeleadandtrail:
    beq $s1, 32, skip #if the character is a space it will go to this label
    beq $s1, 9, skip
    ble $s1, 57, makenewstring
    bge $s1, 88, makenewstring #goes to X
    ble $s1, 120, makenewstrng

skip:
    bge $s2, 1, invalid

j removeleadandtrail

invalid:
    li $v0, 4
    la $a0, invalidInput
    syscall

makenewstring:
    addi $s2,$s2, 1
    lb $t0, ($s1)
    sb $t0, ($s3)
    addi $s1, $s1, 1
    addi $s3, $s3, 1

j removeleadandtrail
