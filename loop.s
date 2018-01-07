# Simple x64 assembly program to print some stars
#
# Data section contains data known at assembly time.
.section .data
msg:
	.ascii "*\n"	# the ascii string we need to print.

# Text section contains the executable code we want to run.
.section .text

# Define _start as a global lablel visible across all object files.
.global _start

# Start the _start function.
_start:
	movq $5, %rcx	# The number of times we want to print the *.

_loop:
	# Protect the rcx register from syscall
	push %rcx

	# Do the write syscall
	movq $1, %rax	# write is syscall 1
   	movq $1, %rdi	# stdout is fd 1
    	movq $msg, %rsi	# the message
    	movq $2, %rdx	# the length of the message
    	syscall

	# restore the count register and decrement the loop.
	pop %rcx
	dec %rcx
	jnz _loop
	jmp _end	# Not strictly required but keeps it tidier.
_end:
	movq $60, %rax	# Exit syscall
	movq $0, %rdi	# Exit value
	syscall
