`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2024 07:36:56 PM
// Design Name: 
// Module Name: tb_D_FLIPFLOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_D_FLIPFLOP();
logic clk;
logic d;
logic clear;
logic rst;
logic q;

D_FLIPFLOP DUT(clk, d, clear, rst, q);
initial clk = 1'b0;
always begin
    #1 clk = ~clk;
end 

initial begin 
#0
rst = 1'b0;
clear = 1'b1;
d = 1'b0;
#10
#2
rst = 1'b0;
clear = 1'b1;
d = 1'b1;
#2
rst = 1'b1;
clear = 1'b0;
d = 1'b1;
#2
rst = 1'b1;
clear = 1'b0;
d = 1'b1; 

#2 
rst = 1'b1;
clear = 1'b0;
d = 1'b1; 

#2
rst = 1'b1;
clear = 1'b0;
d = 1'b1;

#2
rst = 1'b0;
clear = 1'b0;
d = 1'b1; 
#2
rst = 1'b1;
clear = 1'b0;
d = 1'b1; 
#2
rst = 1'b1;
clear = 1'b0;
d = 1'b0;
#2
rst = 1'b1;
clear = 1'b0;
d = 1'b1; 
 
$stop;
 
end 
endmodule
