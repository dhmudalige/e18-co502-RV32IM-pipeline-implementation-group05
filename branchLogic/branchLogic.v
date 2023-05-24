
/*
 * branch module - 
 * 
 */

module branchLogic(OUTPUT,EQ,LT,LTU,SIGNAL);
    //declare input,output
    input [2:0] SIGNAL;
    input EQ,LT,LTU;
    output reg OUTPUT; 

    //always block to add two inputs
    always @(*) begin
        #1;
        OUTPUT = 0;
        case (SIGNAL)
            1:                //BEQ
                #1;
                if (EQ) begin

                    OUTPUT=1;
                end
                
            2:                //BNE
                #1;
                if (!EQ) begin

                    OUTPUT=1;
                end
            3:                //BLT
                #1;
                if (LT) begin

                    OUTPUT=1;
                end
                
            4:                //BGE
                #1;
                if (!LT) begin

                    OUTPUT=1;
                end
            5:                //BLTU
                #1;
                if (LTU) begin

                    OUTPUT=1;
                end
            6:                //BGEU
                #1;
                if(!LTU) begin
                    OUTPUT=1;
                end

            
        endcase
    end

endmodule


