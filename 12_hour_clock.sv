module top_module(
    input clk,
    input reset,
    input ena,
    output pm, // (AM = 0, PM = 1)
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    reg [4:0] digit_ena;
    reg [4:0] digit_reset;
    reg [3:0] twelve_counter;
    //upper digits are modulo 6 periodic
    //lower digits are modulo 10 periodic
    
    //seconds
    assign digit_ena[0] = (ena) ? 1 : 0;
    assign digit_ena[1] = (ena & ss[3:0] == 4'b1001) ? 1 : 0;
    assign digit_reset[0] = (reset);
    assign digit_reset[1] = (reset | (ss==8'h59));
    
    //minutes
    assign digit_ena[2] = (ena & (ss[7:4] == 4'b0101 & ss[3:0] == 4'b1001)) ? 1 : 0;
    assign digit_ena[3] = (ena & (mm[3:0]==4'b1001&ss==8'h59)) ? 1 : 0;
    assign digit_reset[2] = (reset);
    assign digit_reset[3] = (reset | (mm==8'h59 & ss==8'h59));
    
    //hours
    assign digit_ena[4] = (ena & (mm==8'h59 & ss==8'h59)) ? 1 : 0;
    assign digit_reset[4] = reset;
    
    //seconds
    BCD s_low (.clk(clk), .ena(digit_ena[0]), .reset(digit_reset[0]), .q(ss[3:0]));
    BCD s_high (.clk(clk), .ena(digit_ena[1]), .reset(digit_reset[1]), .q(ss[7:4]));
    
    //minutes
    BCD m_low (.clk(clk), .ena(digit_ena[2]), .reset(digit_reset[2]), .q(mm[3:0]));
    BCD m_high (.clk(clk), .ena(digit_ena[3]), .reset(digit_reset[3]), .q(mm[7:4]));
    
    //hours
    twelve_ctr(.clk(clk), .ena(digit_ena[4]), .reset(digit_reset[4]), .q(twelve_counter), .pm(pm));
    assign hh[3:0] = (twelve_counter > 4'd9) ? twelve_counter - 4'd10 : twelve_counter;
    assign hh[7:4] = (twelve_counter > 4'd9) ? 4'b0001 : 4'b0000;
   

endmodule

module BCD (
    input clk,
    input ena,
    input reset,
    output [3:0] q);
    
    always @ (posedge clk) begin
        if (reset) q <= 4'b0000;
        
        else if (ena) begin
            if (q == 4'b1001) q <= 4'b0000;
            else q <= q + 4'd1;   
        end
    end
endmodule

//1-12 clock that starts at 12 upon reset. Includes a PM flag
module twelve_ctr (
    input clk,
    input ena,
    input reset,
    output pm,
    output reg [3:0] q);
    
    always @ (posedge clk) begin
        if (reset) begin
            q <= 4'b1100;
            pm <= 0;
        end
        
        else if (ena) begin
            
            //12 -> 1 rollover
            if (q == 4'b1100) q <= 4'b0001;
            
            else begin
                //11 -> 12 pm switch
                if (q == 4'b1011) begin
                    pm <= ~pm;
                    q <= 4'b1100;
                    
                //regular increment
                end else begin
                	q <= q + 4'b0001;
                end
            end
        end
    end
    
endmodule