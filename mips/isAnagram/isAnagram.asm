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
   	
 # Subroutine to remove all spaces from both inputs.   	
remove_space:
	
