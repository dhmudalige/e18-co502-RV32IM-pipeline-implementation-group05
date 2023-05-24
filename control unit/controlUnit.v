//CONTROL UNIT

//timescale
`timescale  1ns/100ps



/*
 * control_unit module - 
 * check the opcode and
 * set alu operation , 
 * Set SUBflag to 1 if it is a sub operation
 * Set Immflag to 1 if it is a I type instruction
 *
 */



module control_unit(ALUOP,READ,WRITE,SELECTWRITE,IMMflag,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,WRITEENABLE,OPCODE,BUSYWAIT,func3,func7);
    /*
    * Declare inputs and outputs
    *
    */
    input [31:0] INSTRUCTION;
    input [6:0] OPCODE; 
    input [2:0] func3;
    input [6:0] func7;
    input BUSYWAIT;

    output reg READ,WRITE,SELECTWRITE,IMMflag,Jumpflag,WRITEENABLE;
    output reg [4:0] ALUOP;  
    output reg [2:0]LOADSIGNAL,BRANCHSIGNAL; 
    output reg [1:0]STORESIGNAL;


   
  
    
    //When busywait changes, 
    //if it is 0 , reset the READ and WRITE signals 
    always @ (BUSYWAIT) begin
        if(BUSYWAIT == 1'b0) begin
            #1
            READ = 1'b0;
            WRITE = 1'b0;
            if(OPCODE==8'b00001001) begin
                WRITEENABLE=1;
           
            end
            
            
        end
    end

    /*
    * Always when opcode changes 
    * set ALUOP,SUBflag ,IMMflag
    *
    */
    always @ (OPCODE,INSTRUCTION) begin
    //set 1 time unit delay for instruction decoding
    #1;
    Jumpflag=0;
  
    SELECTWRITE=0;
    WRITEENABLE=0;
    IMMflag=0;
    LOADSIGNAL=0;
    STORESIGNAL=0;
    BRANCHSIGNAL=0;
 
        case (OPCODE)
            //LB, LH, LW, LBU, LHU,
            7'b0000011 : begin
                #1;
                case (func3)
                    3'b000:  //LB
                        LOADSIGNAL=1;
                    3'b001:  //LH
                        LOADSIGNAL=2;
                    3'b010:  //LW
                        LOADSIGNAL=3;
                    3'b100:  //LBU
                        LOADSIGNAL=4;
                    3'b101:  //LHU
                        LOADSIGNAL=5;
                   
                endcase
                ALUOP=4'b0001;   
                SELECTWRITE=1; 
                READ=1;                   
            end

            //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, 
            7'b0010011 : begin
                #1;
                IMMflag=1;
                case (func3)
                    3'b000:  
                        ALUOP= 5'b00001;
                        
                    3'b010:
                        ALUOP=5'b10001;
                      

                    3'b011: 
                        ALUOP=5'b10010;
                     
                    3'b100:
                        ALUOP=5'b00100;  //XORI
                  
                    3'b110:
                        ALUOP=5'b00011;   //ORI
                 
                    3'b111:
                        ALUOP=5'b00010;   //ANDI
                 
                    3'b001:
                        ALUOP=5'b00101;  //SLLI
           
                       
                    3'b101:
                        
                        case (func7)
                            7'b0000000:
                                ALUOP=5'b00110;  //SRLI

                            7'b0100000: 
                                ALUOP=5'b00111;  //SRAI
                        
                    
                        endcase
                   
                endcase
               
                IMMflag=1;    
                WRITEENABLE=1;                 
            end

            //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, 
            7'b0110011 : begin
                #1;
                case (func7)
                    7'b0100000: 
                        case (func3)
                            3'b000:        //sub instruction
                                begin
                                ALUOP=5'b01000; IMMflag=0;
                                WRITEENABLE=1;
                                end
                            
                            3'b101:       //SRA
                                begin
                                ALUOP=5'b00111;
                                IMMflag=0;
                                WRITEENABLE=1;
                                end
                        endcase
                    7'b0000000: 
                        case (func3)
                            3'b000:        //ADD instruction
                                begin
                                ALUOP=5'b00001;  IMMflag=0;    
                                WRITEENABLE=1;
                                end
                            3'b001:        //SLL
                                begin
                                ALUOP=5'b00101; IMMflag=0; 
                                WRITEENABLE=1; 
                                end
                            3'b010:        //SLT
                                begin
                                ALUOP=5'b10001;  IMMflag=0; 
                                WRITEENABLE=1; 
                                end
                            3'b011:        //SLTU
                                begin
                                ALUOP=5'b10010;
                                IMMflag=0; 
                                WRITEENABLE=1; 
                                end
                            3'b100:        //XOR
                                begin
                                ALUOP=5'b00100;
                                IMMflag=0; 
                                WRITEENABLE=1; 
                                end
                            3'b101:        //SRL
                                begin
                                ALUOP= 5'b00110; IMMflag=0;
                                WRITEENABLE=1; 
                                end
                            3'b110:        //OR
                                begin
                                ALUOP= 5'b00011;
                                IMMflag=0; 
                                WRITEENABLE=1;
                                end
                            3'b111:        //AND
                                begin
                                ALUOP= 5'b00010;
                                IMMflag=0; 
                                WRITEENABLE=1;
                                end
                        endcase
                    
                    //MUL, MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU

                    7'b0000001: begin
                        WRITEENABLE=1; 
                      
                        case (func3)
                            3'b000:        //MUL
                                ALUOP=5'b01001;
                                
                                
                            3'b001:        //MULH
                                ALUOP=5'b01010;
                                
                            3'b010:        //MULHSU
                                ALUOP= 5'b01100;
                               
                            3'b011:        //MULHU
                                ALUOP=5'b01011;
                              
                            3'b100:        //DIV
                                ALUOP=5'b01101;
                            3'b101:        //DIVU
                                ALUOP=5'b01110;

                            3'b110:        //REM
                                ALUOP=5'b01111;


                            3'b111:        //REMU
                                ALUOP=5'b10000;

                            
                        endcase
                    end

                        
                     
                    
                endcase
                            
            end

            //SB, SH, SW, 
            7'b0100011 : begin
                #1;
                ALUOP=5'b00000;
                case (func3)
                    3'b000:        //SB
                        STORESIGNAL=1;
                        
                    3'b001:        //SH
                        STORESIGNAL=2;
                    3'b010:        //SW
                        STORESIGNAL=3;
                    
                endcase
                READ = 0;
                WRITE = 1;
                             
            end

            //BEQ, BNE, BLT, BGE, BLTU, BGEU
            7'b1100011 : begin
                #1;
                case (func3)
                    3'b000:  //BEQ---
                    begin
                        BRANCHSIGNAL=1;
                        ALUOP=5'b01000; 
                        end
                    3'b001:  //BNE--
                    begin
                        BRANCHSIGNAL=2;
                        ALUOP=5'b01000; 
                        end


                    3'b100: 
                    begin
                        BRANCHSIGNAL=3;
                        ALUOP=5'b10001; 
                        end

                        
                    3'b101:
                    begin
                        BRANCHSIGNAL=4;
                        ALUOP=5'b10001; 
                        end

                    3'b110:
                    begin
                        BRANCHSIGNAL=5;
                        
                        ALUOP=5'b10010; 
                        end

                    3'b111: 
                    begin
                        BRANCHSIGNAL=6;
                        ALUOP=5'b10010; 
                        end

                                                         
                endcase

                
                IMMflag=0; 
                //Writing is disable
                WRITEENABLE=0; 
                            
            end



            //LUI
            7'b0110111 : begin
                #1;

                ALUOP=5'b00000;
                LOADSIGNAL=6;                           
                IMMflag=1;    
                WRITEENABLE=1;      
                         
            end

           
            //AUIPC
            7'b0010111 : begin
                #1;
                ALUOP=5'b00001;
                LOADSIGNAL=6; 
                IMMflag=1;    
                WRITEENABLE=1;                 
            end
            //JAL-----
            7'b1101111 : begin
                #1;
                Jumpflag=1;
                          
            end

            //JALR
            7'b1100111 : begin
                #1;
                Jumpflag=1;
                              
            end

          
    
        endcase
        
    end
    
endmodule
//-----------------------------------------------------------------------------------------------------------




