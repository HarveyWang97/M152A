`timescale 1ns / 1ps

module counter(
	input clk,
	input adj_clk,
	input wire adjust,
	input wire select,
	input wire pause,
	input wire rst,
	output [3:0] min0,
	output [3:0] min1,
	output [3:0] sec0,
	output [3:0] sec1
);

    reg [3:0] min1_ct = 4'b0000;
	reg [3:0] min0_ct = 4'b0000;
	reg [3:0] sec1_ct = 4'b0000;
	reg [3:0] sec0_ct = 4'b0000;

clk_sel sel_clk (
		.clk(clk),
		.adj_clk(adj_clk),
		.adjust(adjust),
		.clock(clock)
		);
	
	//setting the pause 
	reg paused = 0;
	always @ (posedge clk or posedge pause) begin
		if (pause) begin
			paused <= ~paused;
		end
		else begin
			paused <= paused;
		end
	end
	
	
	

always @ (posedge clock or posedge rst) begin
	if(rst)
		begin
			min0_ct <= 4'b0000;
			min1_ct <= 4'b0000;
			sec0_ct <= 4'b0000;
			sec1_ct <= 4'b0000;
		end
		
		
//regular clock mode (adjust=0)
	else if(adjust==0 && ~paused)
		begin
			if( sec0_ct==9 && sec1_ct ==5)
				begin
					sec0_ct <= 0;
					sec1_ct <= 0;
					if( min0_ct==9 && min1_ct == 9 )
						begin
							min0_ct <= 0;
							min1_ct <= 0;
						end
					else if(min0_ct==9)
						begin
							min0_ct <= 0;
							min1_ct <= min1_ct+1;
                        end
					else
						min0_ct <= min0_ct+1;

				end
			else if(sec0_ct==9)
			  begin
			      sec0_ct<=0;
			      sec1_ct<=sec1_ct+1;
              end
			else
				sec0_ct <= sec0_ct+1;
		end
		
//adjust clock mode (adjust=1)
    else if(adjust==1 && ~ paused && select) begin
    // increment seconds
			if (sec0_ct == 9 && sec1_ct == 5) begin
				sec0_ct <= 0;
				sec1_ct <= 0;
			end
			else if (sec0_ct == 9) begin
				sec0_ct <= 0;
				sec1_ct <= sec1_ct + 1;
			end
			else begin
				sec0_ct <= sec0_ct + 1;
			end
		end
    else if (adjust == 1 && ~paused && ~select) begin
	// increment minutes
	        if (min0_ct == 9 && min1_ct == 9) begin
		      min0_ct <= 0;
		      min1_ct <= 0;
	        end
			else if (min0_ct == 9) begin
				// overflow minutes
				min0_ct <= 0;
				min1_ct <= min1_ct + 1;
			end
			else begin
				min0_ct <= min0_ct + 1;
			end
		end
	
	
 
	
end

 assign min0 = min0_ct;
 assign min1 = min1_ct;
 assign sec0 = sec0_ct;
 assign sec1 = sec1_ct;

endmodule	
				


