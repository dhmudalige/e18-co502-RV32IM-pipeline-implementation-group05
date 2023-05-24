/*
 * mux32bit_2to1 module
 *
 */

module mux32bit_4to1(OUT, IN0, IN1, IN2, IN3, SELECT);
    // declare inputs and output
    input [31:0] IN0, IN1, IN2, IN3;
    input [1:0] SELECT;
    output reg [31:0] OUT;

    // always block to SELECT inputs
    always @(*) begin
        //selecting according to the SELECT signal
        if (SELECT == 2'b00)
            OUT = IN0;
        else if (SELECT == 2'b01) 
            OUT = IN1;
        else if (SELECT == 2'b10) 
            OUT = IN2;
        else
            OUT = IN3;
    end
endmodule