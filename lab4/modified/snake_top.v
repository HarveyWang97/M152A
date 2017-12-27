`timescale 1ns / 1ps


module snake_top (
input clk, 
input reset, 
input left,  
input right,  
input up,  
input down, 
output hsync, 
output vsync, 
output wire [2:0] red,	
output wire [2:0] green,
output wire [1:0] blue,	
output [7:0] seg,  
output [3:0] anode
);

//wire left, right, up, down; 
wire [2:0] snake;
wire [9:0] loc_x;
wire [9:0] loc_y;
wire [5:0] food_x; 
wire [4:0] food_y;
wire [5:0] head_x; 
wire [5:0] head_y; 
wire [5:0] randnumx;
wire [4:0] randnumy;
wire add_score;
wire [1:0] state; 
wire meet_wl;
wire meet_bd;
wire dsignal;

wire [6:0] body_length;
wire vgaclk;
wire segclk;

wire sixclk;
wire fastclk;
wire restart;
wire foodclk;

clockdiv generate_signal(
.clk(clk),
.clr(reset),
.dclk(vgaclk),
.segclk(segclk),
.foodclk(foodclk),
.sixclk(sixclk),
.fastclk(fastclk)
);

lfsr generate_random(
.outx(randnumx),
.outy(randnumy),
.clk(clk),
.reset(reset)
);



Snake_movement move(
.clk(clk),
.sixclk(sixclk),
.fastclk(fastclk),
.reset(reset),
.left_btn(left),
.right_btn(right),
.up_btn(up),
.down_btn(down),
.snake(snake),
.loc_x(loc_x),
.loc_y(loc_y),
.head_x(head_x),
.head_y(head_y),
.add_score(add_score),
.state(state),
.body_length(body_length),
.meet_bd(meet_bd),
.meet_wl(meet_wl),
.dsignal(dsignal) 
);


gamecontrol game_ctrl( 
.clk(clk),
.reset(reset),
.left(left),
.right(right),
.up(up),
.down(down),
.state(state),
.meet_wl(meet_wl),
.meet_bd(meet_bd),
//.restart(restart),
.dsignal(dsignal)

); 


eat_food  eating(
.clk(clk),
.foodclk(foodclk),
.rst(reset),
.xstart(head_x),
.ystart(head_y),
.xfood(food_x),
.yfood(food_y),
.incl(add_score)
);




vga_control vga_display(
.clk(vgaclk),
.rst(reset),
.snake(snake),
.xfood(food_x),
.yfood(food_y),
.x(loc_x),
.y(loc_y),
.hsync(hsync),
.vsync(vsync),
.red(red),
.green(green),
.blue(blue)
);


display_score display(
.clk(clk),
.segclk(segclk),
.reset(reset),
.add_score(add_score),
.segout(seg),
.anode(anode)

);

endmodule























