`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:48 04/25/2017 
// Design Name: 
// Module Name:    FPCVT 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FPCVT(
	input wire [11:0] D,
	output reg S,
	output reg [2:0] E,
	output reg [3:0] F
    );
	 
reg [11:0] tmp;
reg [11:0] newtmp;
integer lead_zero,i;

always @D begin
	S = D[11];
	lead_zero =0 ;
	
	if( S == 0 )
	 tmp=D;
	else
	 tmp=~D+1;
	
   i=11;
   while(i>0&&tmp[i]==0)	
	begin
	  lead_zero=lead_zero+1;
	  i=i-1;
	end
	
	if(i==0&&tmp[i]==0)
	 lead_zero=lead_zero+1;
	
	
	
	//for(i=11;i>=0&&!tmp[i];i=i-1)
	//begin
		// lead_zero=lead_zero+1;
	//end
	
	if(lead_zero<=8)
	 E=8-lead_zero;
	else
	 E=0;
	
	if(lead_zero<8)
	begin
	newtmp = tmp << lead_zero;
	F = newtmp [11:8];
	if(newtmp[7]==1)
	begin
	 if( F == 15)
	  begin
	   F = 8;
		if(E != 7)
		 E=E+1;
		else
		 F=15;
		end
	 else
	  F = F+1;
	end
	end
	
	else
	begin
	 F = tmp[3:0];
	end
	
	/* 
	if(lead_zero == 8)
	 F = tmp[3:0]; 
	 
	if(lead_zero == 9)
	 begin
		F[3] = 0;
		F[2:0] = tmp[2:0];
	 end
	 
	if(lead_zero == 9)
	 begin
		F[3] = 0;
		F[2:0] = tmp[2:0];
	 end
	*/
	 
	if(D == 12'b100000000000)
	begin
	 E = 7;
	 F = 15;
	end
	  
	 
end
		 
	 
	
endmodule
