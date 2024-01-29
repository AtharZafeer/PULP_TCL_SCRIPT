`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2024 07:36:24 PM
// Design Name: 
// Module Name: D_FLIPFLOP
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


module D_FLIPFLOP(input logic clk, input logic d, input logic clear, input logic rst, output logic q);
    
    always_ff@(posedge clk or negedge rst )begin
        if(~rst) q<=0;
        else if(clear) q<=0;
        else q<=d;
    end
endmodule
