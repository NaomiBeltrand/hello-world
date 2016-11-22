           .data 
sum:	   .word   #store the sum as int in $t2          
promptOne: .asciiz "\nGive me an integer number.\n"
promptTwo: .asciiz "Goodbye!\n"
result:    .asciiz "\nThe sum of the integers up to  "
isR:        .asciiz " (Recursive) is "
isI:        .asciiz " (Iterative) is "
           .text
           .globl main
main:           
#display promptOne
li $v0, 4 		#system call for print string 
la $a0, promptOne	#load address of promptOne into $a0
syscall			#print promptOne	

#read in num
li $v0, 5		#read first int
syscall	

#reset the registers for the new value
move $t1, $zero		#set $t1 to 0 
move $t5, $zero		#set $t5 to 0 
move $t0, $v0		#set $t0 to $v0 (number entered by user)
move $t2, $v0		#set $t2 to $v0 (copy of the number entered by the user for future Reference) 

#check to see if $t0 >= 1
ble  $t0, 1, Next 	# go to next if $t0 <= 1

#jump to the nessary location
j AddRecursive
j Display
j AddIterative

#exit  
Next: 
li $v0, 4 		#system call for print string 
la $a0, promptTwo	#load address of prompTwo into $a0
syscall 

li $v0,10		#load exit code to $v0
syscall

AddRecursive:
add  $t1, $t1,$t0	#add $t1 to $t0
addi $t0, $t0, -1	#lower value of $t0 by 1
bnez $t0, AddRecursive	#recursion 
j Display

AddIterative:
addi $t7, $t7, 1 #make $t7 1
move $t4, $t2    #create a new duplicate for purposes of using in the iterative function

Loop:
add  $t5, $t5, $t4
addi $t4, $t4, -1
bnez $t4, Loop
j DisplayTwo  #display for recursive

Display:	#display for iterative

#display result string
li   $v0, 4
la   $a0, result
syscall

#display value that user entered in
li   $v0, 1
la   $a0, ($t2)
syscall

#display the middel portion of the result
li   $v0, 4
la   $a0, isR
syscall

#display answer
li   $v0, 1
la   $a0, ($t1)
syscall

# jump to AddIterative provided it has yet to be called
nor  $t7, $t7, $zero
bnez $t7 AddIterative

#li $v0,10		#load exit code to $v0
#syscall

DisplayTwo:

#display result string
li   $v0, 4
la   $a0, result
syscall

#display value that user entered in
li   $v0, 1
la   $a0, ($t2)
syscall

#display the middle portion of the result
li   $v0, 4
la   $a0, isI

#display answer
syscall
li   $v0, 1
la   $a0, ($t5)
syscall

j main #return to main




