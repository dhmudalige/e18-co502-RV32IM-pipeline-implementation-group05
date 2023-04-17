/* module reg_file_tb;
    
    reg [31:0] WRITEDATA;
    reg [4:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [31:0] REGOUT1, REGOUT2;
    
    reg_file myregfile(WRITEDATA, REGOUT1, REGOUT2, WRITEREG, READREG1, READREG2, WRITEENABLE, CLK, RESET);
       
    initial
    begin
        CLK = 1'b1;
        
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("reg_file_wavedata.vcd");
		$dumpvars(0, reg_file_tb);
        
        // assign values with time to input signals to see output 
        RESET = 1'b0;
        WRITEENABLE = 1'b0;
        
        #4
        RESET = 1'b1;
        READREG1 = 5'd0;
        READREG2 = 5'd4;
        
        #6
        RESET = 1'b0;
        
        #2
        WRITEREG = 5'd2;
        WRITEDATA = 32'd95;
        WRITEENABLE = 1'b1;
        
        /* #7
        WRITEENABLE = 1'b0;
        
        #1
        READREG1 = 3'd2;
        
        #7
        WRITEREG = 3'd1;
        WRITEDATA = 8'd28;
        WRITEENABLE = 1'b1;
        READREG1 = 3'd1;
        
        #8
        WRITEENABLE = 1'b0;
        
        #8
        WRITEREG = 3'd4;
        WRITEDATA = 8'd6;
        WRITEENABLE = 1'b1;
        
        #8
        WRITEDATA = 8'd15;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #6
        WRITEREG = -3'd1;
        WRITEDATA = 8'd50;
        WRITEENABLE = 1'b1;
        
        #5
        WRITEENABLE = 1'b0; 
        
        #10
        $finish;
    end
    
    // clock signal generation 
    always
        #4 CLK = ~CLK;
        

endmodule */


//register file module
module reg_file(IN,OUT1,OUT2,INADDRESS,OUT1ADDRESS,OUT2ADDRESS,WRITE,CLK,RESET);
    //port declarations
    input [31:0] IN;                                     //for input data
    input [4:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;    //addresses of the registers which values should write and values should retrieve
    input WRITE, CLK, RESET;                            //control input ports for write and reset
    output [31:0] OUT1, OUT2;                        //registeres to store values that are read
    reg [31:0] register_file [0:31];                      //register fie with 8, 8 bit registers
    integer i;                                          
    //reg change_val = 1'b0;                              //to check whether write and reset happen correctly

    
    //read the values of the registers in the given address 
    assign #2 OUT1 = register_file[OUT1ADDRESS];  //after 2 unit delayget the value in OUT1ADDRESS of the register file and store it in OUT1
    assign #2 OUT2 = register_file[OUT2ADDRESS];  //after 2 unit delay get the value in OUT2ADDRESS of the register file and store it in OUT2
  
    //this block excutes at the positive edge of the clock signal
    always @ (posedge CLK)
    begin
        //write the given values to registers when qrite is enable and reset is disable
        if (WRITE == 1 && RESET == 0) begin
            #1 register_file[INADDRESS] = IN;   //after 1 unit delay write the given input to given address
        end

        //reset the whole register file
        else if (RESET == 1) begin
            //reset all register one by one
            #1
            //after 1 unit delay
            for(i = 0; i < 8; i = i + 1) begin
                register_file[i] = 0; //rset the registers
            end
        end
    end

endmodule