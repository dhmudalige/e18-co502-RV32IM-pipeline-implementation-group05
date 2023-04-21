//ALU module 
//this module chooses the relevant result according to the select and pass it to final RESULT register
module alu(DATA1, DATA2, SELECT, RESULT);
    //port declarations
    input [31:0] DATA1, DATA2;
    input [4:0] SELECT;
    output reg [31:0] RESULT;    //RESULT should be a register because it stores the value

    wire [31:0] FORWARD_RESULT,ADD_RESULT,AND_RESULT, OR_RESULT, XOR_RESULT,SLL_RESULT, SRL_RESULT, SRA_RESULT,SUB_RESULT,  MUL_RESULT,MULH_RESULT, MULHU_RESULT, MULHSU_RESULT, DIV_RESULT, DIVU_RESULT, REM_RESULT, REMU_RESULT,SLT_RESULT, SLTU_RESULT;
   

    FORWARD unit1(DATA2,FORWARD_RESULT);       //create an instance of each FORWARD module
    ADD unit2(DATA1,DATA2,ADD_RESULT);     //create an instance of each ADD module
    AND unit3(DATA1,DATA2,AND_RESULT);     //create an instance of each AND module
    OR unit4(DATA1,DATA2,OR_RESULT);      //create an instance of each OR module
    XOR unit5(DATA1,DATA2,XOR_RESULT);      //create an instance of each OR module
    SLL unit6(DATA1,DATA2,SLL_RESULT);      //create an instance of each OR module
    SRL unit7(DATA1,DATA2,SRL_RESULT);      //create an instance of each OR module
    SRA unit8(DATA1,DATA2,SRA_RESULT);      //create an instance of each OR module
    SUB unit9(DATA1,DATA2,SUB_RESULT);      //create an instance of each OR module
    MUL unit10(DATA1,DATA2,MUL_RESULT);      //create an instance of each OR module
    MULH unit11(DATA1,DATA2,MULH_RESULT);      //create an instance of each OR module
    MULHU unit12(DATA1,DATA2,MULHU_RESULT);      //create an instance of each OR module
    MULHSU unit12(DATA1,DATA2,MULHSU_RESULT);      //create an instance of each OR module   
    DIV unit13(DATA1,DATA2,DIV_RESULT);      //create an instance of each OR module
    DIVU unit14(DATA1,DATA2,DIVU_RESULT);      //create an instance of each OR module
    REM unit15(DATA1,DATA2,REM_RESULT);      //create an instance of each OR module
    REMU unit16(DATA1,DATA2,REMU_RESULT);      //create an instance of each OR module
    SLT unit16(DATA1,DATA2,SLT_RESULT);      //create an instance of each OR module
    SLTU unit16(DATA1,DATA2,SLTU_RESULT);      //create an instance of each OR module
    

    //this block excutes when the signals in the sensitive list changes
    always @ (SELECT)
    begin
        case(SELECT)

        5'b00000: RESULT = FORWARD_RESULT;   //when select is 0000 assign the result of the FORWARD module
        5'b00001: RESULT = ADD_RESULT;   //when select is 0001 assign the result of the ADD module   
        5'b00010: RESULT = AND_RESULT;   //when select is 0010 assign the result of the AND module
        5'b00011: RESULT = OR_RESULT;   //when select is 0011 assign the result of the OR module
        5'b00100: RESULT = XOR_RESULT;   //when select is 0100 assign the result of the XOR module
        
        
        5'b00101: RESULT = SLL_RESULT;   //when select is 0101 assign the result of the Shift module
        5'b00110: RESULT = SRL_RESULT;   //when select is 0110 assign the result of the Mul module    
        5'b00111: RESULT = SRA_RESULT;   //when select is 0111 assign the result of the Division module  
        5'b01000: RESULT = SUB_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b01001: RESULT = MUL_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b01010: RESULT = MULH_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b01011: RESULT = MULHU_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b01100: RESULT = MULHSU_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b01101: RESULT = DIV_RESULT;   //when select is 0001 assign the result of the ADD module    
        
        5'b01110: RESULT = DIVU_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b01111: RESULT = REM_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b10000: RESULT = REMU_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b10001: RESULT = SLT_RESULT;   //when select is 0001 assign the result of the ADD module    
        5'b10010: RESULT = SLTU_RESULT;   //when select is 0001 assign the result of the ADD module    
        
        default RESULT = 8'bxxxxxxxx;   //default result is 8'bxxxxxxxx

        endcase
    end
endmodule


//FORWARD module
//this module send the operand value of data2 to the output
module FORWARD(data2,result1);
    //port declarations
    input [31:0] data2;
    // input [2:0] signal;
    output [31:0] result1;


    assign #1 result1 = data2;   //after 1 unit delay assign the value in data2 to result1
endmodule


//ADD module
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
    output [31:0] result5;

    assign #1 result4 = data1 ^ data2;   //after 1 unit delay perform bit wise xor on data1 and data2 and assign to the result4 
endmodule


module SLL(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result;

    assign #2 result = data1 << data2;   
endmodule

module SRL(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result;

    assign #2 result9 = data1 >> data2;   
endmodule

module SRA(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result;

    assign #2 result = data1 >>> data2; 
endmodule

module SUB(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result;

    assign #2 result = data1 - data2;   
endmodule

module MUL(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result;

    assign #2 result = data1 * data2;   
endmodule

module MULH(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    wire[63:0] temp_product;
    output [31:0] result;
    assign temp_product = data1 * data2;
    assign #2 result = temp_product>>32; 
endmodule

module MULHU(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    wire[63:0] temp_product;
    output [31:0] result;
    assign temp_product =$unsigned(data1) * $unsigned(data2);
    assign #2 result = temp_product>>32;   
endmodule

module MULHSU(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    wire[63:0] temp_product;
    output [31:0] result;
    assign temp_product =$signed(data1) * $signed(data2);
    assign #2 result = temp_product>>32; 
endmodule

module DIV(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
    output [31:0] result4;

    assign #1 result4 = data1 | data2;   //after 1 unit delay perform bit wise or on data1 and data2 and assign to the result4 
endmodule

module DIVU(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
  
    output [31:0] result;
    
    assign #2 result = $unsigned(data1) / $unsigned(data2);
endmodule

module REM(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
  
    output [31:0] result;
    
    assign #2 result = data1 % data2;   
    
endmodule

module REMU(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
  
    output [31:0] result;
    
    assign #2 result = $unsigned(data1) % $unsigned(data2);   
    
endmodule

module SLT(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;
  
    output [31:0] result;
    
    assign #2 result = ($signed(data1) < $signed(data1=2)) ? 32'd1 : 32'd0;   
    
endmodule

module SLTU(data1,data2,result);
    //port declarations
    input [31:0] data1,data2;

    output [31:0] result;

    
    assign #2 result = ($unsigned(data1) < $unsigned(data2)) ? 32'd1 : 32'd0;   
endmodule