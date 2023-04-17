/*
 * mux module - 
 * select INPUT1 if ENABLE is HIGH
 * select INPUT2 if ENABLE is LOW
 */

module mux(OUTPUT,INPUT1,INPUT2,ENABLE);
    //declare input,output
    input [31:0] INPUT1,INPUT2;
    input ENABLE;
    output reg [31:0]OUTPUT; 

    //always block to SELECT inputs
    always @(*) begin
     
        case(ENABLE)

            0: OUTPUT = INPUT2;
            1: OUTPUT = INPUT1;
        endcase

    end
endmodule



