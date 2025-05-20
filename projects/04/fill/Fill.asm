// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen
// by writing 'black' in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen by writing
// 'white' in every pixel;
// the screen should remain fully clear as long as no key is pressed.

@512
D=A
@num_cols
M=D

@256
D=A
@num_rows
M=D

(LISTEN)
    @KBD              // Load value of KBD memory map to D
    D=M

    @INPUT_DETECTED   // Jump to INPUT_DETECTED if it's not 0
    D;JNE
    
    @color            // Load current value of color to D
    D=M

    @NO_INPUT         // Only jump to NO_INPUT when color != 0 (which means that button was just released)
    D;JNE

    @LISTEN           // Jump back to top of LISTEN loop
    0;JMP

(INPUT_DETECTED)
    @color            // Set color to all 1's (-1 in twos comp is 111...1)
    M=-1
    @DRAW
    0;JMP

(NO_INPUT)
    @color
    M=0
    @DRAW
    0;JMP

(DRAW)
    @i
    M=0

    @SCREEN         // Write SCREEN pointer to @addr
    D=A
    @addr
    M=D

    (DRAW_LOOP)
        @i          // Check if i >= 256
        D=M
        @num_rows
        D=M-D
        @LISTEN     // Jump back to listen if i = 256
        D;JLE

     
        (INNER_LOOP)
            @col
            M=0   
            @color
            D=M
            @addr       // Load pointer to current position on screen
            A=M
            M=D         // Write @color to current position on screen
            
            @16
            D=A
            @col
            M=D+M
            @addr
            M=M+1
            D=M

            @num_cols
            D=M-D
            @INNER_LOOP
            D;JLE
        
        @addr
        D=M
        @32
        D=D+A      // Advance pointer to next row
        @addr
        M=D

        @i          // Increment i
        M=M+1

        @DRAW_LOOP  // Iterate
        0;JMP
    
    @LISTEN         // After drawing, return back to LISTEN loop 
    0;JMP
