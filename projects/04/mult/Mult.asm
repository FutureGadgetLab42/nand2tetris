//// Compute the product of two numbers: R2 = R0 * R1

    // Load value of R0 in to variable a
    @R0
    D=M
    @a
    M=D
    
    // Load value of R1 in to variable b
    @R1
    D=M
    @b
    M=D

    // Initialize product variable
    @0
    D=A
    @product
    M=D

    // Initialize i
    @i
    M=0

(LOOP)
    // Check if we need to exit loop
    // Load value of i in to D
    @i
    D=M

    // Check if i>a, jump to RET if so
    @a
    D=D-M
    @RET
    D;JGE

    // product = product + b
    @product
    D=M
    @b
    D=D+M
    @product
    M=D

    // Increment i
    @i
    M=M+1

    // Return to top of LOOP
    @LOOP
    0;JMP

(RET)
    @product
    D=M
    @R2
    M=D

(END)
    @END
    0;JMP
    