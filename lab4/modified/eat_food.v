
module eat_food(
  input clk,
  input foodclk,
  input rst,

  input [5:0] xstart,
  input [5:0] ystart,

  output reg [5:0] xfood,
  output reg [4:0] yfood,
  output reg incl

);

  /*reg [31:0] clk_ct = 0;
	
   wire [6:0] rx = randnumx;
	wire [5:0] ry = randnumy;
	





  always @ (posedge foodclk or posedge rst) begin
    if(rst) begin
      clk_ct <= 0;
      xfood <= 24;
      yfood <= 10;
      incl <= 0;
    end

    else begin
     
        if(xstart == xfood && ystart == yfood)
        begin
          incl <= 1;

         
			 xfood <= rx%37+1;
			 yfood <= ry%27+1;
        
        end
		  
        else
          incl <= 0;
      
		end
   
  end
  
 endmodule*/



reg [31:0] clk_ct = 0;
  reg [10:0] randnum = 0;

  always @ (posedge clk) begin
    randnum <= randnum + 242;
  end

  always @ (posedge clk or posedge rst) begin
    if(rst) begin
      clk_ct <= 0;
      xfood <= 24;
      yfood <= 10;
      incl <= 0;
    end

    else begin
      clk_ct <= clk_ct + 1;
      if(clk_ct == 250000) begin
        clk_ct <= 0;
        if(xstart == xfood && ystart == yfood)
        begin
          incl <= 1;
          if(randum[10:5] > 38 || randnum[10:5] == 0)
            begin
              if(randnum[10:5] > 38)
                xfood <= randnum[10:5] - 25;
              else 
                xfood <= 1;
            end
          
          else 
            xfood <= randnum[10:5];

          if(randum[4:0] > 28 || randnum[4:0] == 0)
            begin
              if(randnum[4:0] > 28)
                yfood <= randnum[4:0] - 3;
              else 
                yfood <= 1;
            end
          
          else 
            yfood <= randnum[4:0];
            
      
        end

        else
          incl <= 0;
      end
    end
  end
  
 endmodule