
/*
 * signExtend module - 
 * Extend the INPUT(8/12 bits) to 32 bits
 * assign the most significant bit to the rest
 * 
 */
module signExtend(OUTPUT,INPUT,SIGNAL);
    //declare input,output
    input [11:0] INPUT;           
    input [1:0] SIGNAL;          //0 - 8 bit , 1- 12 bit
    output reg[31:0] OUTPUT;     //offset as 32 bits


    always @(*) begin
        #1;
     
        //------------sign extending----------------

        //if signal == 0 => 8 bit to 32 bit extender
        if (SIGNAL==0) begin
            OUTPUT[7:0]=INPUT[7:0]; 
            //if MSB is 0 assign 0 to rest
            if (INPUT[7]==0) begin
                OUTPUT[31:8]=0; 
            end
            //if MSB is 1 assign 1 to rest
            else OUTPUT[31:8]= 1;
        end

        //if signal == 1 => 12 bit to 32 bit extender
        else begin
            OUTPUT[11:0]=INPUT[11:0];
             //if MSB is 0 assign 0 to rest
            if (INPUT[11]==0) begin
                OUTPUT[31:12]=0; 
            end
            //if MSB is 1 assign 1 to rest
            else OUTPUT[31:12]= 1;
        end

      


    end

endmodule

//-----------------------------------------------------------------------------------------------------------
