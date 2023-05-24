/*
 * mux32bit_2to1 module - 
 * select IN0 if SELECT is LOW --> 0
 * select IN1 if SELECT is HIGH --> 1
 */

module mux32bit_2to1(OUT,IN0,IN1,SELECT);
    // declare inputs and output
    input [31:0] IN0,IN1;
    input SELECT;
    output reg [31:0] OUT; 

    // always block to SELECT inputs
    always @(*) begin
        #1;
     
        case(SELECT)
            0: OUT = IN0;
            1: OUT = IN1;
        endcase

    end
endmodule