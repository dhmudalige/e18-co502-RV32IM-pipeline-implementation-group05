
/*
 * branching unit 
 * 
 */

module branch_logics(OUTPUT,EQ,LT,LTU,SIGNAL);
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
                if (EQ) begin

                    OUTPUT=1;
                end
                
            2:                //BNE
                if (!EQ) begin

                    OUTPUT=1;
                end
            3:                //BLT
                if (LT) begin

                    OUTPUT=1;
                end
                
            4:                //BGE
                if (!LT) begin

                    OUTPUT=1;
                end
            5:                //BLTU
                if (LTU) begin

                    OUTPUT=1;
                end
            6:                //BGEU
                if(!LTU) begin
                    OUTPUT=1;
                end

            
        endcase
    end

endmodule


