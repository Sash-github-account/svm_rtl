module accumulator (
		    input logic			 				 clk,
		    input logic			 				 rst_n,
		    input logic [DATA_WIDTH-1:0] 	 data_in,
		    input logic							 stg_en,
		    output logic [DATA_WIDTH-1:0 ] 	 accum_data_out,
			 output logic							 accum_data_vld
		    );





   // Accumulator sequential logic //
  always_ff@(posedge clk) begin
     if(!rst_n) begin
		 accum_data_out <= ACCUM_INIT;
		 accum_data_vld <= 0;
     end
     else begin
		 if(stg_en) begin
			 accum_data_out <= data_in;
			 accum_data_vld <= 1;
		 end
		 else begin
			 accum_data_out <=  ACCUM_INIT;
			 accum_data_vld <= 0;
		 end
     end // else: !if(rsn_n)
   end // always@ (posedge clk or negedge rst_n)
   //______________//


   
endmodule // accumulator