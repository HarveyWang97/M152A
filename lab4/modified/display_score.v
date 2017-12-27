`timescale 1ns / 1ps



module display_score(
	input clk,
	input segclk,
	input reset,
	input  add_score,
	output reg [7:0] segout,
	output reg[3:0] anode
);

reg [1:0] count = 0;
reg [3:0] score1 = 0;
reg [3:0] score2 = 0;
reg [3:0] score3 = 0;
reg [3:0] score4 = 0;

reg addscore_state = 0;
wire [7:0] seg1;
wire [7:0] seg2;
wire [7:0] seg3;
wire [7:0] seg4;



always @( posedge clk  or posedge reset) begin
		if( reset  ) begin

		score1 <= 0;
      score2 <= 0;
      score3 <= 0;
      score4 <= 0;
			
		end
		
		else begin
		
			case( addscore_state )
		
			0: begin
				if( add_score ) begin
				
					
						if( score2 < 9 )
							score2 <= score2 + 1;
						else begin
							score2 <= 0;
							if( score3 < 9 ) 
								score3 <= score3 + 1;
							else begin
								score3 <= 0;
								score4 <= score4 + 1;
							end
						//end
					end
					
					addscore_state <= 1;
					
				end
			end
			
			1: begin
			
				if(!add_score)
					addscore_state <= 0;
					
			end
			endcase		
		end
	end

seven_segment digit1(
	.digit(score1),
	.Seven_seg_display(seg1)
);

seven_segment digit2(
	.digit(score2),
	.Seven_seg_display(seg2)
);

seven_segment digit3(
	.digit(score3),
	.Seven_seg_display(seg3)
);

seven_segment digit4(
	.digit(score4),
	.Seven_seg_display(seg4)
);



always @( posedge segclk) begin
if(count == 0)
    begin
      anode <= 4'b0111;
      segout <= seg4;
      count <= count + 1;
    end
    
    else if(count == 1)
    begin
      anode <= 4'b1011;
      segout <= seg3;
      count <= count + 1;
    end
    
    else if(count == 2)
    begin
      anode <= 4'b1101;
      segout <= seg2;
      count <= count + 1;
    end
    
    else if(count == 3)
    begin
      anode <= 4'b1110;
      segout <= seg1;
      count <= 0;
    end
end


endmodule

