/*
 * mux module - 
 * select INPUT1 if ENABLE is HIGH
 * select INPUT2 if ENABLE is LOW
 */

module mux2x1(INPUT1,INPUT2,OUTPUT,ENABLE);
    //declare input,output
    input [31:0] INPUT1,INPUT2;
    input ENABLE;
    output reg [31:0]OUTPUT; 

    //always block to SELECT inputs
    always @(*) begin
        #1;
     
        case(ENABLE)

            1: OUTPUT = INPUT2;
            default: OUTPUT = INPUT1;
        endcase

    end
endmodule



