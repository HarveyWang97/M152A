`timescale 1ns / 1ps




module Display_digit(
	input clk,
	input [7:0] digit0,
	input [7:0] digit1,
	input [7:0] digit2,
	input [7:0] digit3,
	output [7:0] output_display,
	output [3:0] anode
);

reg [7:0] displaytmp;
reg [7:0] anodetmp;

integer cnt = 0;

always @(posedge clk) begin
	
	if(cnt == 0)
	begin
		displaytmp <= digit0;
		anodetmp <= 4'b0111;
		cnt <= cnt+1;
	end
	
	else if(cnt ==1)
	begin
		displaytmp <= digit1;
		anodetmp <= 4'b1011;
		cnt <= cnt+1;
	end
	
	else if(cnt == 2)
	begin
		displaytmp <= digit2;
		anodetmp <= 4'b1101;
		cnt <= cnt+1;
	end

	else if (cnt == 3)
	begin
		displaytmp <= digit3;
		anodetmp <= 4'b1110;
		cnt <= 0;
	end
end

assign output_display = displaytmp;
assign anode = anodetmp;

endmodule




	

