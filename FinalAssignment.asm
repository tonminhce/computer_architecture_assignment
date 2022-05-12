.data
        array: .asciiz "| _ | _ | _ | _ | _ |\n| _ | _ | _ | _ | _ |\n| _ | _ | _ | _ | _ |\n| _ | _ | _ | _ | _ |\n| _ | _ | _ | _ | _ |\n"
        Input: .asciiz "Player   please pick your move (1-25):"
        Invalid: .asciiz "Invalid! Please choose again!\n"
        playerX: .asciiz "X" 
        playerO: .asciiz "O"
	line: .asciiz "\n"
	winx: .asciiz "\nPlayer X is the Champion.\n"
	wino: .asciiz "\nPlayer O is the Champion.\n"
	Tie: .asciiz  "\nIt is a Tie."
	Option: .asciiz "\nAgain? 1-YES | 2-NO \nYour choice: "
	warning:.asciiz "You can not choose the central point in the first turn\n"
	temp: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	gach: .asciiz "_"
	undo: .asciiz "\nUndo move? 1-YES | ANY NUMBERS-NO \n "
	
	#| _ | _ | _ | _ | _ |
	#| _ | _ | _ | _ | _ |
	#| _ | _ | _ | _ | _ |
	#| _ | _ | _ | _ | _ |
	#| _ | _ | _ | _ | _ |
	
	#choose number from 1 to 25
.text
main:

        move $t1, $zero       #reset value to 0
        move $t2, $zero       #each spot has it own counter
        move $t3, $zero		#count win
        move $t4, $zero		#count win 1
        move $t5, $zero		#load gach
        move $t6, $zero		# 1st win position
        move $t7, $zero		#used
        move $t8, $zero
        move $t9, $zero
        move $s1, $zero		#move count to zero
        move $s2, $zero		#load address array
        move $s3, $zero		#load address Input
        move $s4, $zero		#load address temp
        move $s5, $zero		
        move $s6, $zero		# 2nd win position
        move $s7, $zero		# 3rd win position
        
	la $s2, array
        la $s3, Input
        la $s4, temp
        
        move $t1,$zero
        
	sw $t1,96($s4)
	sw $t1,92($s4)
	sw $t1,88($s4)
	sw $t1,84($s4)
	sw $t1,80($s4)
	sw $t1,76($s4)
	sw $t1,72($s4)
	sw $t1,68($s4)
	sw $t1,64($s4)
	sw $t1,60($s4)
	sw $t1,56($s4)
	sw $t1,52($s4)
	sw $t1,48($s4)
	sw $t1,44($s4)
	sw $t1,40($s4)
	sw $t1,36($s4)
	sw $t1,32($s4)
	sw $t1,28($s4)
	sw $t1,24($s4)
	sw $t1,20($s4)
	sw $t1,16($s4)
	sw $t1,12($s4)
	sw $t1,8($s4)
	sw $t1,4($s4)
	sw $t1,0($s4)
 	
 	lb $t5, gach
 	sb $t5, 2($s2)
 	sb $t5, 6($s2)
 	sb $t5, 10($s2)
 	sb $t5, 14($s2)
 	sb $t5, 18($s2)
 	sb $t5, 24($s2)
 	sb $t5, 28($s2)
 	sb $t5, 32($s2)
 	sb $t5, 36($s2)
 	sb $t5, 40($s2)
 	sb $t5, 46($s2)
 	sb $t5, 50($s2)
 	sb $t5, 54($s2)
 	sb $t5, 58($s2)
 	sb $t5, 62($s2)
 	sb $t5, 68($s2)
 	sb $t5, 72($s2)
 	sb $t5, 76($s2)
 	sb $t5, 80($s2)
 	sb $t5, 84($s2)
 	sb $t5, 90($s2)
 	sb $t5, 94($s2)
 	sb $t5, 98($s2)
 	sb $t5, 102($s2)
 	sb $t5, 106($s2)
 	
print:
        li $v0, 4
        la $a0, line
        syscall
        li $v0, 4
        la $a0, array
        syscall
       
        beq $s1, 25, tie
        rem $t0, $s1, 2
        addi $s1, $s1, 1	
        bne $t0, $zero, MoveO
        j MoveX
        
MoveX:
        lb $a1, playerX
        sb $a1, 7($s3)
        j tictac
MoveO:
        lb $a1, playerO
        sb $a1, 7($s3)
        j tictac
tictac:

        li $v0, 4
        la $a0, Input
        syscall
        li $v0, 5
        syscall 
        add $s5, $v0,$zero     
        add $t9,$v0,$zero
        beq $s5,1,a1
        beq $s5,2,a2
        beq $s5,3,a3
        beq $s5,4,a4
        beq $s5,5,a5
        beq $s5,6,a6
        beq $s5,7,a7
        beq $s5,8,a8
        beq $s5,9,a9
        beq $s5,10,a10
        beq $s5,11,a11
        beq $s5,12,a12
        beq $s5,13,a13
        beq $s5,14,a14
        beq $s5,15,a15
        beq $s5,16,a16
        beq $s5,17,a17
        beq $s5,18,a18
        beq $s5,19,a19
        beq $s5,20,a20
        beq $s5,21,a21
        beq $s5,22 a22
        beq $s5,23,a23
        beq $s5,24,a24
        beq $s5,25,a25

        
        j invalid
invalidfirst:
	li $v0, 4
        la $a0, warning
        syscall
        j tictac	
	
a1:
	lw $t1,0($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, o1
        j x1
        
        x1:
        addi $t1, $t1, 1
        sw $t1,0($s4)
        sb $a1, 2($s2)
        
                j wincondition
        
        o1:
        addi $t1, $t1, -1
        sw $t1,0($s4)
        sb $a1, 2($s2)
        
                j wincondition
        
a2:	
	lw $t1,4($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, o2
        j x2
        
        x2:
        addi $t1, $t1, 1
        sw $t1,4($s4)
        sb $a1, 6($s2)
        
                j wincondition
        
        o2:
        addi $t1, $t1, -1
        sw $t1,4($s4)
        sb $a1, 6($s2)
        
                j wincondition
        
a3:
	lw $t1,8($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, o3
        j x3
        
        x3:
        addi $t1, $t1, 1
        sw $t1,8($s4)
        sb $a1, 10($s2)
        
                j wincondition
        
        o3:
        addi $t1, $t1, -1
        sw $t1,8($s4)
        sb $a1, 10($s2)
        
                j wincondition
        
a4:
	lw $t1,12($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, o4
        j x4
        
        x4:
        addi $t1, $t1, 1
        sw $t1,12($s4)
        sb $a1, 14($s2)
        
                j wincondition
        
        o4:
        addi $t1, $t1, -1
        sw $t1,12($s4)
        sb $a1, 14($s2)
        
                j wincondition
        
a5:
	lw $t1,16($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O5
        j X5
        
        X5:
        addi $t1, $t1, 1
        sw $t1,16($s4)
        sb $a1, 18($s2)
        
                j wincondition
        
        O5:
        addi $t1, $t1, -1
        sw $t1,16($s4)
        sb $a1, 18($s2)
        
                j wincondition
        
a6:
	lw $t1,20($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O6
        j X6
        
        X6:
        addi $t1, $t1, 1
        sw $t1,20($s4)
        sb $a1, 24($s2)
        
                j wincondition
        
        O6:
        addi $t1, $t1, -1
        sw $t1,20($s4)
        sb $a1, 24($s2)
        
                j wincondition
        
a7:
	lw $t1,24($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O7
        j X7
        
        X7:
        addi $t1, $t1, 1
        sw $t1,24($s4)
        sb $a1, 28($s2)
        
                j wincondition
        
        O7:
        addi $t1, $t1, -1
        sw $t1,24($s4)
        sb $a1, 28($s2)
        
                j wincondition
        
a8:
	lw $t1,28($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O8
        j X8
        
        X8:
        addi $t1, $t1, 1
        sw $t1,28($s4)
        sb $a1, 32($s2)
        
                j wincondition
        
        O8:
        addi $t1, $t1, -1
        sw $t1,28($s4)
        sb $a1, 32($s2)
        
                j wincondition

a9:
	lw $t1,32($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O9
        j X9
        
        X9:
        addi $t1, $t1, 1
        sw $t1,32($s4)
        sb $a1, 36($s2)
        
                j wincondition
        
        O9:
        addi $t1, $t1, -1
        sw $t1,32($s4)
        sb $a1, 36($s2)
        
                j wincondition
a10:
	lw $t1,36($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O10
        j X10
        
       X10:
        addi $t1, $t1, 1
        sw $t1,36($s4)
        sb $a1, 40($s2)
        
                j wincondition
        
       O10:
        addi $t1, $t1, -1
        sw $t1,36($s4)
        sb $a1, 40($s2)
        
                j wincondition
a11:
	lw $t1,40($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O11
        j X11
        
       X11:
        addi $t1, $t1, 1
        sw $t1,40($s4)
        sb $a1, 46($s2)
        
                j wincondition
        
      O11:
        addi $t1, $t1, -1
        sw $t1,40($s4)
        sb $a1, 46($s2)
        
                j wincondition
a12:
	lw $t1,44($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O12
        j X12
        
       X12:
        addi $t1, $t1, 1
        sw $t1,44($s4)
        sb $a1, 50($s2)
        
                j wincondition
        
      O12:
        addi $t1, $t1, -1
        sw $t1,44($s4)
        sb $a1, 50($s2)
        
                j wincondition
a13:
	lw $t1,48($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O13
        j X13
        
      X13:
      	beq $s1,1,invalidfirst
        addi $t1, $t1, 1
        sw $t1,48($s4)
        sb $a1, 54($s2)
                j wincondition
        
     O13:
     	beq $s1,2,invalidfirst
        addi $t1, $t1, -1
        sw $t1,48($s4)
        sb $a1, 54($s2)
                j wincondition
a14:
	lw $t1,52($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O14
        j X14
        
       X14:
        addi $t1, $t1, 1
        sw $t1,52($s4)
        sb $a1, 58($s2)
                j wincondition
        
      O14:
        addi $t1, $t1, -1
        sw $t1,52($s4)
        sb $a1, 58($s2)
                j wincondition
a15:
	lw $t1,56($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O15
        j X15
        
       X15:
        addi $t1, $t1, 1
        sw $t1,56($s4)
        sb $a1, 62($s2)
                j wincondition
        
       O15:
        addi $t1, $t1, -1
        sw $t1,56($s4)
        sb $a1, 62($s2)
                j wincondition
a16:
	lw $t1,60($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O16
        j X16
        
       X16:
        addi $t1, $t1, 1
        sw $t1,60($s4)
        sb $a1, 68($s2)
                j wincondition
        
       O16:
        addi $t1, $t1, -1
        sw $t1,60($s4)
        sb $a1, 68($s2)
                j wincondition 
a17:
	lw $t1,64($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O17
        j X17
        
       X17:
        addi $t1, $t1, 1
        sw $t1,64($s4)
        sb $a1, 72($s2)
        j wincondition
        
       O17:
        addi $t1, $t1, -1
        sw $t1,64($s4)
        sb $a1, 72($s2)
        j wincondition
a18:
	lw $t1,68($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O18
        j X18
        
       X18:
        addi $t1, $t1, 1
        sw $t1,68($s4)
        sb $a1, 76($s2)
        j wincondition
        
       O18:
        addi $t1, $t1, -1
        sw $t1,68($s4)
        sb $a1, 76($s2)
        j wincondition
a19:
	lw $t1,72($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O19
        j X19
        
	X19:
        addi $t1, $t1, 1
        sw $t1,72($s4)
        sb $a1, 80($s2)
        j wincondition
        
       O19:
        addi $t1, $t1, -1
        sw $t1,72($s4)
        sb $a1, 80($s2)
        j wincondition
a20:
	lw $t1,76($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O20
        j X20
        
       X20:
        addi $t1, $t1, 1
        sw $t1,76($s4)
        sb $a1, 84($s2)
        j wincondition
        
       O20:
        addi $t1, $t1, -1
        sw $t1,76($s4)
        sb $a1, 84($s2)
        j wincondition
a21:
	lw $t1,80($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O21
        j X21
        
       X21:
        addi $t1, $t1, 1
        sw $t1,80($s4)
        sb $a1, 90($s2)
        j wincondition
        
       O21:
        addi $t1, $t1, -1
        sw $t1,80($s4)
        sb $a1, 90($s2)
        j wincondition
a22:
	lw $t1,84($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O22
        j X22
        
       X22:
        addi $t1, $t1, 1
        sw $t1,84($s4)
        sb $a1, 94($s2)
        j wincondition
        
       O22:
        addi $t1, $t1, -1
        sw $t1,84($s4)
        sb $a1, 94($s2)
        j wincondition
a23:
	lw $t1,88($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O23
        j X23
        
       X23:
        addi $t1, $t1, 1
        sw $t1,88($s4)
        sb $a1, 98($s2)
        j wincondition
        
       O23:
        addi $t1, $t1, -1
        sw $t1,88($s4)
        sb $a1, 98($s2)
        j wincondition        
a24:
	lw $t1,92($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O24
        j X24
        
       X24:
        addi $t1, $t1, 1
        sw $t1,92($s4)
        sb $a1, 102($s2)
        j wincondition
        
       O24:
        addi $t1, $t1, -1
        sw $t1,92($s4)
        sb $a1, 102($s2)
        j wincondition        
a25:
	lw $t1,96($s4)
        bne $t1, $zero, invalid
        bne $t0, $zero, O25
        j X25
        
       X25:
        addi $t1, $t1, 1
        sw $t1,96($s4)
        sb $a1, 106($s2)
        j wincondition
        
       O25:
        addi $t1, $t1, -1
        sw $t1,96($s4)
        sb $a1, 106($s2)
        j wincondition         

wincondition:
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        
        lw $t6, 0($s4)
        lw $s6, 4($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        
        lw $t6, 0($s4)
        lw $s6, 8($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO    
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        
        lw $t6, 4($s4)
        lw $s6, 0($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO            

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        
        lw $t6, 4($s4)
        lw $s6, 8($s4)
        lw $s7, 0($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        
        lw $t6, 8($s4)
        lw $s6, 4($s4)
        lw $s7, 0($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                 
 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        
        lw $t6, 8($s4)
        lw $s6, 0($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
        
#done 0,4,8       
                                                               
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 0($s4)
        lw $s6, 20($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 0($s4)
        lw $s6, 40($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 0($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 40($s4)
        lw $s7, 0($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                           
                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 20($s4)
        lw $s7, 0($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 0($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
              
#done 0,20,40                                                                                                                                                                                                        
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 0($s4)
        lw $s6, 24($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 0($s4)
        lw $s6, 48($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 0($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
  
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 48($s4)
        lw $s7, 0($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 24($s4)
        lw $s7, 0($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                        

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 0($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO

#done 0,24,48             
                                                   
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 4($s4)
        lw $s6, 24($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 4($s4)
        lw $s6, 44($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 4($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO              

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 44($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                     
                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 24($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                 

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 4($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO    
        
#done 4,24,44                                                                                                                                
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 4($s4)
        lw $s6, 28($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 4($s4)
        lw $s6, 52($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 4($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO               

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 52($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                         

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 28($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO   

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 4($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO   

#done 4,28,52
          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 4($s4)
        lw $s6, 8($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 4($s4)
        lw $s6, 12($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 4($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 12($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 8($s4)
        lw $s7, 4($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 4($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                         
                                
#done 4,8,12
                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 24($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 40($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 8($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 40($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 24($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 8($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
        
#done 8,24,40        
     
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 28($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 48($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 8($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                          
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 48($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO   
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 28($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                 
                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 8($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
        
#done 8,28,48
                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 32($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 56($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 8($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                         

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 56($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 32($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                
                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 8($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                 
#done 8,32,56                      
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 12($s4)
        lw $s7, 16($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 8($s4)
        lw $s6, 16($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 8($s4)
        lw $s7, 16($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 16($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 16($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                         

move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 16($s4)
        lw $s6, 12($s4)
        lw $s7, 8($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                         
                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 16($s4)
        lw $s6, 8($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                        
                                                                                                                                                                
#done 8,12,16
                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 28($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 44($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 12($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 12($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 44($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 28($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 12($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                       
#done 12,28,44                                    
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 32($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 12($s4)
        lw $s6, 52($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 12($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 52($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 32($s4)
        lw $s7, 12($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 12($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
#done 12,32,52      
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 16($s4)
        lw $s6, 32($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 16($s4)
        lw $s6, 48($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 16($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 48($s4)
        lw $s7, 16($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 32($s4)
        lw $s7, 16($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO       
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 16($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
#done 16,32,48        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 16($s4)
        lw $s6, 36($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 16($s4)
        lw $s6, 56($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 16($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 56($s4)
        lw $s7, 16($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 36($s4)
        lw $s7, 16($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 16($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
#done 16,36,56        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 40($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 60($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 20($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 60($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 40($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO       
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 20($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                   
#done 20,40,60                                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 24($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 28($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 20($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 28($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 24($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 20($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
#done 20,24,28        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 44($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 20($s4)
        lw $s6, 68($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 20($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 68($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 44($s4)
        lw $s7, 20($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 20($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                 
#done 20,44,68                                                                                                                                                                                                                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 44($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 64($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 24($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 64($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 44($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 24($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
#done 24,44,64                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 48($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 72($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 24($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 72($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 48($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 24($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 24,48,72
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 28($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO   
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 24($s4)
        lw $s6, 32($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 24($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 32($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 28($s4)
        lw $s7, 24($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 24($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
#done 24,28,32     
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 32($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO   
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 36($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 28($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 36($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 32($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 28($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 28,32,36
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 48($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 68($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 28($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 68($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 48($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 28($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 28,48,68
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
        lw $t6, 28($s4)
        lw $s6, 52($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 76($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 28($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 76($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 52($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO           
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 28($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO              
#done 28,52,76        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 44($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 28($s4)
        lw $s6, 60($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 28($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 60($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO   
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 44($s4)
        lw $s7, 28($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 28($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                
#done 28,44,60                                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 48($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 64($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 32($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 64($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 48($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 32($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
#done 32,48,64
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 52($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 32($s4)
        lw $s6, 72($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 32($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 72($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 52($s4)
        lw $s7, 32($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 32($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                               
#done 32,52,72                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 52($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 68($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 36($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 68($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 52($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 36($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 36,52,68        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 56($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 36($s4)
        lw $s6, 76($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 36($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 76($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 56($s4)
        lw $s7, 36($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 36($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 36,56,76
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 60($s4)
        lw $s7, 80($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 80($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 40($s4)
        lw $s7, 80($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 80($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 80($s4)
        lw $s6, 60($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 80($s4)
        lw $s6, 40($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 40,60,80
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 64($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 88($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 40($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 88($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 64($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 40($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 40,64,88
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 44($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 40($s4)
        lw $s6, 48($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 40($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 48($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 44($s4)
        lw $s7, 40($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 40($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
#done 40,44,48
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 64($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 84($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO       
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 44($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 84($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 64($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 44($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
#done 44,64,84        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 48($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 52($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 44($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 52($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 48($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 44($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 44,48,52
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 68($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 44($s4)
        lw $s6, 92($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 44($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 92($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO            
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 68($s4)
        lw $s7, 44($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 44($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO           
#done 44,68,92    
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 64($s4)
        lw $s7, 80($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 80($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 48($s4)
        lw $s7, 80($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 80($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 80($s4)
        lw $s6, 64($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 80($s4)
        lw $s6, 48($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
#done 48,64,80        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 68($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO               
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 88($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 48($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 88($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 68($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                    
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 48($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
#done 48,68,88                                                                                                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 72($s4)
        lw $s7, 96($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 48($s4)
        lw $s6, 96($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 48($s4)
        lw $s7, 96($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 96($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 96($s4)
        lw $s6, 72($s4)
        lw $s7, 48($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 96($s4)
        lw $s6, 48($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                
#done 48,72,96                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 72($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 92($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 52($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 92($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 72($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 52($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                        
#done 52,72,92                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 68($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 52($s4)
        lw $s6, 84($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 52($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 84($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 68($s4)
        lw $s7, 52($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 52($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
#done 52,68,84
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 72($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 88($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 56($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 88($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 72($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 56($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
#done 56,72,88                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 76($s4)
        lw $s7, 96($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 56($s4)
        lw $s6, 96($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 56($s4)
        lw $s7, 96($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 96($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 96($s4)
        lw $s6, 76($s4)
        lw $s7, 56($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 96($s4)
        lw $s6, 56($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
#done 56,76,96                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 64($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 60($s4)
        lw $s6, 68($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 60($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 68($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO            
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 64($s4)
        lw $s7, 60($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO             
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 60($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO             
#done 60,64,68                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 68($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 64($s4)
        lw $s6, 72($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO  
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 64($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 72($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 68($s4)
        lw $s7, 64($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 64($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
#done 64,68,72                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 72($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 68($s4)
        lw $s6, 76($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 68($s4)
        lw $s7, 76($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 72($s4)
        lw $s6, 76($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 72($s4)
        lw $s7, 68($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 76($s4)
        lw $s6, 68($s4)
        lw $s7, 72($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
#done 68,72,76                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 80($s4)
        lw $s6, 84($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 80($s4)
        lw $s6, 88($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 80($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 88($s4)
        lw $s7, 80($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 84($s4)
        lw $s7, 80($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO        
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 80($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
#done 80,84,88
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 88($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 84($s4)
        lw $s6, 92($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 84($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 92($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 88($s4)
        lw $s7, 84($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 84($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
#done 84,88,92                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 92($s4)
        lw $s7, 96($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 96($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 88($s4)
        lw $s6, 96($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 88($s4)
        lw $s7, 96($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO 
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 92($s4)
        lw $s6, 96($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO         
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
         
         
        lw $t6, 96($s4)
        lw $s6, 92($s4)
        lw $s7, 88($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                
move $t6, $zero	
        move $s6, $zero	
        move $s7, $zero	
        move $t3, $zero
 
         
        lw $t6, 96($s4)
        lw $s6, 88($s4)
        lw $s7, 92($s4)
         
        add $t3, $t6, $s6
        add $t3, $t3, $s7
        beq $t3, 3, winX
        beq $t3, -3, winO                                 

       j print
        
invalid:
        li $v0, 4
        la $a0, Invalid
        syscall
        j tictac
winX: 
        li $v0, 4
        la $a0, array
        syscall
        
        li $v0, 4
        la $a0, winx
        syscall
        
        j endgame
winO: 
        li $v0, 4
        la $a0, array
        syscall
        
        li $v0, 4
        la $a0, wino
        syscall
        
        j endgame


tie: 
        li $v0, 4
        la $a0, Tie
        syscall
endgame:
        li $v0, 4
        la $a0, Option
        syscall
        li $v0, 5
        syscall
        beq $v0, 1, main
        beq $v0, 2, realend
        li $v0, 4
        la $a0, Invalid
        syscall
        j endgame
realend:
        li $v0, 10
        syscall
