module fp_vec_add(
						input logic 		      clk,
						input logic 		      rst_n,
						input logic 		      comp_en,
						input logic 		      data_in_op_sel,
		  				input logic 		      accum_comp_en,
						input logic [31:0] 	      cur_accum_data,
						input logic [31:0] 	      accum_add_data,
						input logic [DATA_WIDTH-1:0]  data_0,
						input logic [DATA_WIDTH-1:0]  data_1, 
						input logic [DATA_WIDTH-1:0]  data_2,
						input logic [DATA_WIDTH-1:0]  data_3,
						input logic [DATA_WIDTH-1:0]  data_4,
						input logic [DATA_WIDTH-1:0]  data_5, 
						input logic [DATA_WIDTH-1:0]  data_6,
						input logic [DATA_WIDTH-1:0]  data_7, 
						input logic [DATA_WIDTH-1:0]  data_8,
						input logic [DATA_WIDTH-1:0]  data_9, 
						input logic [DATA_WIDTH-1:0]  data_10,
						input logic [DATA_WIDTH-1:0]  data_11,
						input logic [DATA_WIDTH-1:0]  data_12,
						input logic [DATA_WIDTH-1:0]  data_13, 
						input logic [DATA_WIDTH-1:0]  data_14,
						input logic [DATA_WIDTH-1:0]  data_15,
						input logic [DATA_WIDTH-1:0]  data_16,
						input logic [DATA_WIDTH-1:0]  data_17, 
						input logic [DATA_WIDTH-1:0]  data_18,
						input logic [DATA_WIDTH-1:0]  data_19,
						input logic [DATA_WIDTH-1:0]  data_20,
						input logic [DATA_WIDTH-1:0]  data_21, 
						input logic [DATA_WIDTH-1:0]  data_22,
						input logic [DATA_WIDTH-1:0]  data_23, 
						input logic [DATA_WIDTH-1:0]  data_24,
						input logic [DATA_WIDTH-1:0]  data_25, 
						input logic [DATA_WIDTH-1:0]  data_26,
						input logic [DATA_WIDTH-1:0]  data_27,
						input logic [DATA_WIDTH-1:0]  data_28,
						input logic [DATA_WIDTH-1:0]  data_29, 
						input logic [DATA_WIDTH-1:0]  data_30,
						input logic [DATA_WIDTH-1:0]  data_31,
						output logic [DATA_WIDTH-1:0] data_out,
						output logic 		      data_out_vld
		  );
  
 
   genvar 								      i;

   logic [DATA_WIDTH-1:0] 						      data_int[0:31];
   logic [DATA_WIDTH-1:0] 						      l1_add_data[0:15];
   logic [15:0]								      l1_data_vld;
   logic [DATA_WIDTH-1:0] 						      l2_add_data[0:7];
   logic [7:0]								      l2_data_vld;   
   logic [DATA_WIDTH-1:0] 						      l3_add_data[0:3];
   logic [3:0]								      l3_data_vld;   
   logic [DATA_WIDTH-1:0] 						      l4_add_data[0:1];
   logic [1:0]								      l4_data_vld;   
   logic [DATA_WIDTH-1:0] 						      final_add_data[0:0];
   logic [0:0]								      final_data_vld;   
   
   

	assign data_out = final_add_data[0];
	assign data_out_vld = final_data_vld;
   assign data_int[0] = data_0;
   assign data_int[ 1 ] = data_1;
   assign data_int[ 2 ] = data_2;
   assign data_int[ 3 ] = data_3;
   assign data_int[ 4 ] = data_4;
   assign data_int[ 5 ] = data_5;
   assign data_int[ 6 ] = data_6;
   assign data_int[ 7 ] = data_7;
   assign data_int[ 8 ] = data_8;
   assign data_int[ 9 ] = data_9; 
   assign data_int[10 ] = data_10;
   assign data_int[11 ] = data_11;
   assign data_int[12 ] = data_12;
   assign data_int[13 ] = data_13;
   assign data_int[14 ] = data_14;
   assign data_int[15 ] = data_15;
   assign data_int[16 ] = data_16;
   assign data_int[17 ] = data_17;
   assign data_int[18 ] = data_18;
   assign data_int[19 ] = data_19;
   assign data_int[20 ] = data_20;
   assign data_int[21 ] = data_21;
   assign data_int[22 ] = data_22;
   assign data_int[23 ] = data_23;
   assign data_int[24 ] = data_24;
   assign data_int[25 ] = data_25;
   assign data_int[26 ] = data_26;
   assign data_int[27 ] = data_27;
   assign data_int[28 ] = data_28;
   assign data_int[29 ] = data_29;
   assign data_int[30 ] = data_30;
   assign data_int[31 ] = data_31;
   
 
   generate
      for (i = 0; i < 32; i = i+2) begin: fp_add_l1 
	 fp_arith i_fp_arith(   
				.clk(clk),
				.rst_n(rst_n),
				.data_1(data_int[i]),
				.data_2(data_int[i+1]),
		 		.op_sel(data_in_op_sel),
  		 		.en(comp_en),
				.data_accum_o(l1_add_data[i/2]),
				.data_o_vld(l1_data_vld[i/2])
				);
      end
   endgenerate

   generate
      for (i = 0; i < 16; i = i+2) begin: fp_add_l2 
	 fp_arith i_fp_arith(   
				.clk(clk),
				.rst_n(rst_n),
				.data_1(l1_add_data[i]),
				.data_2(l1_add_data[i+1]),
		 		.op_sel(data_in_op_sel),
  		 		.en(&l1_data_vld),
				.data_accum_o(l2_add_data[i/2]),
				.data_o_vld(l2_data_vld[i/2])
				);
      end
   endgenerate

   generate
      for (i = 0; i < 8; i = i+2) begin: fp_add_l3 
	 fp_arith i_fp_arith(   
				.clk(clk),
				.rst_n(rst_n),
				.data_1(l2_add_data[i]),
				.data_2(l2_add_data[i+1]),
		 		.op_sel(data_in_op_sel),
  		 		.en(&l2_data_vld),
				.data_accum_o(l3_add_data[i/2]),
				.data_o_vld(l3_data_vld[i/2])
				);
      end
   endgenerate

   generate
      for (i = 0; i < 4; i = i+2) begin: fp_add_l4 
	 fp_arith i_fp_arith(   
				.clk(clk),
				.rst_n(rst_n),
				.data_1(l3_add_data[i]),
				.data_2(l3_add_data[i+1]),
		 		.op_sel(data_in_op_sel),
  		 		.en(&l3_data_vld),
				.data_accum_o(l4_add_data[i/2]),
				.data_o_vld(l4_data_vld[i/2])
				);
      end
   endgenerate


   logic [31:0] muxed_accum_cur_input;
   logic [31:0] muxed_accum_nxt_data;

   assign muxed_accum_cur_input = (accum_comp_en) ? cur_accum_data : l4_add_data[0];
   assign muxed_accum_nxt_data = (accum_comp_en) ? accum_add_data : l4_add_data[1] ;
   
   
   generate
      for (i = 0; i < 2; i = i+2) begin: fp_add_l5 
	 fp_arith i_fp_arith(   
				.clk(clk),
				.rst_n(rst_n),
				.data_1(muxed_accum_cur_input),
				.data_2(muxed_accum_nxt_data),
		 		.op_sel(data_in_op_sel),
  		 		.en(&l4_data_vld | accum_comp_en),
				.data_accum_o(final_add_data[i/2]),
				.data_o_vld(final_data_vld[i/2])
				);
      end
   endgenerate   
endmodule
