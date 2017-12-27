`timescale 1ns / 1ps

module clock_div(
    input clk,
    input rst,
	 input pause,
    output  ohz_clk,      //1hz clock, for normal counting
    output thz_clk,      //2hz clock, for set time counting
    output  fhhz_clk,     //500hz clock, for ssd
    output  fhz_clk      //5hz clock, for blinking
);

integer ohz_ct, thz_ct, fhhz_ct, fhz_ct;
reg ohz,thz,fhhz,fhz;

always @ (posedge clk)begin
   if(rst)
   begin
     ohz_ct <= 0;
     thz_ct <= 0;
     fhhz_ct <= 0;
     fhz_ct <= 0;
  
     ohz <= 0;
     thz <= 0;
     fhhz <= 0;
     fhz <= 0;
   end
   
   else begin
     ohz_ct <= ohz_ct + 1;
     thz_ct <= thz_ct + 1;
     fhhz_ct <= fhhz_ct + 1;
     fhz_ct <= fhz_ct + 1;
   
   //the input clock is 100MHz
     //adjust 1hz clock
     if (ohz_ct == 100000000 - 1) begin
            ohz <= 1;
            ohz_ct <= 0;
        end
    else 
        ohz <= 0;
    
     //adjust 2hz clock  
     if (thz_ct == 50000000 - 1) begin
            thz <= 1;
            thz_ct <= 0;
        end
     else
        thz <= 0;
        
     //adjust 500hz clock
     if (fhhz_ct == 300000 - 1) begin
            fhhz <= 1;
            fhhz_ct <= 0;
        end
     else
        fhhz <= 0;
        
     //adjust 5hz clock
     if (fhz_ct == 20000000 - 1) begin
            fhz <= 1;
            fhz_ct <= 0;
        end
     else
         fhz <= 0;
         
     end
   end

assign ohz_clk = ohz;
assign thz_clk = thz;
assign fhhz_clk = fhhz;
assign fhz_clk = fhz;

endmodule
    
      
        
     