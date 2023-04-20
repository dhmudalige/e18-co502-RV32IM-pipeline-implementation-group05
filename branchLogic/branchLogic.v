
/*
 * branch module - 
 * 
 */

module branchLogic(OUTPUT,ZERO,NOTZERO,SIGNAL);
    //declare input,output
    input [2:0] ALU_SIGNAL,SIGNAL;
    output reg [1:0]OUTPUT; 

    //always block to add two inputs
    always @(*) begin
        #1;
        case (SIGNAL)
            1,3,5: 
                if (ZERO) begin

                    OUTPUT=1;
                end
                
            2,4,6:
                if(NOTZERO) begin
                    OUTPUT=1;
                end

            
        endcase
    end

endmodule


