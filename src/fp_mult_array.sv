module fp_mult_array (  
	input logic 		      clk,
	input logic 		      rst_n,
	input logic 		      mult_op_sel,
	input logic 		      mult_en,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_0,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_1, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_2,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_3,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_4,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_5, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_6,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_7, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_8,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_9, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_10,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_11,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_12,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_13, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_14,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_15,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_16,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_17, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_18,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_19,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_20,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_21, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_22,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_23, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_24,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_25, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_26,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_27,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_28,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_29, 
	input logic [DATA_WIDTH-1:0]  weight_regs_in_30,
	input logic [DATA_WIDTH-1:0]  weight_regs_in_31,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_0,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_1, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_2,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_3,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_4,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_5, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_6,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_7, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_8,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_9, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_10,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_11,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_12,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_13, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_14,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_15,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_16,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_17, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_18,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_19,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_20,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_21, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_22,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_23, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_24,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_25, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_26,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_27,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_28,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_29, 
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_30,
	input logic [DATA_WIDTH-1:0]  data_vec_regs_in_31,
	output logic [DATA_WIDTH-1:0] data_out_0,
	output logic [DATA_WIDTH-1:0] data_out_1, 
	output logic [DATA_WIDTH-1:0] data_out_2, 
	output logic [DATA_WIDTH-1:0] data_out_3, 
	output logic [DATA_WIDTH-1:0] data_out_4, 
	output logic [DATA_WIDTH-1:0] data_out_5, 
	output logic [DATA_WIDTH-1:0] data_out_6, 
	output logic [DATA_WIDTH-1:0] data_out_7, 
	output logic [DATA_WIDTH-1:0] data_out_8, 
	output logic [DATA_WIDTH-1:0] data_out_9, 
	output logic [DATA_WIDTH-1:0] data_out_10, 
	output logic [DATA_WIDTH-1:0] data_out_11, 
	output logic [DATA_WIDTH-1:0] data_out_12, 
	output logic [DATA_WIDTH-1:0] data_out_13, 
	output logic [DATA_WIDTH-1:0] data_out_14, 
	output logic [DATA_WIDTH-1:0] data_out_15, 
	output logic [DATA_WIDTH-1:0] data_out_16, 
	output logic [DATA_WIDTH-1:0] data_out_17, 
	output logic [DATA_WIDTH-1:0] data_out_18, 
	output logic [DATA_WIDTH-1:0] data_out_19, 
	output logic [DATA_WIDTH-1:0] data_out_20, 
	output logic [DATA_WIDTH-1:0] data_out_21, 
	output logic [DATA_WIDTH-1:0] data_out_22, 
	output logic [DATA_WIDTH-1:0] data_out_23, 
	output logic [DATA_WIDTH-1:0] data_out_24, 
	output logic [DATA_WIDTH-1:0] data_out_25, 
	output logic [DATA_WIDTH-1:0] data_out_26, 
	output logic [DATA_WIDTH-1:0] data_out_27, 
	output logic [DATA_WIDTH-1:0] data_out_28, 
	output logic [DATA_WIDTH-1:0] data_out_29, 
	output logic [DATA_WIDTH-1:0] data_out_30, 
	output logic [DATA_WIDTH-1:0] data_out_31,
	output logic 		      data_out_vec_vld		    
	);

genvar i;

logic [DATA_WIDTH-1:0] 	    data_out[0:31];
logic [DATA_WIDTH-1:0] 	    weight_regs[0:31];
logic [DATA_WIDTH-1:0] 	    data_vec_regs[0:31];
logic [DATA_WIDTH-1:0]		 data_out_vld;


   assign data_out_0  = data_out[ 0 ]  ;
   assign data_out_1  = data_out[ 1 ]  ; 
   assign data_out_2  = data_out[ 2 ]  ;
   assign data_out_3  = data_out[ 3 ]  ;
   assign data_out_4  = data_out[ 4 ]  ;
   assign data_out_5  = data_out[ 5 ]  ; 
   assign data_out_6  = data_out[ 6 ]  ;
   assign data_out_7  = data_out[ 7 ]  ; 
   assign data_out_8  = data_out[ 8 ]  ;
   assign data_out_9  = data_out[ 9 ]  ; 
   assign data_out_10 = data_out [10 ] ;
   assign data_out_11 = data_out [11 ] ;
   assign data_out_12 = data_out [12 ] ;
   assign data_out_13 = data_out [13 ] ; 
   assign data_out_14 = data_out [14 ] ;
   assign data_out_15 = data_out [15 ] ;
   assign data_out_16 = data_out [16 ] ;
   assign data_out_17 = data_out [17 ] ; 
   assign data_out_18 = data_out [18 ] ;
   assign data_out_19 = data_out [19 ] ;
   assign data_out_20 = data_out [20 ] ;
   assign data_out_21 = data_out [21 ] ; 
   assign data_out_22 = data_out [22 ] ;
   assign data_out_23 = data_out [23 ] ; 
   assign data_out_24 = data_out [24 ] ;
   assign data_out_25 = data_out [25 ] ; 
   assign data_out_26 = data_out [26 ] ;
   assign data_out_27 = data_out [27 ] ;
   assign data_out_28 = data_out [28 ] ;
   assign data_out_29 = data_out [29 ] ; 
   assign data_out_30 = data_out [30 ] ;
   assign data_out_31 = data_out [31 ] ;   

   assign weight_regs[ 0 ] = weight_regs_in_0;
   assign weight_regs[ 1 ] = weight_regs_in_1; 
   assign weight_regs[ 2 ] = weight_regs_in_2;
   assign weight_regs[ 3 ] = weight_regs_in_3;
   assign weight_regs[ 4 ] = weight_regs_in_4;
   assign weight_regs[ 5 ] = weight_regs_in_5; 
   assign weight_regs[ 6 ] = weight_regs_in_6;
   assign weight_regs[ 7 ] = weight_regs_in_7; 
   assign weight_regs[ 8 ] = weight_regs_in_8;
   assign weight_regs[ 9 ] = weight_regs_in_9; 
   assign weight_regs[10 ] = weight_regs_in_10;
   assign weight_regs[11 ] = weight_regs_in_11;
   assign weight_regs[12 ] = weight_regs_in_12;
   assign weight_regs[13 ] = weight_regs_in_13; 
   assign weight_regs[14 ] = weight_regs_in_14;
   assign weight_regs[15 ] = weight_regs_in_15;
   assign weight_regs[16 ] = weight_regs_in_16;
   assign weight_regs[17 ] = weight_regs_in_17; 
   assign weight_regs[18 ] = weight_regs_in_18;
   assign weight_regs[19 ] = weight_regs_in_19;
   assign weight_regs[20 ] = weight_regs_in_20;
   assign weight_regs[21 ] = weight_regs_in_21; 
   assign weight_regs[22 ] = weight_regs_in_22;
   assign weight_regs[23 ] = weight_regs_in_23; 
   assign weight_regs[24 ] = weight_regs_in_24;
   assign weight_regs[25 ] = weight_regs_in_25; 
   assign weight_regs[26 ] = weight_regs_in_26;
   assign weight_regs[27 ] = weight_regs_in_27;
   assign weight_regs[28 ] = weight_regs_in_28;
   assign weight_regs[29 ] = weight_regs_in_29; 
   assign weight_regs[30 ] = weight_regs_in_30;
   assign weight_regs[31 ] = weight_regs_in_31;

   assign data_vec_regs[ 0 ] = data_vec_regs_in_0;
   assign data_vec_regs[ 1 ] = data_vec_regs_in_1; 
   assign data_vec_regs[ 2 ] = data_vec_regs_in_2;
   assign data_vec_regs[ 3 ] = data_vec_regs_in_3;
   assign data_vec_regs[ 4 ] = data_vec_regs_in_4;
   assign data_vec_regs[ 5 ] = data_vec_regs_in_5; 
   assign data_vec_regs[ 6 ] = data_vec_regs_in_6;
   assign data_vec_regs[ 7 ] = data_vec_regs_in_7; 
   assign data_vec_regs[ 8 ] = data_vec_regs_in_8;
   assign data_vec_regs[ 9 ] = data_vec_regs_in_9; 
   assign data_vec_regs[10 ] = data_vec_regs_in_10;
   assign data_vec_regs[11 ] = data_vec_regs_in_11;
   assign data_vec_regs[12 ] = data_vec_regs_in_12;
   assign data_vec_regs[13 ] = data_vec_regs_in_13; 
   assign data_vec_regs[14 ] = data_vec_regs_in_14;
   assign data_vec_regs[15 ] = data_vec_regs_in_15;
   assign data_vec_regs[16 ] = data_vec_regs_in_16;
   assign data_vec_regs[17 ] = data_vec_regs_in_17; 
   assign data_vec_regs[18 ] = data_vec_regs_in_18;
   assign data_vec_regs[19 ] = data_vec_regs_in_19;
   assign data_vec_regs[20 ] = data_vec_regs_in_20;
   assign data_vec_regs[21 ] = data_vec_regs_in_21; 
   assign data_vec_regs[22 ] = data_vec_regs_in_22;
   assign data_vec_regs[23 ] = data_vec_regs_in_23; 
   assign data_vec_regs[24 ] = data_vec_regs_in_24;
   assign data_vec_regs[25 ] = data_vec_regs_in_25; 
   assign data_vec_regs[26 ] = data_vec_regs_in_26;
   assign data_vec_regs[27 ] = data_vec_regs_in_27;
   assign data_vec_regs[28 ] = data_vec_regs_in_28;
   assign data_vec_regs[29 ] = data_vec_regs_in_29; 
   assign data_vec_regs[30 ] = data_vec_regs_in_30;
   assign data_vec_regs[31 ] = data_vec_regs_in_31;

   assign data_out_vec_vld = &data_out_vld;
   
   
generate
   for (i = 0; i < 32; i++) begin: generate_id 
		fp_mult i_fp_mult(  .clk,
  .rst_n,
  .mult_op_sel,
  .mult_en,
  .data_1(weight_regs[i]),
  .data_2(data_vec_regs[i]),
  .data_prod_o(data_out[i]),
  .data_prod_o_vld(data_out_vld[i])
);
	end
endgenerate




endmodule
