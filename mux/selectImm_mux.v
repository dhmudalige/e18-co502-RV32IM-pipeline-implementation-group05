/* 
 * Select7bit_mux module - 
 * check the enable and
 * if it is 1 , output the IMMEDIATEVALUE
 * Otherwise output the REGOUT2
 *
 */
module Select7bit_mux(RESULT,IMMEDIATEVALUE,REGOUT2,ENABLE);
    /* Declare inputs and outputs 
     * according to the required number of bits
     */
    input ENABLE ;    
    input [7:0] IMMEDIATEVALUE,REGOUT2;        
    output reg [7:0] RESULT;      

    /* 
     * Always if ENABLE is high - output the IMMEDIATEVALUE
     * Otherwise output the REGOUT2
     */
    always @ (*) begin
        case (ENABLE)
            1 : RESULT= IMMEDIATEVALUE;  
            0 : RESULT= REGOUT2;     
        endcase
    end   
endmodule
//-----------------------------------------------------------------------------------------------------------
