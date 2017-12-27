module Snake_movement ( 
input clk,
input sixclk,
input fastclk,
input reset, 
input left_btn,  
input right_btn,  
input up_btn,  
input down_btn,
input [9:0] loc_x,  
input [9:0] loc_y, 
input add_score, 
input [1:0] state, 
input dsignal,  
output reg [2:0] snake, 
output reg [6:0] body_length,  
output [5:0] head_x,
output [5:0] head_y,  
output reg meet_bd, 
output reg meet_wl

);




localparam DIR_UP = 2'b00;
localparam DIR_DOWN = 2'b01;
localparam DIR_LEFT = 2'b10;
localparam DIR_RIGHT = 2'b11;

localparam SNAKE_BLANK = 3'b000;
localparam SNAKE_HEAD = 3'b001;
localparam SNAKE_BODY = 3'b010;
localparam SNAKE_WALL = 3'b011;
localparam EXTRA_WALL = 3'b100;
	
localparam READY = 2'b01;
localparam GO = 2'b10;
localparam DEAD = 2'b11;
	
reg extra_wall ;
reg addbody_state ;

reg gameclk;
reg level;

wire [1:0] dir;

reg [5:0] body_x[21:0];
reg [5:0] body_y[21:0];

direction get_dir(
.clk(clk),
.reset(reset),
.right_btn(right_btn),
.left_btn(left_btn),
.up_btn(up_btn),
.down_btn(down_btn),
.dir(dir)
);


reg [21:0] have_body ;


initial begin
body_x[0] = 15;
body_y[0] = 5;
body_x[1] = 14;
body_y[1] = 5;
body_x[2] = 13;
body_y[2] = 5;
have_body  = 22'b0000000000000000000111;
meet_wl = 0;
meet_bd = 0;
extra_wall = 0;
addbody_state = 0;
level = 0;
end


assign head_x = body_x[0];
assign head_y = body_y[0];


always @* begin
	if(level == 0)
		gameclk = sixclk;
	else begin
		gameclk = fastclk;
	end
end


always @( posedge gameclk or posedge reset)
	begin
		if(reset )  //might have problem
		     begin            // the initial position of the snake
				body_x[0] <=15;
			    body_y[0] <= 5;
				body_x[1] <= 14;
				body_y[1] <= 5;
				body_x[2] <= 13;
				body_y[2] <= 5;
				meet_wl <= 0;
				meet_bd <= 0;
				
				
		     end
			
		else
			begin
				
						if( state == GO ) 
							begin
								if( ( dir == DIR_UP && body_y[0] == 1 )
										| ( dir == DIR_DOWN && body_y[0] == 28 )
										| ( dir == DIR_LEFT && body_x[0] == 1 )
										| ( dir == DIR_RIGHT && body_x[0] == 38 ) )
									
									meet_wl <= 1;
									
									
									
									else if((dir == DIR_UP && ((body_y[0] == 22&& body_x[0] >=1 && body_x[0]<=6) | (body_y[0] == 9&&body_x[0]>=33&&body_x[0]<=38) |
									(body_y[0] == 7 &&body_x[0] ==7 )))|
									(dir == DIR_DOWN && ((body_y[0] == 20&& body_x[0] >=1 && body_x[0]<=6) | (body_y[0] == 7&&body_x[0]>=33&&body_x[0]<=38) |
									(body_y[0] == 22 &&body_x[0] ==31 )))|
									(dir == DIR_RIGHT && ((body_x[0] == 6&& body_y[0] >=1 && body_y[0]<=6) | (body_x[0] == 30&&body_y[0]>=23&&body_y[0]<=28) |
									(body_y[0] == 8&&body_x[0] ==32 )))|
									(dir == DIR_LEFT && ((body_x[0] == 8&& body_y[0] >=1 && body_y[0]<=6) | (body_x[0] == 32&&body_y[0]>=23&&body_y[0]<=28) |
									(body_y[0] == 21&&body_x[0] ==7 ))) && extra_wall == 1)
								
								
										meet_wl <= 1;
									
									
									
						else if 
							( ( body_y[0] == body_y[1] && body_x[0] == body_x[1] && have_body[1] == 1 )  
								|( body_y[0] == body_y[2] && body_x[0] == body_x[2] && have_body[2] == 1 )
								| ( body_y[0] == body_y[3] && body_x[0] == body_x[3] && have_body[3] == 1 )
 								| ( body_y[0] == body_y[4] && body_x[0] == body_x[4] && have_body[4] == 1 )
								| ( body_y[0] == body_y[5] && body_x[0] == body_x[5] && have_body[5] == 1 )
								| ( body_y[0] == body_y[6] && body_x[0] == body_x[6] && have_body[6] == 1 )
								| ( body_y[0] == body_y[7] && body_x[0] == body_x[7] && have_body[7] == 1 )
								| ( body_y[0] == body_y[8] && body_x[0] == body_x[8] && have_body[8] == 1 )
								| ( body_y[0] == body_y[9] && body_x[0] == body_x[9] && have_body[9] == 1 )
								| ( body_y[0] == body_y[10] && body_x[0] == body_x[10] && have_body[10] == 1 ) 
								| ( body_y[0] == body_y[11] && body_x[0] == body_x[11] && have_body[11] == 1 ) 
								| ( body_y[0] == body_y[12] && body_x[0] == body_x[12] && have_body[12] == 1 ) 
								| ( body_y[0] == body_y[13] && body_x[0] == body_x[13] && have_body[13] == 1 ) 
								| ( body_y[0] == body_y[14] && body_x[0] == body_x[14] && have_body[14] == 1 )
								| ( body_y[0] == body_y[15] && body_x[0] == body_x[15] && have_body[15] == 1 )
                         | ( body_y[0] == body_y[16] && body_x[0] == body_x[16] && have_body[16] == 1 )
								 | ( body_y[0] == body_y[17] && body_x[0] == body_x[17] && have_body[17] == 1 )
								 | ( body_y[0] == body_y[18] && body_x[0] == body_x[18] && have_body[18] == 1 )
								 | ( body_y[0] == body_y[19] && body_x[0] == body_x[19] && have_body[19] == 1 )
								 | ( body_y[0] == body_y[20] && body_x[0] == body_x[20] && have_body[20] == 1 )
	
								 | ( body_y[0] == body_y[21] && body_x[0] == body_x[21] && have_body[21] == 1 ))
									meet_bd <= 1;
						else 
							begin
								body_x[1] <= body_x[0];
								body_y[1] <= body_y[0];
								
								body_x[2] <= body_x[1]; 
								body_y[2] <= body_y[1];
								
								body_x[3] <= body_x[2]; 
								body_y[3] <= body_y[2];
								
								body_x[4] <= body_x[3]; 
								body_y[4] <= body_y[3];

								body_x[5] <= body_x[4]; 
								body_y[5] <= body_y[4];
								
								body_x[6] <= body_x[5]; 
								body_y[6] <= body_y[5];
								
								body_x[7] <= body_x[6]; 
								body_y[7] <= body_y[6];
								
								body_x[8] <= body_x[7];
							    body_y[8] <= body_y[7];
								
								body_x[9] <= body_x[8]; 
								body_y[9] <= body_y[8];
								
								body_x[10] <= body_x[9]; 
								body_y[10] <= body_y[9];
								
								body_x[11] <= body_x[10]; 
								body_y[11] <= body_y[10];
								
								body_x[12] <= body_x[11];
								body_y[12] <= body_y[11];
								
								body_x[13] <= body_x[12]; 
								body_y[13] <= body_y[12];
								
								body_x[14] <= body_x[13];
								body_y[14] <= body_y[13];
								
								body_x[15] <= body_x[14];
								body_y[15] <= body_y[14];
								
								body_x[16] <= body_x[15];
								body_y[16] <= body_y[15];
								
								body_x[17] <= body_x[16];
								body_y[17] <= body_y[16];
								
								body_x[18] <= body_x[17];
								body_y[18] <= body_y[17];
								
								body_x[19] <= body_x[18];
								body_y[19] <= body_y[18];
								
								body_x[20] <= body_x[19];
								body_y[20] <= body_y[19];
								
								body_x[21] <= body_x[20];
								body_y[21] <= body_y[20];

							case (dir)

								DIR_UP: begin
									if( body_y[0] == 1 )
										meet_wl <= 1;
									else 
										body_y[0] <= body_y[0] - 1;
									end

								DIR_DOWN: begin
									if( body_y[0] == 28 )
										meet_wl <= 1;
									else
										body_y[0] <= body_y[0] + 1;
									   end
						
								DIR_LEFT:begin
									if( body_x[0] == 1 )
										meet_wl <= 1;
									else 
										body_x[0] <= body_x[0] - 1;
									end	
						
								DIR_RIGHT: begin
										if( body_x[0] == 38 )
											meet_wl <= 1;
										else
											body_x[0] <= body_x[0] + 1;
										end
							endcase
							
						end
					
						end
						end
						end
			







always @( posedge clk or posedge reset ) begin
		if( reset ) 
		begin
			have_body <= 22'b0000000000000000000111;
			body_length <= 3;
			addbody_state <= 0;
			extra_wall <= 0;
			level <= 0;
		end
		
		else begin
			case( addbody_state )
			0: begin
				if( add_score ) 
				begin
					body_length <= body_length + 1;
					have_body[body_length] <= 1;
					addbody_state <= 1;
				end
			   end
			
			1: begin
				
				if(!add_score)
					addbody_state <= 0;	
				end
			endcase
			
			if(body_length >= 7)
			  extra_wall <= 1;

			if(body_length >= 9 && level == 0)
			  begin
			  	level <= 1;
				
		
			  end
		end		
end


always @( loc_x or loc_y ) begin
	if( loc_x >= 0 && loc_x < 640 && loc_y >= 0 && loc_y < 480 ) 
		begin
			if( ( loc_x[9:4] == 0 | loc_y[9:4] == 0 | loc_x[9:4] == 39 | loc_y[9:4] == 29 ) )
			
				snake = SNAKE_WALL;
			
			
			
			 else if(( loc_y[9:4] == 21&& loc_x[9:4] >=1 && loc_x[9:4]<=6 ) | (loc_y[9:4] == 8&&loc_x[9:4]>=33&&loc_x[9:4]<=38)
| ( loc_x[9:4] == 7&&loc_y[9:4] >=1&&loc_y[9:4] <=6   ) | ( loc_x[9:4] == 31&&loc_y[9:4] >=23 && loc_y[9:4]<=28)&&extra_wall==1)	 
				
				
			    snake = EXTRA_WALL;
				
				
			  	
			
			else if( loc_x[9:4] == body_x[0] && loc_y[9:4] == body_y[0] && have_body[0] == 1 ) 
			 begin
				if(state != DEAD)
					snake =SNAKE_HEAD;
				else if ( dsignal == 1 && state == DEAD  ) 
					snake = ( dsignal == 1 && state == DEAD ) ? SNAKE_HEAD : SNAKE_BLANK;
			 end
			
			else if
					( ( loc_x[9:4] == body_x[1] && loc_y[9:4] == body_y[1] && have_body[1] == 1 )
						| ( loc_x[9:4] == body_x[2] && loc_y[9:4] == body_y[2] && have_body[2] == 1 )
						| ( loc_x[9:4] == body_x[3] && loc_y[9:4] == body_y[3] && have_body[3] == 1 )
						| ( loc_x[9:4] == body_x[4] && loc_y[9:4] == body_y[4] && have_body[4] == 1 )
						| ( loc_x[9:4] == body_x[5] && loc_y[9:4] == body_y[5] && have_body[5] == 1 )
						| ( loc_x[9:4] == body_x[6] && loc_y[9:4] == body_y[6] && have_body[6] == 1 )
						| ( loc_x[9:4] == body_x[7] && loc_y[9:4] == body_y[7] && have_body[7] == 1 )
						| ( loc_x[9:4] == body_x[8] && loc_y[9:4] == body_y[8] && have_body[8] == 1 )
						| ( loc_x[9:4] == body_x[9] && loc_y[9:4] == body_y[9] && have_body[9] == 1 )
					| ( loc_x[9:4] == body_x[10] && loc_y[9:4] == body_y[10] && have_body[10] == 1 )
					| ( loc_x[9:4] == body_x[11] && loc_y[9:4] == body_y[11] && have_body[11] == 1 )
					| ( loc_x[9:4] == body_x[12] && loc_y[9:4] == body_y[12] && have_body[12] == 1 )
					| ( loc_x[9:4] == body_x[13] && loc_y[9:4] == body_y[13] && have_body[13] == 1 )
					| ( loc_x[9:4] == body_x[14] && loc_y[9:4] == body_y[14] && have_body[14] == 1 )
					| ( loc_x[9:4] == body_x[15] && loc_y[9:4] == body_y[15] && have_body[15] == 1 )
					| ( loc_x[9:4] == body_x[16] && loc_y[9:4] == body_y[16] && have_body[16] == 1 )
					| ( loc_x[9:4] == body_x[17] && loc_y[9:4] == body_y[17] && have_body[17] == 1 )
					| ( loc_x[9:4] == body_x[18] && loc_y[9:4] == body_y[18] && have_body[18] == 1 )
               | ( loc_x[9:4] == body_x[19] && loc_y[9:4] == body_y[19] && have_body[19] == 1 )
					| ( loc_x[9:4] == body_x[20] && loc_y[9:4] == body_y[20] && have_body[20] == 1 )
					| ( loc_x[9:4] == body_x[21] && loc_y[9:4] == body_y[21] && have_body[21] == 1 ))
						begin
						if(state != DEAD)
							snake = SNAKE_BODY;
						else if ( dsignal == 1 && state == DEAD  ) 
							snake = ( dsignal == 1 && state == DEAD ) ? SNAKE_BODY : SNAKE_BLANK;
						end

			else
				snake = SNAKE_BLANK;
		end

	end	 

endmodule











