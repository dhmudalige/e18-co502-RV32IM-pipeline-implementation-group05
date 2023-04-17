/*
 * selectSUB_mux module - 
 * check the enable and
 * if it is 1 , output the REGOUT2 value by converting to 2's complement
 * Otherwise output the REGOUT2
 *
 */
module selectSUB_mux(RESULT,REGOUT2,ENABLE);

    /* Declare inputs and outputs 
     * according to the required number of bits
     */
    input ENABLE ;                
    input [7:0] REGOUT2;           
    output reg [7:0] RESULT;       
    
    /* 
     * Always block 
     */
    always @ (*) begin

        if (ENABLE==1)  begin
            //if ENABLE is high - 
            //output the REGOUT2 value by converting to 2's complement
            #1;   //One time unit delay for 2's complement
            RESULT= ~REGOUT2 + 8'b00000001; 
                
        end

        //Otherwise output the REGOUT2
        else  RESULT=  REGOUT2;   

    end   
    
endmodule
//-----------------------------------------------------------------------------------------------------------
