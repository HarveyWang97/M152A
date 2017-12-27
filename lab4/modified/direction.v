`timescale 1ns / 1ps

module direction(
	input clk,
	input reset,
	input right_btn,
	input left_btn,
	input up_btn,
	input down_btn,
	output reg [1:0] dir

);

localparam DIR_UP = 2'b00;
localparam DIR_DOWN = 2'b01;
localparam DIR_LEFT = 2'b10;
localparam DIR_RIGHT = 2'b11;

initial begin
dir = DIR_RIGHT;
end
reg [1:0] n_dir = DIR_RIGHT;

reg ready_left = 0;
reg ready_right = 0;
reg ready_up  = 0;
reg ready_down  = 0;


always @( posedge clk or posedge reset)     
	if( reset) 
		dir <= DIR_RIGHT;
	else 
		dir <= n_dir;


always @( * ) begin
		
		case( dir )
		DIR_UP: 
			begin
				if( ready_left )
					n_dir <= DIR_LEFT;
				else if( ready_right )
					n_dir <= DIR_RIGHT;
				else 
					n_dir <= DIR_UP;
			end

		DIR_DOWN : 
			begin
				if( ready_left )
					n_dir <= DIR_LEFT;
				else if( ready_right )
					n_dir <= DIR_RIGHT;
				else 
					n_dir <= DIR_DOWN;
			end

		DIR_LEFT : 
			begin
				if( ready_up )
					n_dir <= DIR_UP;
				else if( ready_down )
					n_dir <= DIR_DOWN;
				else 
					n_dir <= DIR_LEFT;	
			end

		DIR_RIGHT :
			begin
				if( ready_up )
					n_dir <= DIR_UP;
				else if( ready_down )
					n_dir <= DIR_DOWN;
				else 
					n_dir <= DIR_RIGHT;
			end

		endcase
	end



always @( posedge clk ) begin

		if( left_btn == 1 ) 
		begin
			ready_left <= 1;
		end
			
		else if( right_btn == 1 ) 
		begin				
			ready_right <= 1;	
		end

		else if( up_btn == 1 ) 
		begin
			ready_up <= 1;
		end

		else if( down_btn == 1 ) 
		begin
			ready_down <= 1;
		end

		else begin
			ready_left <= 0;
			ready_right <= 0;
			ready_up <= 0;
			ready_down <= 0;
		end
	end


endmodule