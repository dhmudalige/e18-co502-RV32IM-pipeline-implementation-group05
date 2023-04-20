//register file module
module reg_file(IN,OUT1,OUT2,INADDRESS,OUT1ADDRESS,OUT2ADDRESS,WRITE,CLK,RESET);
    //port declarations
    input [31:0] IN;                                     //for input data
    input [4:0] INADDRESS, OUT1ADDRESS, OUT2ADDRESS;    //addresses of the registers which values should write and values should retrieve
    input WRITE, CLK, RESET;                            //control input ports for write and reset
    output [31:0] OUT1, OUT2;                        //registeres to store values that are read
    reg [31:0] register_file [0:31];                      //register fie with 32, 32 bit registers
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
            for(i = 0; i < 31; i = i + 1) begin
                register_file[i] = 0; //rset the registers
            end
        end
    end

endmodule