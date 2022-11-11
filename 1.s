# a. Write assembly instructions for the callee setup and
#    callee return of a function that uses only registers $a0
#    through $a3 as inputs and only registers $v0 and $v1 as
#    outputs. Explain why your code is correct.

my_fn:
# this code does not touch any callee-saved registers so I 
# do not need to create a stack frame. 
jr		$ra					# jump to $ra

# b. Write assembly instructions for the callee setup and
#    callee return of a function that uses only registers $a0
#    through $a3 as inputs and only registers $v0 through $v1
#    as outputs. As part of its operation, the funtion makes
#    a call to another function. Explain why your code is
#    correct.

my_fn_2:
# this code does touch $ra since it calls another function
# with jal (which implicitly modifies $ra), so I need to
# allocate a stack frame and save it.

# callee setup
addiu	$sp, $sp, -32			# $sp = $sp + -32
sw		$ra, 28($sp)			# save $ra to stack
sw		$fp, 24($sp)		# save $fp to stack
addiu	$fp, $sp, 32			# $fp = $sp + 32
# function body
jal being_called
# callee return
lw		$fp, 24($sp)		# restore $fp from stack
lw		$ra, 28($sp)			# restore $ra from stack
addiu    $sp, $sp, 32			# pop frame
jr		$ra					# jump to $ra

# c. What (if anything) changes in the previous part (b) if
#    the function makes a call to itself?

# You wouldn't need to change anything.

# d. What (if anything changes in the previous part (b) if
#    the function makes multiple calls to other functions?

# Nothing would change; there isn't caller setup, so you
# can just add more jal instructions.]

# e. What (if anything) changes in the previous part if the
#    function does not make calls to any functions?

# If the function doesn't make calls to any functions, it
# would not need to allocate a stack frame and do the
# associated saving/loading of $ra and $fp, since $ra wouldn't
# be modified.