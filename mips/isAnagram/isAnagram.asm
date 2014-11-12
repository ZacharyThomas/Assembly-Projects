### Function to check if two strings are anagrams of each other 
### Inputs: String 1, String 2
### Outputs: Output string True or False
### Made by Zack Smith 10/28/14

# Data segment for variable declarations
	.data							# Begin data segment

### Empty storage declarations
inString1:								# Create variable inputString
	.space 160						# Reserve 160 bytes of data
inString2:								# Create variable noSpaceString
	.space 160						# Reserve 160 bytes of data
noSpace1:							# Reserve space for input string 1 sans space
	.space 160
noSpace2:							# Reserve space for input string 2 sans space
	.space 160
tempSpace:
	.space 40
	
### ASCII string storage declarations
displayString1:								# Create variable displayString
	.asciiz "Please enter the first string:  "			# Save prompt text in memory
displayString2: 								# Store valid characters in 
	.asciiz "Please enter the second string: "		# All valid characters probably
validString:									# Create variable validString
	.asciiz "The strings are anagrams"				# Output string if input is valid
invalidString:									# Create variable invalidString
	.asciiz "The strings are not anagrams"			# Output string if input is invalid
	
###################################### END OF DATA SEGMENT ######################################
.text

# Subroutine to prompt user and store strings
main:
	### In String 1 ###
	la $a0, displayString1	# Load input string address in to a0
	li $v0, 4				# Load up parameters for syscall 4 ( print string)
    	syscall				# Print string at address $a0 (displayString1)
    	la $a0, inString1		# Load up parameters for syscall 8 ( read string)
    	li $a1, 160			
	li $v0,8				
   	syscall				# Stores input string into mem address at $a0 (inString1)
   	### In String 2 ###
   	la $a0, displayString2	# Load input string address in to a0
	li $v0, 4				# Load up parameters for syscall 4 ( print string)
    	syscall				# Print string at address $a0 (displayString1)
    	la $a0, inString2		# Load up parameters for syscall 8 ( read string)
    	li $a1, 160			
	li $v0,8				
   	syscall				# Stores input string into mem address at $a0 (inString1)
   	la $s0, inString1		# Store inputString1 in to $s0
   	la $s1, inString2		# Store inputString2 in to $s1
   	la $s2, noSpace1
   	la $s3, noSpace2.
	la $t0, inString1		# Store address in temp registers too
	la $t1, inString2   	
 # Subroutine to remove all spaces from both inputs.   	
remove_space:
	lb $t9, ($t0) 					# Check first byte
	beq $t9,'\n' ,remove_space_2		# Remove space for second string
	addi $t0, $t0, 1				# Push $t0 forward
	bne $t9, ' ', write_string			# Write string
	j remove_space 				# If it is a space, don't write, jump back
	
# Subroutine to write bytes in t9 to nospacestring	
write_string:
	addi $t7, $t7, 1
	sb $t9, ($s2)
	addi $s2, $s2, 1
	j remove_space
	
remove_space_2:
	lb $t9, ($t1)
	beq $t9, '\n', removal_finish
	addi $t1, $t1, 1
	bne $t9, ' ', write_string_2
	j remove_space_2

write_string_2:
	addi $t8, $t8, 1
	sb $t9, ($s3)
	addi $s3, $s3, 1
	j remove_space_2

# Subroutine to add up ascii characters of no space strings (stored in $s2 and $s3)
removal_finish:
	bne $t8, $t7, print_false			# Lengths of strings are not equal
	lb $t9, ($s2) 					# Get byte
	addi $s2, $s2, 1      				# Increment counter
	beq $t9, '\0', next_add
	add $t6, $t6, $t9				# Add byte to val
	j removal_finish				# Jump back until newline
next_add:
	lb $t9, ($s3) 					# Get byte
	addi $s3, $s3, 1      				# Increment counter
	beq $t9, '\0', final_check
	add $t5, $t5, $t9				# Add byte to val
	j removal_finish				# Jump back until newline

 final_check:
 	beq $t5, $t6, print_true    	
# Subroutne to print that the two strings are not anagrams
print_false:
	la $a0, invalidString	# Load input string address in to a0
	li $v0, 4				# Load up parameters for syscall 4 ( print string)
    	syscall				# Print string at address $a0 
	li $v0, 10				# Load up parameters for syscall 
    	syscall				# Syscall 10 -> Return statement
# Subroutine to print that the two strings are anagrams
print_true:	
	la $a0, validString		# Load input string address in to a0
	li $v0, 4				# Load up parameters for syscall 4 ( print string)
    	syscall				# Print string at address $a0 
	li $v0, 10				# Load up parameters for syscall 
    	syscall				# Syscall 10 -> Return statement

	
	
	
	
	
	
