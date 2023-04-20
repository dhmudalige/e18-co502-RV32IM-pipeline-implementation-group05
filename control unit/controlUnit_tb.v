//CONTROL UNIT

`define DELAY #2

module control_unit_tb;


    reg [7:0] OPCODE;
    reg [2:0] FUNCT3;
    reg [6:0] FUNCT7;
    reg BUSYWAIT;
    
    wire READ,WRITE,SELECTWRITE, IMMflag,Jumpflag,WRITEENABLE;
    wire [1:0] STORESIGNAL;
    wire [4:0] ALUOP;
    wire [2:0] LOADSIGNAL, BRANCHSIGNAL;
  
    

    control_unit my_control_unit(ALUOP,READ,WRITE,SELECTWRITE,IMMflag,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,WRITEENABLE,OPCODE,BUSYWAIT,FUNCT3,FUNCT7);
    

    initial begin

        // LUI
        $display("Test 1 : LUI Control Signal Test");
        OPCODE = 7'b0110111;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b110);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("LUI test passed!\n");

        // // AUIPC
        
        $display("Test 1 : AUIPC Control Signal Test");
        OPCODE = 7'b0010111;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b110);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("AUIPC test passed!\n");

        // JAL
        $display("Test 1 : JAL Control Signal Test");
        OPCODE = 7'b1101111;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'bx);
        `assert(WRITEENABLE,1'bx);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'b1);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'bxxxxx);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("JAL test passed!\n");

        // JALR
        $display("Test 3 : JALR Control Signal Test");
        OPCODE = 7'b1100111;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'bx);
        `assert(WRITEENABLE,1'bx);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'b1);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'bxxxxx);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("JALR test passed!\n");


        // BEQ
        $display("Test 5 : BEQ Control Signal Test");
        OPCODE =  7'b1100011 ;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'b001);
        `assert(ALUOP,5'b01000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("BEQ test passed!\n");

        // BNE
        $display("Test 6 : BNE Control Signal Test");
        OPCODE = 7'b1100011;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'b010);
        `assert(ALUOP,5'b01000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("BNE test passed!\n");

        // BLT
        $display("Test 7 : BLT Control Signal Test");
        OPCODE = 7'b1100011;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'b011);
        `assert(ALUOP,5'b10001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("BLT test passed!\n");

        // BGE
        $display("Test 8 : BGE Control Signal Test");
        OPCODE = 7'b1100011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'b100);
        `assert(ALUOP,5'b10001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("BGE test passed!\n");

        // BLTU
        $display("Test 9 : BLTU Control Signal Test");
        OPCODE = 7'b1100011;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'b101);
        `assert(ALUOP,5'b10010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("BLTU test passed!\n");

        // BGEU
        $display("Test 10 : BGEU Control Signal Test");
        OPCODE = 7'b1100011;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'b110);
        `assert(ALUOP,5'b10010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("BGEU test passed!\n");

        // LB
        $display("Test 11 : LB Control Signal Test");
        OPCODE = 7'b0000011;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b1);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'b1);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b001);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("LB test passed!\n");

        // LH
        $display("Test 12 : LH Control Signal Test");
        OPCODE = 7'b0000011;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b1);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'b1);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b010);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("LH test passed!\n");

        // LW
        $display("Test 13 : LW Control Signal Test");
        OPCODE = 7'b0000011;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b1);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'b1);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b011);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("LW test passed!\n");

        // LBU
        $display("Test 14 : LBU Control Signal Test");
        OPCODE = 7'b0000011;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b1);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'b1);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b100);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("LBU test passed!\n");

        // LHU
        $display("Test 15 : LHU Control Signal Test");
        OPCODE = 7'b0000011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b1);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'b1);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'b101);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("LHU test passed!\n");

        // SB
        $display("Test 16 : SB Control Signal Test");
        OPCODE = 7'b0100011;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b0);
        `assert(WRITE,1'b1);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'b01);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SB test passed!\n");

        // SH
        $display("Test 17 : SH Control Signal Test");
        OPCODE = 7'b0100011;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b0);
        `assert(WRITE,1'b1);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'b10);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SH test passed!\n");

        // SW
        $display("Test 18 : SW Control Signal Test");
        OPCODE = 7'b0100011;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b0);
        `assert(READ,1'b0);
        `assert(WRITE,1'b1);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'b11);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SW test passed!\n");

        // ADDI
        $display("Test 19 : ADDI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
         #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("ADDI test passed!\n");

        // SLTI
        $display("Test 20 : SLTI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b10001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SLTI test passed!\n");

        // SLTIU
        $display("Test 21 : SLTIU Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b10010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SLTIU test passed!\n");
        
        // XORI
        $display("Test 22 : XORI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00100);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("XORI test passed!\n");

        // ORI
        $display("Test 23 : ORI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00011);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("ORI test passed!\n");

        // ANDI
        $display("Test 24 : ANDI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("ANDI test passed!\n");

        // SLLI
        $display("Test 25 : SLLI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00101);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SLLI test passed!\n");
        
        // SRLI
        $display("Test 26 : SRLI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00110);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SRLI test passed!\n");

        // SRAI
        $display("Test 27 : SRAI Control Signal Test");
        OPCODE = 7'b0010011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DELAY
       #0;
        `assert(IMMflag,1'b1);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00111);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SRAI test passed!\n");

        // ADD
        $display("Test 28 : ADD Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("ADD test passed!\n");

        // SUB
        $display("Test 29 : SUB Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0100000;
        `DELAY
       #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SUB test passed!\n");

        // SLL
        $display("Test 30 : SLL Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00101);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SLL test passed!\n");

        // SLT
        $display("Test 31 : SLT Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b10001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SLT test passed!\n");

        // SLTU
        $display("Test 32 : SLTU Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b10010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SLTU test passed!\n");

        // XOR
        $display("Test 33 : XOR Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00100);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("XOR test passed!\n");

        // SRL
        $display("Test 34 : SRL Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00110);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SRL test passed!\n");

        // SRA
        $display("Test 35 : SRA Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00111);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("SRA test passed!\n");

        // OR
        $display("Test 36 : OR Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00011);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("OR test passed!\n");

        // AND
        $display("Test 37 : AND Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000000;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b00010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("AND test passed!\n");

        // MUL
        $display("Test 38 : MUL Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01001);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("MUL test passed!\n");

        // MULH
        $display("Test 39 : MULH Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01010);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("MULH test passed!\n");

        // MULHSU
        $display("Test 40 : MULHSU Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01100);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("MULHSU test passed!\n");

        // MULHU
        $display("Test 41 : MULHU Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01011);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("MULHU test passed!\n");

        // DIV
        $display("Test 42 : DIV Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01101);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("DIV test passed!\n");

        // DIVU
        $display("Test 43 : DIVU Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01110);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("DIVU test passed!\n");

        // REM
        $display("Test 44 : REM Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b01111);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("REM test passed!\n");

        // REMU
        $display("Test 45 : REMU Control Signal Test");
        OPCODE = 7'b0110011;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000001;
        `DELAY
        #0;
        `assert(IMMflag,1'b0);
        `assert(WRITEENABLE,1'b1);
        `assert(READ,1'bx);
        `assert(WRITE,1'bx);
        `assert(SELECTWRITE,1'bx);
        `assert(Jumpflag,1'bx);
        `assert(LOADSIGNAL,3'bxxx);
        `assert(STORESIGNAL,2'bxx);
        `assert(BRANCHSIGNAL,3'bxxx);
        `assert(ALUOP,5'b10000);
        
        $display("IMMflag: %b, WRITEENABLE: %b,READ: %b,WRITE: %b,SELECTWRITE: %b,Jumpflag: %b,LOADSIGNAL: %b,STORESIGNAL: %b,BRANCHSIGNAL: %b,ALUOP: %b", IMMflag, WRITEENABLE,READ,WRITE,SELECTWRITE,Jumpflag,LOADSIGNAL,STORESIGNAL,BRANCHSIGNAL,ALUOP);
        $display("REMU test passed!\n");

        $display("All tests passed!");

    end

endmodule
//-----------------------------------------------------------------------------------------------------------


