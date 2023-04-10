
`timescale  1ns/100ps

module data_memory(
	clock,
    reset,
    read,
    write,
    address,
    writedata,
    readdata,
	busywait
);

`define READ_DELAY #40
`define WRITE_DELAY #40

input				clock;
input           	reset;
input           	read;
input           	write;
input [27:0]      	address;
input [127:0]     	writedata;
output reg [127:0]	readdata;
output reg      	busywait;

// #### NOTE: MEMORY SIZE CAN BE INCREASE ####
//Declare memory array 256x8-bits 
reg [7:0] memory_array [255:0];
// #### #### #### #### #### #### #### ####

//Detecting an incoming memory access
reg readaccess, writeaccess;
always @(read, write) begin
	busywait = (read || write)? 1 : 0;
	readaccess = (read && !write)? 1 : 0;
	writeaccess = (!read && write)? 1 : 0;
end

//Reading & writing
always @(posedge clock) begin
	if(readaccess) begin
		readdata[7:0]   = `READ_DELAY memory_array[{address,4'b0000}];
		readdata[15:8]  = `READ_DELAY memory_array[{address,4'b0001}];
		readdata[23:16] = `READ_DELAY memory_array[{address,4'b0010}];
		readdata[31:24] = `READ_DELAY memory_array[{address,4'b0011}];

        readdata[39:32] = `READ_DELAY memory_array[{address,4'b0100}];
		readdata[47:40] = `READ_DELAY memory_array[{address,4'b0101}];
		readdata[55:48] = `READ_DELAY memory_array[{address,4'b0110}];
		readdata[63:56] = `READ_DELAY memory_array[{address,4'b0111}];

        readdata[71:64] = `READ_DELAY memory_array[{address,4'b1000}];
		readdata[79:72] = `READ_DELAY memory_array[{address,4'b1001}];
		readdata[87:80] = `READ_DELAY memory_array[{address,4'b1010}];
		readdata[95:88] = `READ_DELAY memory_array[{address,4'b1011}];

        readdata[103:96]  = `READ_DELAY memory_array[{address,4'b1100}];
		readdata[111:104] = `READ_DELAY memory_array[{address,4'b1101}];
		readdata[119:112] = `READ_DELAY memory_array[{address,4'b1110}];
		readdata[127:120] = `READ_DELAY memory_array[{address,4'b1111}];
		
		busywait = 0;
		readaccess = 0;
	end

	if(writeaccess) begin
		memory_array[{address,4'b0000}] = `WRITE_DELAY writedata[7:0];
		memory_array[{address,4'b0001}] = `WRITE_DELAY writedata[15:8];
		memory_array[{address,4'b0010}] = `WRITE_DELAY writedata[23:16];
		memory_array[{address,4'b0011}] = `WRITE_DELAY writedata[31:24];
		
		memory_array[{address,4'b0100}] = `WRITE_DELAY writedata[39:32];
		memory_array[{address,4'b0101}] = `WRITE_DELAY writedata[47:40];
		memory_array[{address,4'b0110}] = `WRITE_DELAY writedata[55:48];
		memory_array[{address,4'b0111}] = `WRITE_DELAY writedata[63:56];

		memory_array[{address,4'b1000}] = `WRITE_DELAY writedata[71:64];
		memory_array[{address,4'b1001}] = `WRITE_DELAY writedata[79:72];
		memory_array[{address,4'b1010}] = `WRITE_DELAY writedata[87:80];
		memory_array[{address,4'b1011}] = `WRITE_DELAY writedata[95:88];

		memory_array[{address,4'b1100}] = `WRITE_DELAY writedata[103:96];
		memory_array[{address,4'b1101}] = `WRITE_DELAY writedata[111:104];
		memory_array[{address,4'b1110}] = `WRITE_DELAY writedata[119:112];
		memory_array[{address,4'b1111}] = `WRITE_DELAY writedata[127:120];

		busywait = 0;
		writeaccess = 0;
	end
end

integer i;
//Reset memory
always @(posedge reset) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1)
            memory_array[i] = 0;
        
        busywait = 0;
		readaccess = 0;
		writeaccess = 0;
    end
end

endmodule