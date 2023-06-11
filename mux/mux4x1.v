/*
 * mux module - 
 * select INPUT1,INPUT2,INPUT3 or INPUT4 according to ENABLE 
 * 
 */

module mux4x1(INPUT1,INPUT2,INPUT3,INPUT4,OUTPUT,ENABLE);
    //declare input,output
    input [31:0] INPUT1,INPUT2,INPUT3,INPUT4;
    input [1:0]ENABLE;
    output reg [31:0]OUTPUT; 

    //always block to SELECT inputs
    always @(*) begin
        
     
        case(ENABLE)

            2'b11: OUTPUT = INPUT4;
            2'b10: OUTPUT = INPUT3;
            2'b01: OUTPUT = INPUT2;
            default: OUTPUT = INPUT1;
        endcase

    end
endmodule



