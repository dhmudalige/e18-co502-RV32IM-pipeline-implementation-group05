
/*
 * adder module - 
 * Add two 32 bit inputs together
 * give the output
 */

module adder(INPUT,OUTPUT);
    //declare input,output
    input [31:0] INPUT;
    output reg [31:0]OUTPUT; 

    //always block to add two inputs
    always @(*) begin
        #2;
        OUTPUT = INPUT+32'd4;
    end

endmodule


