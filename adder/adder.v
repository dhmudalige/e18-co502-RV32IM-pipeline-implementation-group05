
/*
 * adder module - 
 * Add two 32 bit inputs together
 * give the output
 */

module adder(OUTPUT,INPUT1,INPUT2);
    //declare input,output
    input [31:0] INPUT1,INPUT2;
    output reg [31:0]OUTPUT; 

    //always block to add two inputs
    always @(*) begin
        #2;
        OUTPUT = INPUT1+INPUT2;
    end

endmodule


