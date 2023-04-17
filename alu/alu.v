//testbench module
/* module testbench;
    //declare wires and registers
    reg [31:0] OPERAND1, OPERAND2;
    reg [2:0] ALUOP;
    wire [31:0] ALURESULT;
    
    //crate an instance of alu module
    alu unit(OPERAND1, OPERAND2, ALUOP, ALURESULT);

    //behavioural block initial
    initial
    begin
        //monitor the values
        $monitor($time," operand1: %b, operand2: %b, aluop: %b, aluresult: %b",OPERAND1, OPERAND2, ALUOP, ALURESULT);
        //dump the results
        $dumpfile("wavedata.vcd");
        $dumpvars(0,testbench);

        //assign values to inputs
        OPERAND1 <= 8'b00000101; OPERAND2 <= 8'b00000010; ALUOP <= 4'b0000;
        #10
        OPERAND1 <= 8'b00000101; OPERAND2 <= 8'b00000010; ALUOP <= 4'b0000;
        #10
        OPERAND1 <= 8'b00000101; OPERAND2 <= 8'b00000010; ALUOP <= 4'b0100;
        #10
        OPERAND1 <= 8'b00000101; OPERAND2 <= 8'b00001001; ALUOP <= 4'b0101;
        #10
        OPERAND1 <= 8'b00000101; OPERAND2 <= 8'b00001001; ALUOP <= 4'b1000;

        #10 $finish; 

    end
endmodule */


//ALU module 
//this module chooses the relevant result according to the select and pass it to final RESULT register
module alu(DATA1, DATA2, SELECT, RESULT);
    //port declarations
    input [31:0] DATA1, DATA2;
    input [3:0] SELECT;
    output reg [31:0] RESULT;    //RESULT should be a register because it stores the value
    wire [31:0] RESULT1, RESULT2, RESULT3, RESULT4;
    
    FORWARD unit1(DATA2,RESULT1);       //create an instance of each FORWARD module
    ADD unit2(DATA1,DATA2,RESULT2);     //create an instance of each ADD module
    AND unit3(DATA1,DATA2,RESULT3);     //create an instance of each AND module
    OR unit4(DATA1,DATA2,RESULT4);      //create an instance of each OR module
    

    //this block excutes when the signals in the sensitive list changes
    always @ (SELECT, RESULT1, RESULT2, RESULT3, RESULT4)
    begin
        case(SELECT)

        4'b0000: RESULT = RESULT1;   //when select is 0000 assign the result of the FORWARD module
        4'b0001: RESULT = RESULT2;   //when select is 0001 assign the result of the ADD module
        4'b0010: RESULT = RESULT3;   //when select is 0010 assign the result of the AND module
        4'b0011: RESULT = RESULT4;   //when select is 0011 assign the result of the OR module
        4'b0100: RESULT = RESULT5;   //when select is 0100 assign the result of the XOR module
        4'b0101: RESULT = RESULT6;   //when select is 0101 assign the result of the Shift module
        4'b0110: RESULT = RESULT6;   //when select is 0110 assign the result of the Mul module    
        4'b0111: RESULT = RESULT6;   //when select is 0111 assign the result of the Division module  

        default RESULT = 8'bxxxxxxxx;   //default result is 8'bxxxxxxxx

        endcase
    end
endmodule


//FORWARD module
//this module send the operand value of data2 to the output
module FORWARD(data2,result1);
    //port declarations
    input [31:0] data2;
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


module XOR(data1,data2,result4);
    //port declarations  
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 ^ data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule


module Shift(data1,data2,result4);
    //port declarations  
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 | data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule


module Mul(data1,data2,result4);
    //port declarations  
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 | data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule