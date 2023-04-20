//CONTROL UNIT

//timescale
`timescale  1ns/100ps

`include "alu.v"
`include "regfile.v"
`include "mux.v"
`include "adder.v"
`include "signExtend.v"
`include "dmem.v"



/*
 * control_unit module - 
 * check the opcode and
 * set alu operation , 
 * Set SUBflag to 1 if it is a sub operation
 * Set Immflag to 1 if it is a I type instruction
 *
 */



module control_unit(ALUOP,READ,WRITE,SELECTWRITE,SUBflag,IMMflag,Jumpflag,ShiftSignal,LOADSIGNAL,MULTSIGNAL,STORESIGNAL,BRANCHSIGNAL,WRITEENABLE,OPCODE,BUSYWAIT,INSTRUCTION);
    /*
    * Declare inputs and outputs
    *
    */
    input [7:0] OPCODE; 
    input [31:0] INSTRUCTION;
    input BUSYWAIT;

    output reg READ,WRITE,SELECTWRITE;
    output reg [3:0] ALUOP;
    output reg SUBflag,IMMflag,Jumpflag,WRITEENABLE;
    output reg [1:0]ShiftSignal;
    output reg [2:0]LOADSIGNAL;
    output reg [2:0]MULTSIGNAL;
    output reg [1:0]STORESIGNAL;
    output reg [2:0]BRANCHSIGNAL;

   
  
    
    //When busywait changes, 
    //if it is 0 , reset the READ and WRITE signals 
    always @ (BUSYWAIT) begin
        if(BUSYWAIT == 1'b0) begin
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
    SUBflag=0;
    IMMflag=0;
    LOADSIGNAL=0;
    STORESIGNAL=0;
    MULTSIGNAL=0;
    BRANCHSIGNAL=0;

    func7 = INSTRUCTION[31:25]
    func3 = INSTRUCTION[14:12]


        case (OPCODE)
            //LB, LH, LW, LBU, LHU, 
            7'b0000011 : begin
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
                ALUOP=4'b0000;   
                SELECTWRITE=1; 
                READ=1;                   
            end

            //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, 
            7'b0010011 : begin
                IMMflag=1;
                case (func3)
                    3'b000:  
                        ALUOP=4'b0001;
                        
                    3'b010:
                        ALUOP=4'b0001;
                        SUBflag=1; 

                    3'b011: 
                        ALUOP=4'b0001;
                        SUBflag=1; 
                    3'b100:
                        ALUOP=4'b0100;  //XORI
                  
                    3'b110:
                        ALUOP=4'b0011;   //ORI
                 
                    3'b111:
                        ALUOP=4'b0010;   //ANDI
                 
                    3'b001:
                        ALUOP=4'b0101;  //SLLI
           
                        ShiftSignal=0;
                    3'b101:
                        ALUOP=4'b0101; 
                        case (func7)
                            7'b0000000:
                                ShiftSignal=1;
                            7'b0100000: 
                                ShiftSignal=2;
                        
                    
                        endcase
                   
                endcase
               
                IMMflag=1;    
                WRITEENABLE=1;                 
            end

            //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, 
            7'b0110011 : begin
                case (func7)
                    7'b0100000: 
                        case (func3)
                            3'b000:        //sub instruction
                                ALUOP=4'b0001;  SUBflag=1; IMMflag=0;  
                                WRITEENABLE=1;
                            
                            3'b101:       //SRA
                                ALUOP=4'b0101; SUBflag=0; IMMflag=0; ShiftSignal =2;
                                WRITEENABLE=1;
                        endcase
                    7'b0000000: 
                        case (func3)
                            3'b000:        //ADD instruction
                                ALUOP=4'b0001; SUBflag=0; IMMflag=0;    
                                WRITEENABLE=1;
                            3'b001:        //SLL
                                ALUOP=4'b0101; SUBflag=0; IMMflag=0; ShiftSignal =0;
                                WRITEENABLE=1; 
                            3'b010:        //SLT
                                ALUOP=4'b0001; SUBflag=1; IMMflag=0; 
                                WRITEENABLE=1; 
                            3'b011:        //SLTU
                                ALUOP=4'b0001;
                                SUBflag=1; IMMflag=0; 
                                WRITEENABLE=1; 
                            3'b100:        //XOR
                                ALUOP=4'b0100; 
                                SUBflag=0; IMMflag=0; 
                                WRITEENABLE=1; 
                            3'b101:        //SRL
                                ALUOP=4'b0101; SUBflag=0; IMMflag=0; ShiftSignal =1;
                                WRITEENABLE=1; 
                            3'b110:        //OR
                                ALUOP=4'b0011;
                                SUBflag=0; IMMflag=0; 
                                WRITEENABLE=1;
                            3'b111:        //AND
                                ALUOP=4'b0010;
                                SUBflag=0; IMMflag=0; 
                                WRITEENABLE=1;
                        endcase
                    
                    //MUL, MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU

                    7'b0000001: 
                   
                        case (func3)
                            3'b000:        //MUL
                                ALUOP=4'b0110;
                                MULTSIGNAL=1;
                                
                            3'b001:        //MULH
                                ALUOP=4'b0110;
                                MULTSIGNAL=2;
                            3'b010:        //MULHSU
                                ALUOP=4'b0110;
                                MULTSIGNAL=3;
                            3'b011:        //MULHU
                                ALUOP=4'b0110;
                                MULTSIGNAL=4;
                            3'b100:        //DIV
                                ALUOP=4'b0111;
                            3'b101:        //DIVU
                                ALUOP=4'b0111;

                            ///////////////////////////////////////////////
                                //TODO
                            3'b110:        //REM
                            3'b111:        //REMU
                            //////////////////////////////////////////////
                        endcase
                        WRITEENABLE=1; 
                    
                endcase
                            
            end

            //SB, SH, SW, 
            7'b0100011 : begin
                ALUOP=3'b000;
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
                case (func3)
                    3'b000:  //BEQ---
                        BRANCHSIGNAL=1;
                        
                    3'b001:  //BNE--
                        BRANCHSIGNAL=2;

                    3'b100: 
                        BRANCHSIGNAL=3;
                        
                    3'b101:
                        BRANCHSIGNAL=4;
                    3'b110:
                        BRANCHSIGNAL=5;
                    3'b111: 
                        BRANCHSIGNAL=6;
                                                         
                endcase

                //It should goes to add in alu and subflag should be 1 
                //because here the operation is subtract
                ALUOP=3'b001; SUBflag=1; IMMflag=0; 
                //Writing is disable
                WRITEENABLE=0; 
                            
            end



            //LUI
            7'b0110111 : begin

                ALUOP=4'b0000;
                LOADSIGNAL=6;                           
                IMMflag=1;    
                WRITEENABLE=1;      
                         
            end

            ///////////////////////////////////////////////
            //TODO
            
            //AUIPC
            7'b0010111 : begin
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end
            ///////////////////////////////////////////////

            //JAL-----
            7'b1101111 : begin
                Jumpflag=1;
                          
            end

            //JALR
            7'b1100111 : begin
                Jumpflag=1;
                              
            end

          
    
        endcase
        
    end
    
endmodule
//-----------------------------------------------------------------------------------------------------------



//---------------------------------TEST BENCH FOR CPU--------------------------------------------------------

module cpu_tb;
    //registers and wires to store PC value, Instruction and clock,reset signals
    reg CLK, RESET;
    wire [31:0] PC;
    wire [31:0] INSTRUCTION;
    wire [7:0] ADDRESS,WRITEDATA,READDATA;
    wire READ,WRITE,BUSYWAIT;
    
    /* 
    ------------------------
     SIMPLE INSTRUCTION MEM
    ------------------------
    */
    
    // Initialize an array of registers (8x1024) named 'instr_mem' to be used as instruction memory
    reg [31:0] instr_mem[1023:0];
    // Create combinational logic to support CPU instruction fetching, given the Program Counter(PC) value 
    //      
    /*
     * Instruction memory read(#2 - two time unit delay)-instruction fetching
     */
    assign #2  INSTRUCTION[7:0]=instr_mem[PC];
    assign #2  INSTRUCTION[15:8]=instr_mem[PC+1];
    assign #2  INSTRUCTION[23:16]=instr_mem[PC+2];
    assign #2  INSTRUCTION[31:24]=instr_mem[PC+3];
    

    initial
    begin
        // Initialize instruction memory with the set of instructions you need execute on CPU       
        // loading instr_mem content from instr_mem.mem file
        $readmemb("programmer/instr_mem.mem", instr_mem);

    end
    //======================changes=============================================================
    /* 
    -----
     CPU
    -----
    */
    //Create a instance of cpu
    cpu cpu1(PC, WRITEDATA, READ, WRITE, ADDRESS, INSTRUCTION, CLK, RESET, READDATA, BUSYWAIT);
    
    //create instance of data memory
    data_memory dmem1(CLK, RESET,READ,WRITE,ADDRESS,WRITEDATA,READDATA,BUSYWAIT);

    //==========================================================================================

    initial
    begin
        $monitor($time,"Contents of Mem after reading data file: %b \n",INSTRUCTION);
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpu_wavedata.vcd");
		$dumpvars(0, cpu_tb);
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // Reset the CPU (by giving a pulse to RESET signal) to start the program execution
        #2 RESET= 1'b1;    //Reset the cpu to start
        #5 RESET= 1'b0;

        // finish simulation after some time
        #800
        $finish;
        
    end
    
    // clock signal generation
    always
        //Clock cycle is 8 time units so it should be change after 4 time units
        #4 CLK = ~CLK;
        
endmodule

//-----------------------------------------------------------------------------------------------------------


