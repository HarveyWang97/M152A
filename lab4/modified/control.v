module gamecontrol(
input clk, 
input reset,
input left,
input right, 
input up, 
input down, 
input meet_wl, 
input meet_bd, 
input level,
output  [1:0] state, 

output reg dsignal

);


localparam READY = 2'b01; 
localparam GO = 2'b10; 
localparam DEAD = 2'b11;




reg [31:0] clk_cnt ;
reg [1:0] status ;

initial begin
	clk_cnt = 0;
	status = READY;
end



always @( posedge clk or posedge reset )
begin
	if( reset )
		begin
			status <= READY; 
			clk_cnt <= 0;
			dsignal <= 1; 
		end 
	else begin
		case( status ) 


		READY: begin
			if( left | right | up | down )
					begin 
						status <= GO;
					end 
		end

		GO: begin
				if( meet_wl | meet_bd )
					status <= DEAD;
			  end
			 

		DEAD: begin
				if( clk_cnt <= 400000000 ) 
					begin 
						clk_cnt <= clk_cnt + 1;
						if( clk_cnt == 50000000 ) 
							dsignal <= 0;
						else if( clk_cnt == 100000000 ) 
							dsignal <= 1;
						else if( clk_cnt == 150000000 ) 
							dsignal <= 0;
						else if( clk_cnt == 200000000 ) 
							dsignal <= 1;
						else if( clk_cnt == 250000000 ) 
							dsignal <= 0;
						else if( clk_cnt == 300000000 ) 
							dsignal <= 1;
					end 
				else begin
						dsignal <= 1;
						clk_cnt <= 0;
						status <= READY;
					 end
			  end 
	endcase
end
end 

assign state = status;
endmodule