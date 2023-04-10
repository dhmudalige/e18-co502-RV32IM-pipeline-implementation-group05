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



module control_unit(ALUOP,READ,WRITE,SELECTWRITE,SUBflag,IMMflag,Jumpflag,BEQflag,BNEQflag,ShiftSignal,WRITEENABLE,OPCODE,BUSYWAIT,INSTRUCTION);
    /*
    * Declare inputs and outputs
    *
    */
    input [7:0] OPCODE; 
    input [31:0] INSTRUCTION;
    input BUSYWAIT;

    output reg READ,WRITE,SELECTWRITE;
    output reg [2:0] ALUOP;
    output reg SUBflag,IMMflag,Jumpflag,BEQflag,BNEQflag,WRITEENABLE;
    output reg [1:0]ShiftSignal;
  
    
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
    BEQflag=0;
    BNEQflag=0;
    SELECTWRITE=0;
    WRITEENABLE=0;
    SUBflag=0;
    IMMflag=0;

    func7 = INSTRUCTION[31:25]
    func3 = INSTRUCTION[14:12]


        case (OPCODE)
            //LB, LH, LW, LBU, LHU, 
            7'b0000011 : begin
                case (func3)
                    3'b000:  //LB
                    3'b001:  //LH
                    3'b010:  //LW
                    3'b100:  //LBU
                    3'b101:  //LHU
                   
                endcase
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end

            //ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI, 
            7'b0010011 : begin
                case (func3)
                    3'b000:       
                    3'b010: 
                    3'b011: 
                    3'b100:
                    3'b110:
                    3'b111:
                    3'b001:
                    3'b101:
                        case (func7)
                            7'b0000000:
                            7'b0100000: 
                        
                    
                        endcase
                   
                endcase
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end

            //ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, 
            7'b0110011 : begin
                case (func7)
                    7'b0100000: 
                        case (func3)
                            3'b000:        //sub instruction
                                ALUOP=3'b001; SUBflag=1; IMMflag=0;  
                                WRITEENABLE=1;
                            
                            3'b101:       //SRA
                                ALUOP=3'b101; SUBflag=0; IMMflag=0; ShiftSignal =2;
                                WRITEENABLE=1;
                        endcase
                    7'b0000000: 
                        case (func3)
                            3'b000:        //ADD instruction
                                ALUOP=3'b001; SUBflag=0; IMMflag=0;    
                                WRITEENABLE=1;
                            3'b001:        //SLL
                                ALUOP=3'b101; SUBflag=0; IMMflag=0; ShiftSignal =0;
                                WRITEENABLE=1; 
                            3'b010:        //SLT
                            3'b011:        //SLTU
                            3'b100:        //XOR
                            3'b101:        //SRL
                                ALUOP=3'b101; SUBflag=0; IMMflag=0; ShiftSignal =1;
                                WRITEENABLE=1; 
                            3'b110:        //OR
                            3'b111:        //AND
                        endcase
                    
                    //MUL, MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU

                    7'b0000001: 
                        case (func3)
                            3'b000:        //MUL
                                ALUOP=3'b100; SUBflag=0; IMMflag=0; 
                                WRITEENABLE=1; 
                            3'b001:        //MULH
                            3'b010:        //MULHSU
                            3'b011:        //MULHU
                            3'b100:        //DIV
                            3'b101:        //DIVU
                            3'b110:        //REM
                            3'b111:        //REMU
                        endcase
                    
                endcase
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end

            //SB, SH, SW, 
            7'b0100011 : begin
                case (func3)
                    3'b000:        //SB
                        
                    3'b001:        //SH
                    3'b010:        //SW
                    
                endcase
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end

            //BEQ, BNE, BLT, BGE, BLTU, BGEU
            7'b1100011 : begin
                case (func3)
                    3'b000:  //BEQ---
                        //It should goes to add in alu and subflag should be 1 
                        //because here the operation is subtract
                        ALUOP=3'b001; SUBflag=1; IMMflag=0; 
                        //BEQflag to identify the beq instruction
                        BEQflag=1;
                        //Writing is disable
                        WRITEENABLE=0; 
                    3'b001:  //BNE--
                        //It should goes to add in alu and subflag should be 1 
                        //because here the operation is subtract
                        ALUOP=3'b001; SUBflag=1; IMMflag=0; 
                        BNEQflag=1;
                        //Writing is disable
                        WRITEENABLE=0; 
                    3'b100: 
                    3'b101:
                    3'b110:
                    3'b111: 
                   
                        
                    
                endcase
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end
            //LUI
            7'b0110111 : begin
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end
            
            //AUIPC
            7'b0010111 : begin
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end

            //JAL-----
            7'b1101111 : begin
                // SUBflag=0; IMMflag=0; Jumpflag=1;    
                // WRITEENABLE=0;                 
            end

            //JALR
            7'b1100111 : begin
                // ALUOP=3'b000; SUBflag=0; IMMflag=1;    
                // WRITEENABLE=1;                 
            end

            






            

            
            

           


            
            // //====================changes======================================
            // //If it is a lwd instruction
            // 8'b00001000 : begin
                
            //     ALUOP=3'b000; IMMflag=0;    
            //    // WRITEENABLE=1; 
            //     READ=1;           
            //     WRITE=0;
            //     SELECTWRITE=1;
            //     Jumpflag=0;
            //     BEQflag=0;
            //     BNEQflag=0;
                
            // end
            // //If it is a lwi instruction
            // 8'b00001001 : begin
                
            //     ALUOP=3'b000; IMMflag=1;
            //   // WRITEENABLE=1; 
            //     READ=1;
            //     WRITE=0;
            //     SELECTWRITE=1;
            //     Jumpflag=0;
            //     BEQflag=0;
            //     BNEQflag=0;
            // end

            // //If it is a swd instruction
            // 8'b00001010 : begin
                
            //     ALUOP=3'b000; IMMflag=0;
            //     WRITEENABLE=0; 
            //     READ=0;
            //     WRITE=1;
            //     Jumpflag=0;
            //     BEQflag=0;
            //     BNEQflag=0;
            //     SELECTWRITE=0;
                
            // end

            // //If it is a swi instruction
            // 8'b00001011 : begin
                
            //     ALUOP=3'b000; IMMflag=1; 
            //     WRITEENABLE=0; 
            //     READ=0;
            //     WRITE=1; 
            //     Jumpflag=0;
            //     BEQflag=0;
            //     BNEQflag=0;
            //     SELECTWRITE=0;
                
            // end

            // //==========================================================================
    
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


