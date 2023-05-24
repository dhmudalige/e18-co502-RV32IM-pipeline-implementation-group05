`timescale 1ns/100ps

`include "../control_unit/control_unit.v"
`include "../alu/alu.v"
`include "../adder/adder.v"
`include "../register_file/register_file.v"
`include "../data_cache/data_cache.v"
`include "../instruction_cache/instruction_cache.v"
// `include "../immediate_select/immediate_select.v"
// `include "../branch_select/branch_select.v"
`include "../branching_unit/branch_logics.v"
// `include "../mux/mux3bit_2to1.v"
`include "../mux/mux32bit_2to1.v"
`include "../mux/mux32bit_4to1.v"
// `include "../forwarding_unit/stage3_forward.v"
// `include "../forwarding_unit/stage4_forward.v"
`include "../pipeline_registers/if_id_pipeline_reg.v"
`include "../pipeline_registers/id_ex_pipeline_reg.v"
`include "../pipeline_registers/ex_mem_pipeline_reg.v"
`include "../pipeline_registers/mem_wb_pipeline_reg.v"


module cpu(PC, INSTRUCTION, CLK, RESET, MEM_READ_EN, MEM_WRITE_EN, DATA_CACHE_ADDR, DATA_CACHE_DATA, DATA_CACHE_READ_DATA, DATA_CACHE_BUSY_WAIT,
            INS_READ_EN, INS_CACHE_BUSY_WAIT);

    input [31:0] INSTRUCTION; //fetched INSTRUCTIONtructions
    input CLK, RESET; // clock and reset for the cpu
    input DATA_CACHE_BUSY_WAIT; // busy wait signal from the memory
    input INS_CACHE_BUSY_WAIT; // busy wait from the instruction memory
    input [31:0] DATA_CACHE_READ_DATA; // input from the memory read
    output reg [31:0] PC; //programme counter
    output [3:0] MEM_READ_EN; // control signal to the data memory
    output [2:0] MEM_WRITE_EN; // control signal to the data memory
    output reg INS_READ_EN; // read enable for the instruction read
    output [31:0] DATA_CACHE_ADDR, DATA_CACHE_DATA; // output signal to the memory (address and the write data input)



//************************** STAGE 1 **************************
    // data lines
    reg [31:0] PR_INSTRUCTION, PR_PC_S1;

    wire [31:0] PC_PLUS_4, PC_NEXT;

    mux32bit_2to1 Group5MUXJump (PC_PLUS_4, ALU_OUT, PC_NEXT, BRANCH_SELECT_OUT);

    assign PC_PLUS_4 = PC + 4;
    

//************************** STAGE 2 **************************
    // data lines
    reg [31:0] PR_PC_S2, PR_DATA_1_S2, PR_DATA_2_S2, PR_IMMEDIATE_SELECT_OUT;
    reg [4:0] PR_REGISTER_WRITE_ADDR_S2;
    
    // for the fowarding unit
    reg [4:0] REG_READ_ADDR1_S2, REG_READ_ADDR2_S2;

    // control lines
    reg [3:0] PR_BRANCH_SELECT_S2, PR_MEM_READ_S2;
    reg [4:0] PR_ALU_SELECT;
    reg PR_OPERAND1_SEL, PR_OPERAND2_SEL;
    reg [2:0] PR_MEM_WRITE_S2; 
    reg [1:0] PR_REG_WRITE_SELECT_S2;
    reg PR_REG_WRITE_EN_S2; 

    wire [31:0] DATA1_S2, DATA2_S2, IMMEDIATE_OUT_S2; 
    wire [3:0] IMMEDIATE_SELECT;
    wire [3:0] BRANCH_SELECT, MEM_READ_S2;
    wire [4:0] ALU_SELECT;
    wire OPERAND1_SEL, OPERAND2_SEL;
    wire [2:0] MEM_WRITE_S2; 
    wire [1:0] REG_WRITE_SELECT_S2;
    wire REG_WRITE_EN_S2; 

    reg_file Group5RegFile (REG_WRITE_DATA, 
                    DATA1_S2, 
                    DATA2_S2, 
                    PR_REGISTER_WRITE_ADDR_S4, 
                    PR_INSTRUCTION[19:15], 
                    PR_INSTRUCTION[24:20], 
                    PR_REG_WRITE_EN_S4, 
                    CLK, 
                    RESET);

    immediate_select Group5ImmSelect (PR_INSTRUCTION, IMMEDIATE_SELECT, IMMEDIATE_OUT_S2);
    
    control_unit Group5ControlUnit (PR_INSTRUCTION, 
                            ALU_SELECT, 
                            REG_WRITE_EN_S2, 
                            MEM_WRITE_S2, 
                            MEM_READ_S2, 
                            BRANCH_SELECT, 
                            IMMEDIATE_SELECT, 
                            OPERAND1_SEL, 
                            OPERAND2_SEL, 
                            REG_WRITE_SELECT_S2, 
                            RESET);


//************************** STAGE 3 **************************
    reg [31:0] PR_PC_S3, PR_ALU_OUT_S3, PR_DATA_2_S3;
    reg [4:0] PR_REGISTER_WRITE_ADDR_S3;
    
    reg [4:0] REG_READ_ADDR2_S3;  // for Stage 4 fowarding 

    // control lines
    reg [3:0] PR_MEM_READ_S3;
    reg [2:0] PR_MEM_WRITE_S3; 
    reg [1:0] PR_REG_WRITE_SELECT_S3;
    reg PR_REG_WRITE_EN_S3; 

    wire[31:0] ALU_IN_1, ALU_IN_2;
    wire[31:0] ALU_OUT;
    wire BRANCH_SELECT_OUT;

    mux32bit_2to1 Group5Operand1MUX (PR_PC_S2, ALU_IN_1, PR_OPERAND1_SEL);
    mux32bit_2to1 Group5Operand2MUX (PR_IMMEDIATE_SELECT_OUT, ALU_IN_2, PR_OPERAND2_SEL);
    
    alu Group5ALU (ALU_IN_1, ALU_IN_2, ALU_OUT, PR_ALU_SELECT);
    // branch_select Group5BranchSelect(PR_BRANCH_SELECT_S2, BRANCH_SELECT_OUT);

    // stage3_forward Group5_Stage3_Fowarding (PR_MEM_WRITE_S2[2], 
    //                                         REG_READ_ADDR1_S2, 
    //                                         REG_READ_ADDR2_S2, 
    //                                         PR_OPERAND1_SEL, 
    //                                         PR_OPERAND2_SEL, 
    //                                         PR_REGISTER_WRITE_ADDR_S3, 
    //                                         PR_REG_WRITE_EN_S3, 
    //                                         PR_REGISTER_WRITE_ADDR_S4, 
    //                                         PR_REG_WRITE_EN_S4,  
    //                                         PR_REGISTER_WRITE_ADDR_S5, 
    //                                         PR_REG_WRITE_EN_S5);


//************************** STAGE 4 **************************
    // data lines
    reg [31:0] PR_PC_S4, PR_ALU_OUT_S4, PR_DATA_CACHE_OUT;
    reg [4:0] PR_REGISTER_WRITE_ADDR_S4;

    // control lines
    reg [1:0] PR_REG_WRITE_SELECT_S4;
    reg PR_REG_WRITE_EN_S4; 
    reg [3:0] PR_MEM_READ_S4;

    wire [31:0] PC_PLUS_4_2;

    assign DATA_CACHE_ADDR = PR_ALU_OUT_S3;
    assign MEM_WRITE_EN = PR_MEM_WRITE_S3;
    assign MEM_READ_EN = PR_MEM_READ_S3;

    // stage4_forward Group5_Stage4_Forwarding(REG_READ_ADDR2_S3, 
    //                                         PR_REGISTER_WRITE_ADDR_S4, 
    //                                         PR_MEM_WRITE_S3[2], 
    //                                         PR_MEM_READ_S4[3]);

    mux32bit_2to1 Group5Stage4ForwardingMUX(PR_DATA_2_S3, PR_DATA_CACHE_OUT);


//************************** STAGE 5 **************************

    // data lines
    reg [31:0] REG_WRITE_DATA_S5;
    reg [4:0] PR_REGISTER_WRITE_ADDR_S5;

    // control lines
    reg PR_REG_WRITE_EN_S5; 
    
    wire [31:0] REG_WRITE_DATA;
    mux32bit_4to1 Group5RegWriteSELMUX (PR_DATA_CACHE_OUT, PR_ALU_OUT_S4, 32'b0, PR_PC_S4, REG_WRITE_DATA, PR_REG_WRITE_SELECT_S4);

// register updating section
always @(posedge CLK) begin
    #1
    if (!(DATA_CACHE_BUSY_WAIT || INS_CACHE_BUSY_WAIT)) begin
        //************************** Tempary stage for Write Back fowarding **************************
        // #0.0001
        // REG_WRITE_DATA_S5 = REG_WRITE_DATA;
        // PR_REGISTER_WRITE_ADDR_S5 = PR_REGISTER_WRITE_ADDR_S4;

        // PR_REG_WRITE_EN_S5 = PR_REG_WRITE_EN_S4;

        //************************** STAGE 4 **************************
        #0.001
        PR_REGISTER_WRITE_ADDR_S4 = PR_REGISTER_WRITE_ADDR_S3;
        PR_PC_S4 = PR_PC_S3;
        PR_ALU_OUT_S4 = PR_ALU_OUT_S3;
        PR_DATA_CACHE_OUT = DATA_CACHE_READ_DATA;
        
        PR_REG_WRITE_SELECT_S4  = PR_REG_WRITE_SELECT_S3;
        PR_REG_WRITE_EN_S4 = PR_REG_WRITE_EN_S3;
        PR_MEM_READ_S4 = PR_MEM_READ_S3;
        
        //************** ************ STAGE 3 **************************
        #0.001
        PR_REGISTER_WRITE_ADDR_S3 = PR_REGISTER_WRITE_ADDR_S2;
        PR_PC_S3 = PR_PC_S2;
        PR_ALU_OUT_S3 = ALU_OUT;
        PR_DATA_2_S3 = ; 
        REG_READ_ADDR2_S3 = REG_READ_ADDR2_S2;   
        
        PR_MEM_READ_S3 = PR_MEM_READ_S2;
        PR_MEM_WRITE_S3 = PR_MEM_WRITE_S2;
        PR_REG_WRITE_SELECT_S3  = PR_REG_WRITE_SELECT_S2;
        PR_REG_WRITE_EN_S3 = PR_REG_WRITE_EN_S2;

        //************************** STAGE 2 **************************  
        #0.001  
        PR_REGISTER_WRITE_ADDR_S2 = PR_INSTRUCTION[11:7]; // TODO: check the 11:7 value
        PR_PC_S2 = PR_PC_S1;
        PR_DATA_1_S2 = DATA1_S2;
        PR_DATA_2_S2 = DATA2_S2;
        PR_IMMEDIATE_SELECT_OUT = IMMEDIATE_OUT_S2;
        REG_READ_ADDR1_S2 = PR_INSTRUCTION[19:15];                
        REG_READ_ADDR2_S2 = PR_INSTRUCTION[24:20];

        PR_BRANCH_SELECT_S2 =  BRANCH_SELECT;
        PR_ALU_SELECT =  ALU_SELECT;
        PR_OPERAND1_SEL =  OPERAND1_SEL;
        PR_OPERAND2_SEL =  OPERAND2_SEL;
        PR_MEM_READ_S2 =  MEM_READ_S2;
        PR_MEM_WRITE_S2  =  MEM_WRITE_S2;
        PR_REG_WRITE_SELECT_S2 = REG_WRITE_SELECT_S2;
        PR_REG_WRITE_EN_S2 = REG_WRITE_EN_S2; 

        //************************** STAGE 1 **************************
        #0.001
        PR_INSTRUCTION = INSTRUCTION;
        PR_PC_S1 = PC; //PC_PLUS_4;
    end
end

// PC update with the clock edge
always @ (posedge CLK) begin     
    if (RESET == 1'b1) begin
            PC = -4; // reset the pc counter
            // clearing the pipeline registers
            PR_INSTRUCTION = 32'b0;
            PR_PC_S1 = 32'b0;

            PR_PC_S2 = 32'b0;
            PR_DATA_1_S2 = 32'b0; 
            PR_DATA_2_S2 = 32'b0; 
            PR_IMMEDIATE_SELECT_OUT = 32'b0;
            
            PR_REGISTER_WRITE_ADDR_S2 = 5'b0;
            PR_BRANCH_SELECT_S2 = 4'b0; 
            PR_MEM_READ_S2 = 4'b0;
            PR_ALU_SELECT = 5'b0;
            PR_OPERAND1_SEL = 1'b0;
            PR_OPERAND2_SEL = 1'b0;
            PR_MEM_WRITE_S2 = 3'b0; 
            PR_REG_WRITE_SELECT_S2 = 2'b0;
            PR_REG_WRITE_EN_S2 = 1'b0; 

            PR_PC_S3 = 32'b0; 
            PR_ALU_OUT_S3 = 32'b0;
            PR_DATA_2_S3 = 32'b0;
            PR_REGISTER_WRITE_ADDR_S3 = 5'b0;
            PR_MEM_READ_S3 = 4'b0;
            PR_MEM_WRITE_S3 = 3'b0; 
            PR_REG_WRITE_SELECT_S3 = 2'b0;
            PR_REG_WRITE_EN_S3 = 1'b0; 

            PR_PC_S4 = 32'b0;
            PR_ALU_OUT_S4 = 32'b0;
            PR_DATA_CACHE_OUT = 32'b0;
            PR_REGISTER_WRITE_ADDR_S4 = 5'b0;
            PR_REG_WRITE_SELECT_S4 = 2'b0;
            PR_REG_WRITE_EN_S4 = 1'b0;

            INS_READ_EN = 1'b0; // disable the read enable signal of the instruction memory
        end
    else begin
        INS_READ_EN = 1'b0;
        #1
        if (!(DATA_CACHE_BUSY_WAIT || INS_CACHE_BUSY_WAIT)) begin 
            PC = PC_NEXT;       // increment the pc
            INS_READ_EN = 1'b1; // enable read from the instruction memory
        end
    end
end

endmodule