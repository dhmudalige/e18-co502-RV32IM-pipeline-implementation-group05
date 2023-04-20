
`include "../utils/macros.v" 
`include "reg_file.v"

module register_file_tb;

    reg [31:0] WRITEDATA;
    reg [4:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [31:0] REGOUT1, REGOUT2;

    integer j;

    reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);

    initial 
    begin
        CLK = 1'b0;
        RESET = 1'b0;
        WRITEDATA = 32'd0;
        READREG1 = 5'd0;
        READREG2 = 5'd0;
        WRITEREG = 5'd0;
        WRITEENABLE = 0;

        $dumpfile("register_file_wavedata.vcd");
        $dumpvars(0, register_file_tb);
        // for(j = 0; j < 32; j = j + 1) $dumpvars(0, my_reg_file.REGISTER[j]);


        #1
        RESET = 1'b1;

        #5
        RESET = 1'b0;

        /* 
            TEST 1 starts here!

            Regfile module should able to write to specific register. 
            WRITE 10 to reg 1
        */
            WRITEREG = 5'd1;
            WRITEDATA = 32'd10;
            WRITEENABLE = 1'b1;

            @(posedge CLK) begin
                // wait for write to happen.
                #3;
                // read value of the address
                READREG1 = 5'd1;
                // wait for read to happen and check value
                #3;
                `assert(REGOUT1, 32'd10);
                $display("TEST 1 Passed!");

            end
        /* TEST 1 ends here! */

        /* 
            TEST 2 starts here!

            Regfile module should not be able to write to R0. 
            WRITE 10 to reg 1
        */
            WRITEREG = 5'd0;
            WRITEDATA = 32'd10;
            WRITEENABLE = 1'b1;

            @(posedge CLK) begin
                // wait for write to happen.
                #3;
                // read value of the address
                READREG1 = 5'd0;
                // wait for read to happen and check value
                #3;
                `assert(REGOUT1, 32'd0);
                $display("TEST 2 Passed!");

            end
        /* TEST 1 ends here! */

        #500
        $finish;
    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

endmodule