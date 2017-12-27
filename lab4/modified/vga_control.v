`timescale 1ns / 1ps

module vga_control(
  input clk,
  input rst,
  input [2:0] snake,
  input [5:0] xfood,
  input [4:0] yfood,
  output reg [9:0] x,
  output reg [9:0] y,
  output  hsync,
  output  vsync,
  output reg [2:0] red,
  output reg [2:0] green,
  output reg [1:0] blue
  );

  //reg clk25;      //we need to change the clock to 25MHz

localparam s_blank = 3'b000;
localparam s_start = 3'b001;
localparam s_body = 3'b010;
localparam s_wall = 3'b011;
localparam extra_wall = 3'b100;

  reg [3:0] loc_x;
  reg [3:0] loc_y;

parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96;  // hsync pulse length
parameter vpulse = 2;   // vsync pulse length
parameter hbp = 144;  // end of horizontal back porch
parameter hfp = 784;  // beginning of horizontal front porch
parameter vbp = 31;     // end of vertical back porch
parameter vfp = 511;  // beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;


always @(posedge clk or posedge rst )
begin
  // reset condition
  if (rst)
  begin
    hc <= 0;
    vc <= 0;
  end
  else
  begin
    x <= hc - 144;
    y <= vc - 31;
    // keep counting until the end of the line
    if (hc < hpixels - 1)
      hc <= hc + 1;
    else
    // When we hit the end of the line, reset the horizontal
    // counter and increment the vertical counter.
    // If vertical counter is at the end of the frame, then
    // reset that one too.
    begin
      hc <= 0;
      if (vc < vlines - 1)
        vc <= vc + 1;
      else
        vc <= 0;
    end
    
  end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;





always @(*)begin
  if(x >= 0 && x<=640 && y >= 0 && y <= 480 )
  begin
    loc_x <= x[3:0];
    loc_y <= y[3:0];
    if(x[9:4] == xfood && y[9:4] == yfood)
    begin
      case({loc_x, loc_y})
      8'b0000_0000: 
      begin
        red = 3'b000;
        green = 3'b000;
        blue = 2'b00;
      end
      default:
      begin
        red = 3'b111;
        green = 3'b000;
        blue = 2'b00;
      end
      endcase
		end

      else if (snake == s_blank)
      begin
        red = 3'b000;
        green = 3'b000;
        blue = 2'b00;
      end

      else if (snake == s_start)
      begin
        red = 3'b111;
        green = 3'b000;
        blue = 2'b11;
      end

      else if (snake == s_body)
      begin
        red = 3'b000;
        green = 3'b111;
        blue = 2'b00;
      end

      else if (snake == s_wall)
      begin
        red = 3'b111;
		    green = 3'b111;
		    blue = 2'b00;
      end
		
		else if (snake == extra_wall)
		begin
		   red = 3'b111;
		    green = 3'b111;
		    blue = 2'b11;
			 
			 
		end
		else
		begin
		  red = 3'b000;
		  green = 3'b000;
		  blue = 2'b00;
		end

    end
	 
	 
	 else
	 begin
	   red = 3'b000;
		green = 3'b000;
		blue = 2'b00;
	 end
	 
	 end
  
  
  endmodule









