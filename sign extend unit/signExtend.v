
/*
 * signExtend module - 
 * 
 */
module signExtend(INSTRUCTION,OUTPUT);
    //declare input,output
    input [31:0] INSTRUCTION;           
    
    output reg[31:0] OUTPUT;    
   
    always @(*) begin
        #1;
     
        //------------sign extending----------------

        case (INSTRUCTION[6:0] )
            
            //LOAD
            7'b0000011: 
                assign OUTPUT = {{21{INSTRUCTION[31]}},INSTRUCTION[30:20]};
            //JALR
            7'b1100111 : 
                assign OUTPUT = {{21{INSTRUCTION[31]}},INSTRUCTION[30:20]};
            //I TYPE
            7'b0010011:
                assign OUTPUT = {{21{INSTRUCTION[31]}},INSTRUCTION[30:20]};

            //STORE
            7'b0100011:
                assign OUTPUT = {{21{INSTRUCTION[31]}},INSTRUCTION[30:25],INSTRUCTION[11:7]};
            
            //B TYPE
            7'b1100011:
                assign OUTPUT = {{19{INSTRUCTION[31]}},INSTRUCTION[7],INSTRUCTION[30:25],INSTRUCTION[11:8],2'b00};
            
            //LUI
            7'b0110111 :
                assign OUTPUT = {INSTRUCTION[31:12],{12{1'b0}}};
            //AUIPC
            7'b0010111:
                assign OUTPUT = {INSTRUCTION[31:12],{12{1'b0}}};
            //JAL
            7'b1101111 :
                assign OUTPUT = {{12{INSTRUCTION[31]}},INSTRUCTION[19:12],INSTRUCTION[20],INSTRUCTION[30:21],1'b0};

            
            
        endcase


      


    end

endmodule

//-----------------------------------------------------------------------------------------------------------
