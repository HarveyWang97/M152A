`timescale 1ns / 1ps

module clk_sel(
	input clk, adj_clk,
	input wire adjust,
	output clock
    );

reg clock_reg;

always @* begin
	if (adjust == 0) 
		clock_reg = clk;
	else //if it's in adjust mode
	    clock_reg = adj_clk;

end

assign clock = clock_reg;

endmodule