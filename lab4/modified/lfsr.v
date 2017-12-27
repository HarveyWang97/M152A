//-----------------------------------------------------
// Design Name : lfsr
// File Name   : lfsr.v
// Function    : Linear feedback shift register
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module lfsr    (
outx             ,  // Output of the counter
outy , // Enable  for counter
clk             ,  // clock input
reset              // reset input
);

//----------Output Ports--------------
/*output [10:0] out;
//------------Input Ports--------------
//input [7:0] data;
input  clk, reset;
//------------Internal Variables--------
reg [10:0] out;
wire        linear_feedback;

//-------------Code Starts Here-------
assign linear_feedback = !(out[7] ^ out[3]);

always @(posedge clk) begin
if (reset) begin // active high reset
  out <= 11'b0 ;
end else  begin
  out <= {out[9],out[8],
          out[7],out[6],
          out[5],out[4],
			 out[3],out[2],
			 out[1],
          out[0], linear_feedback};
end 
end*/


input clk, reset;
output [5:0] outx;
output [4:0] outy;


reg [5:0] randnumx;
reg [4:0] randnumy;

always @(posedge clk) begin
if (reset) begin // active high reset
  randnumx = 6'b0 ;
  randnumy = 5'b0 ;
  end
else begin
randnumx = randnumx+312;
randnumy = randnumy+350;
if(randnumx > 38 || randnumx == 0)
            begin
              if(randnumx > 38)
                randnumx = randnumx - 28;
              if(randnumx <= 0)
                randnumx = 1;
            end
          
          

          if(randnumy > 28 || randnumy == 0)
            begin
              if(randnumy > 28)
                randnumy = randnumy - 8;
              if(randnumy <= 0)
                randnumy = 1;
            end
          
          

        
end
end

assign outx = randnumx;
assign outy = randnumy;

endmodule // End Of Module counter */


