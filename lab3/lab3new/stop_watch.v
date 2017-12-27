`timescale 1ns / 1ps

module stop_watch(
    input clk,
	input rst,
	input pause,
	input wire select,
	input wire adjust,
	output reg [7:0] ssd,
	output reg [3:0] anode
	

);

wire [3:0] sec0_ct;
wire [3:0] sec1_ct;
wire [3:0] min0_ct;
wire [3:0] min1_ct;

wire [7:0] ssd_sec0;
wire [7:0] ssd_sec1;
wire [7:0] ssd_min0;
wire [7:0] ssd_min1;

wire [7:0] blink_segment_minute0;
wire [7:0] blink_segment_minute1;
wire [7:0] blink_segment_second0;
wire [7:0] blink_segment_second1;

wire ohz;    //normal counting
wire thz;    //double-speed counting
wire fhhz;   //ssd counting
wire fhz;    //blink counting

wire rst_mode;
wire pause_mode;
wire [7:0] blank;
reg [1:0] count = 0;

debouncer push_rst(   //use debouncer to lower the rate
  .input_btn(rst),
  .clk(clk),
  .bstate(rst_mode)
);

debouncer push_pause(
  .input_btn(pause),
  .clk(clk),
  .bstate(pause_mode)
);

clock_div clk_div(
  .clk(clk),
  .rst(rst_mode),
  .pause(pause_mode),
  .ohz_clk(ohz),
  .thz_clk(thz),
  .fhhz_clk(fhhz),
  .fhz_clk(fhz)
);

counter fsm(
  .clk(ohz),
  .adj_clk(thz),
  .adjust(adjust),
  .select(select),
  .rst(rst_mode),
  .pause(pause_mode),
  .sec0(sec0_ct),
  .sec1(sec1_ct),
  .min0(min0_ct),
  .min1(min1_ct)
  
);

seven_segment minute0(
  .digit(min0_ct),
  .Seven_seg_display(ssd_min0)
);

seven_segment minute1(
  .digit(min1_ct),
  .Seven_seg_display(ssd_min1)
);

seven_segment second0(
  .digit(sec0_ct),
  .Seven_seg_display(ssd_sec0)
);

seven_segment second1(
  .digit(sec1_ct),
  .Seven_seg_display(ssd_sec1)
);

seven_segment blank_display(
  .digit(4'b1111),
  .Seven_seg_display(blank)
);

blinking sec_mode(
  .clk(fhz),
  .isblink(adj&&sel),
  .digit1(ssd_sec0),
  .digit2(ssd_sec1),
  .out1(blink_segment_second0),
  .out2(blink_segment_second1)
);


blinking min_mode(
  .clk(fhz),
  .isblink(adj&&!sel),
  .digit1(ssd_min0),
  .digit2(ssd_min1),
  .out1(blink_segment_minute0),
  .out2(blink_segment_minute1)
);  

Display_digit final_display(
  .clk(fhhz),
  .digit0(blink_segment_second0),
  .digit1(blink_segment_second1),
  .digit2(blink_segment_minute0),
  .digit3(blink_segment_minute1),
  .output_display(ssd),
  .anode(anode)
);



















always @ (posedge fhhz)begin
  if(adjust == 1)
  begin
    if(select == 0)    //adjust minute
    begin
    
      if(count==0)
      begin
        anode <= 4'b0111;
        //if(fhz)
          ssd <= ssd_min1;
        //else
          //ssd <= blank;
        count <= count + 1;  
      end
      
      else if(count == 1)
      begin
        anode <= 4'b1011;
        //if(fhz)
          ssd <= ssd_min0;
        //else 
          //ssd <= blank;
        count <= count + 1;
      end
      
      else if(count == 2)
      begin
        anode <= 4'b1101;
        
        ssd <= ssd_sec1;
        
        count <= count + 1;
      end
      
      else if(count == 3)
      begin
        anode <= 4'b1110;
        
          ssd <= ssd_sec0;
        
        count <= count + 1;
      end
      
    end
    
    else if(select == 1)   //adjust second
    begin
    
      if(count == 0)
      begin
        anode <= 4'b0111;
        
        ssd <= ssd_min1;
        
        count <= count + 1;
      end
      
      else if(count == 1)
      begin
        anode <= 4'b1011;
        
        ssd <= ssd_min0;
        
        count <= count + 1;
      end
      
      else if(count == 2)
      begin
        anode <= 4'b1101;
        if(fhz)
          ssd <= ssd_sec1;
        else
          ssd <= blank;
        count <= count + 1;
      end
      
      else if(count == 3)
      begin
        anode <= 4'b1110;
        if(fhz)
          ssd <= ssd_sec0;
        else
          ssd <= blank;
        count <= count + 1;
      end
    end
    
  end
  
  else begin //the normal counting mode
    if(count == 0)
    begin
      anode <= 4'b0111;
      ssd <= ssd_min1;
      count <= count + 1;
    end
    
    else if(count == 1)
    begin
      anode <= 4'b1011;
      ssd <= ssd_min0;
      count <= count + 1;
    end
    
    else if(count == 2)
    begin
      anode <= 4'b1101;
      ssd <= ssd_sec1;
      count <= count + 1;
    end
    
    else if(count == 3)
    begin
      anode <= 4'b1110;
      ssd <= ssd_sec0;
      count <= count + 1;
    end
    
  end
end


endmodule













