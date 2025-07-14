/*
This design was created as a solution to the HDLBits Conwaylife problem. 
The design uses two state buffers (cur_state, and next_state) to implement the core logic of the game
in a combinational always block. The cur_state is then written to the output in a 
clocked always block to maintain synchronous behaviour. 
*/

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q );
    
    reg [255:0] cur_state;
    reg [255:0] next_state;
    integer row, col, counter;
    integer i, j, k, l;
    
    //combinational logic
    always @ (*) begin
        
        //iterate through each cell
        for (i=0 ; i<16 ; i++) begin
            for (j=0 ; j<16 ; j++) begin
                
                counter = 0;
                
                //iterate through each neighbour
                for (k=-1 ; k<2 ; k++) begin
                    for (l=-1 ; l<2 ; l++) begin
                        
                        row = (i + k + 16) % 16;
                        col = (j + l + 16) % 16;
                        
                        if (!(k==0 & l==0) & cur_state[16*row + col] == 1) counter = counter + 1;
                    end
                end
                
                //core logic
                case (counter)
                    0: next_state[16*i + j] = 0;
                    1: next_state[16*i + j] = 0;
                    2: next_state[16*i + j] = cur_state[16*i + j];
                    3: next_state[16*i + j] = 1;
                    default: next_state[16*i + j] = 0;
                    
                endcase
            end
        end
        
    end
    
    //sequential logic
    always @ (posedge clk) begin
        if (load) begin
            q <= data;
            cur_state <= data;
        end

        else begin
           q <= next_state;
           cur_state <= next_state;
        end
    end

endmodule
