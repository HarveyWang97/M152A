`timescale 1ns / 1ps

module blinking(
  input wire clk,
  input wire isblink,
  input wire [7:0] digit1,
  input wire [7:0] digit2,
  output wire [7:0] out1,
  output wire [7:0] out2
);

  reg blk = 0;
  
  always @ (posedge clk) begin
    blk <= ~blk;
    if (start && !blk)
    begin
      out1 <= 8'b11111111;
      out2 <= 8'b11111111;
    end
    
    else 
    begin
      out1 <= digit1;
      out2 <= digit2;
    end
  end
  
endmodule