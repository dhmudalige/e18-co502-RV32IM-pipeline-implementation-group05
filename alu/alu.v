//ALU module 
//this module chooses the relevant result according to the select and pass it to final RESULT register
module alu(DATA1, DATA2, SELECT, RESULT);
    //port declarations
    input [31:0] DATA1, DATA2;
    input [4:0] SELECT;
    output reg [31:0] RESULT;    //RESULT should be a register because it stores the value

    wire [31:0] ADD_RESULT, SLT_RESULT, SLTU_RESULT, AND_RESULT, OR_RESULT, XOR_RESULT, SLL_RESULT, SRL_RESULT, SUB_RESULT, SRA_RESULT, MUL_RESULT, MULHU_RESULT, MULHSU_RESULT, DIV_RESULT, DIVU_RESULT, REM_RESULT, REMU_RESULT;
    wire [63:0] MULH_RESULT;

    FORWARD unit1(DATA2,RESULT1);       //create an instance of each FORWARD module
    ADD unit2(DATA1,DATA2,RESULT2);     //create an instance of each ADD module
    AND unit3(DATA1,DATA2,RESULT3);     //create an instance of each AND module
    OR unit4(DATA1,DATA2,RESULT4);      //create an instance of each OR module
    

    //this block excutes when the signals in the sensitive list changes
    always @ (SELECT, RESULT1, RESULT2, RESULT3, RESULT4)
    begin
        case(SELECT)

        5'b0000: RESULT = RESULT1;   //when select is 0000 assign the result of the FORWARD module
        5'b0001: RESULT = RESULT2;   //when select is 0001 assign the result of the ADD module
        5'b0001: RESULT = RESULT2;   //when select is 0001 assign the result of the ADD module    
        5'b0010: RESULT = RESULT3;   //when select is 0010 assign the result of the AND module
        5'b0011: RESULT = RESULT4;   //when select is 0011 assign the result of the OR module
        5'b0100: RESULT = RESULT5;   //when select is 0100 assign the result of the XOR module
        5'b0101: RESULT = RESULT6;   //when select is 0101 assign the result of the Shift module
        5'b0110: RESULT = RESULT6;   //when select is 0110 assign the result of the Mul module    
        5'b0111: RESULT = RESULT6;   //when select is 0111 assign the result of the Division module  

        default RESULT = 8'bxxxxxxxx;   //default result is 8'bxxxxxxxx

        endcase
    end
endmodule


//FORWARD module
//this module send the operand value of data2 to the output
module FORWARD(data2,result1,signal);
    //port declarations
    input [31:0] data2;
    input [2:0] signal;
    output [31:0] result1;


    assign #1 result1 = data2;   //after 1 unit delay assign the value in data2 to result1
endmodule


//AND module
//this module add the operand values of data1 and data2 and send the result to the output
module ADD(data1,data2,result2);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result2;

    assign #2 result2 = data1 + data2;   //after 2 unit delay assign the addition of data1 and data2 to result2
endmodule


//AND module
//this module perforn the bit wise AND on data1 with data2 and send the result to the output
module AND(data1,data2,result3);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result3;

    assign #1 result3 = data1 & data2;   //after 1 unit delay perform bit wise and on data1 and data2 and assign to the result3
endmodule


//OR module
//this module perforn the bit wise OR on data1 with data2 and send the result to the output
module OR(data1,data2,result4);
    //port declarations  
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 | data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule


module XOR(data1,data2,result5);
    //port declarations  
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 ^ data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule


module Shift(data1,data2,result6,signal);
    //port declarations  
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 | data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule


module Mul(data1,data2,result7,signal);
    //port declarations  
    input [31:0] data1,data2;
    input [1:0] signal;
    output [31:0] result4;

    
    assign #3 MUL_RESULT = DATA1 * DATA2;       // Multiplication
    assign #3 MULH_RESULT = DATA1 * DATA2;      // Multiplication High Signed x Signed
    assign #3 MULHU_RESULT = $unsigned(DATA1) * $unsigned(DATA2);     // Multiplication High Unsigned x Unsigned
    assign #3 MULHSU_RESULT = $signed(DATA1) * $unsigned(DATA2);     // Multiplication High Signed x UnSigned
endmodule