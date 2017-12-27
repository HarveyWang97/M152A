`timescale 1ns / 1ps

module debouncer(
    input wire clk,
    input wire input_btn,
    output wire bstate
);
    reg bstatetmp=0;
    
    reg [19:0] history;

    /*initial bstate = 0;
    
    always @(posedge clk) begin
    history <= {history[1:0], input_btn};
    if (history==3'b110)
       bstate <= ~bstate;*/
       
    always @ (posedge clk)
    begin
      if(input_btn==0)
        begin
          bstatetmp <= 0;
          history <= 0;
        end
      else
        begin
          history <= history + 1'b1;
          if (history == 5'hfffff)
            begin
              bstatetmp <= 1;
              history <= 0;
            end
        end
    end
	 assign bstate = bstatetmp;
       
endmodule