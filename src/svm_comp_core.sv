module svm_comp_core(
		     input logic 		   clk,
		     input logic 		   rst_n,
		     input logic [DATA_WIDTH-1:0]  mem_mngr_data,
		     input logic 		   mem_mngr_data_vld,
		     output logic 		   pop_fifo,
		     input logic [5:0] 		   svm_ctrl_part_num_dim,
		     input logic 		   comp_start,
		     input logic 		   comp_en_for_accum, 
		     input logic 		   arr_wghtbar_data,
		     input logic 		   prog_accum_inputs,
		     input logic 		   clear_weights,
		     input logic 		   clear_data_vec,
		     input logic 		   accum_comp_en,
		     input logic [31:0] 	   cur_accum_data,
		     input logic [31:0] 	   accum_add_data,
		     output logic [DATA_WIDTH-1:0] data_out,
		     output logic 		   data_out_vld,
		     output logic 		   weights_progd,
		     output logic 		   data_vec_progd
		     );
   
   logic 					   loading_weights;
   logic 					   loading_data;
   logic [DATA_WIDTH-1:0] 			   weight_regs_0;
   logic [DATA_WIDTH-1:0] 			   weight_regs_1; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_2;
   logic [DATA_WIDTH-1:0] 			   weight_regs_3;
   logic [DATA_WIDTH-1:0] 			   weight_regs_4;
   logic [DATA_WIDTH-1:0] 			   weight_regs_5; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_6;
   logic [DATA_WIDTH-1:0] 			   weight_regs_7; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_8;
   logic [DATA_WIDTH-1:0] 			   weight_regs_9; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_10;
   logic [DATA_WIDTH-1:0] 			   weight_regs_11;
   logic [DATA_WIDTH-1:0] 			   weight_regs_12;
   logic [DATA_WIDTH-1:0] 			   weight_regs_13; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_14;
   logic [DATA_WIDTH-1:0] 			   weight_regs_15;
   logic [DATA_WIDTH-1:0] 			   weight_regs_16;
   logic [DATA_WIDTH-1:0] 			   weight_regs_17; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_18;
   logic [DATA_WIDTH-1:0] 			   weight_regs_19;
   logic [DATA_WIDTH-1:0] 			   weight_regs_20;
   logic [DATA_WIDTH-1:0] 			   weight_regs_21; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_22;
   logic [DATA_WIDTH-1:0] 			   weight_regs_23; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_24;
   logic [DATA_WIDTH-1:0] 			   weight_regs_25; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_26;
   logic [DATA_WIDTH-1:0] 			   weight_regs_27;
   logic [DATA_WIDTH-1:0] 			   weight_regs_28;
   logic [DATA_WIDTH-1:0] 			   weight_regs_29; 
   logic [DATA_WIDTH-1:0] 			   weight_regs_30;
   logic [DATA_WIDTH-1:0] 			   weight_regs_31;
   
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_0;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_1; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_2;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_3;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_4;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_5; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_6;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_7; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_8;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_9; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_10;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_11;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_12;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_13; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_14;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_15;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_16;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_17; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_18;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_19;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_20;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_21; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_22;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_23; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_24;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_25; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_26;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_27;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_28;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_29; 
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_30;
   logic [DATA_WIDTH-1:0] 			   data_vec_regs_31;

   logic [DATA_WIDTH-1:0] 			   data_out_0;
   logic [DATA_WIDTH-1:0] 			   data_out_1;
   logic [DATA_WIDTH-1:0] 			   data_out_2;
   logic [DATA_WIDTH-1:0] 			   data_out_3;
   logic [DATA_WIDTH-1:0] 			   data_out_4;
   logic [DATA_WIDTH-1:0] 			   data_out_5;
   logic [DATA_WIDTH-1:0] 			   data_out_6;
   logic [DATA_WIDTH-1:0] 			   data_out_7;
   logic [DATA_WIDTH-1:0] 			   data_out_8;
   logic [DATA_WIDTH-1:0] 			   data_out_9;
   logic [DATA_WIDTH-1:0] 			   data_out_10;
   logic [DATA_WIDTH-1:0] 			   data_out_11;
   logic [DATA_WIDTH-1:0] 			   data_out_12;
   logic [DATA_WIDTH-1:0] 			   data_out_13;
   logic [DATA_WIDTH-1:0] 			   data_out_14;
   logic [DATA_WIDTH-1:0] 			   data_out_15;
   logic [DATA_WIDTH-1:0] 			   data_out_16;
   logic [DATA_WIDTH-1:0] 			   data_out_17;
   logic [DATA_WIDTH-1:0] 			   data_out_18;
   logic [DATA_WIDTH-1:0] 			   data_out_19;
   logic [DATA_WIDTH-1:0] 			   data_out_20;
   logic [DATA_WIDTH-1:0] 			   data_out_21;
   logic [DATA_WIDTH-1:0] 			   data_out_22;
   logic [DATA_WIDTH-1:0] 			   data_out_23;
   logic [DATA_WIDTH-1:0] 			   data_out_24;
   logic [DATA_WIDTH-1:0] 			   data_out_25;
   logic [DATA_WIDTH-1:0] 			   data_out_26;
   logic [DATA_WIDTH-1:0] 			   data_out_27;
   logic [DATA_WIDTH-1:0] 			   data_out_28;
   logic [DATA_WIDTH-1:0] 			   data_out_29;
   logic [DATA_WIDTH-1:0] 			   data_out_30;
   logic [DATA_WIDTH-1:0] 			   data_out_31;	
   
   logic [DATA_WIDTH-1:0] 			   data_mux_out_0;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_1;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_2;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_3;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_4;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_5;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_6;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_7;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_8;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_9;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_10;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_11;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_12;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_13;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_14;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_15;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_16;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_17;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_18;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_19;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_20;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_21;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_22;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_23;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_24;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_25;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_26;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_27;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_28;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_29;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_30;
   logic [DATA_WIDTH-1:0] 			   data_mux_out_31;	

   logic 					   mult_op_sel = 0;
   
   assign loading_weights = !arr_wghtbar_data;
   assign loading_data = arr_wghtbar_data | prog_accum_inputs;

   assign data_mux_out_0 = (comp_en_for_accum) ? data_vec_regs_0 : data_out_0;
   assign data_mux_out_1  =  (comp_en_for_accum) ? data_vec_regs_1 : data_out_1;   
   assign data_mux_out_2  =  (comp_en_for_accum) ? data_vec_regs_2 : data_out_2;
   assign data_mux_out_3  =  (comp_en_for_accum) ? data_vec_regs_3 : data_out_3;   
   assign data_mux_out_4  =  (comp_en_for_accum) ? data_vec_regs_4 : data_out_4;
   assign data_mux_out_5  =  (comp_en_for_accum) ? data_vec_regs_5 : data_out_5;   
   assign data_mux_out_6  =  (comp_en_for_accum) ? data_vec_regs_6 : data_out_6;
   assign data_mux_out_7  =  (comp_en_for_accum) ? data_vec_regs_7 : data_out_7;      
   assign data_mux_out_8  =  (comp_en_for_accum) ? data_vec_regs_8 : data_out_8;
   assign data_mux_out_9  =  (comp_en_for_accum) ? data_vec_regs_9 : data_out_9;   
   assign data_mux_out_10  = (comp_en_for_accum) ? data_vec_regs_10 : data_out_10;
   assign data_mux_out_11  = (comp_en_for_accum) ? data_vec_regs_11 : data_out_11;   
   assign data_mux_out_12  = (comp_en_for_accum) ? data_vec_regs_12 : data_out_12;
   assign data_mux_out_13  = (comp_en_for_accum) ? data_vec_regs_13 : data_out_13;   
   assign data_mux_out_14  = (comp_en_for_accum) ? data_vec_regs_14 : data_out_14;
   assign data_mux_out_15  = (comp_en_for_accum) ? data_vec_regs_15 : data_out_15;   
   assign data_mux_out_16  = (comp_en_for_accum) ? data_vec_regs_16 : data_out_16;
   assign data_mux_out_17  = (comp_en_for_accum) ? data_vec_regs_17 : data_out_17;   
   assign data_mux_out_18  = (comp_en_for_accum) ? data_vec_regs_18 : data_out_18;
   assign data_mux_out_19  = (comp_en_for_accum) ? data_vec_regs_19 : data_out_19;   
   assign data_mux_out_20  = (comp_en_for_accum) ? data_vec_regs_20 : data_out_20;
   assign data_mux_out_21  = (comp_en_for_accum) ? data_vec_regs_21 : data_out_21;   
   assign data_mux_out_22  = (comp_en_for_accum) ? data_vec_regs_22 : data_out_22;
   assign data_mux_out_23  = (comp_en_for_accum) ? data_vec_regs_23 : data_out_23;      
   assign data_mux_out_24  = (comp_en_for_accum) ? data_vec_regs_24 : data_out_24;
   assign data_mux_out_25  = (comp_en_for_accum) ? data_vec_regs_25 : data_out_25;   
   assign data_mux_out_26  = (comp_en_for_accum) ? data_vec_regs_26 : data_out_26;
   assign data_mux_out_27  = (comp_en_for_accum) ? data_vec_regs_27 : data_out_27;   
   assign data_mux_out_28  = (comp_en_for_accum) ? data_vec_regs_28 : data_out_28;
   assign data_mux_out_29  = (comp_en_for_accum) ? data_vec_regs_29 : data_out_29;   
   assign data_mux_out_30  = (comp_en_for_accum) ? data_vec_regs_30 : data_out_30;
   assign data_mux_out_31  = (comp_en_for_accum) ? data_vec_regs_31 : data_out_31;   

   weights_n_data_vec_arr i_weights_n_data_vec_arr(
						   .clk(clk),
						   .rst_n(rst_n),
						   .mem_mngr_data(mem_mngr_data),
						   .mem_mngr_data_vld(mem_mngr_data_vld),
						   .pop_fifo(pop_fifo),
     .svm_ctrl_part_num_dim(svm_ctrl_part_num_dim),
						   .loading_weights(loading_weights),
						   .loading_data(loading_data),
						   .clear_weights(clear_weights),
						   .clear_data_vec(clear_data_vec),
						   .weight_regs_0 (weight_regs_0),
						   .weight_regs_1 (weight_regs_1), 
						   .weight_regs_2 (weight_regs_2),
						   .weight_regs_3 (weight_regs_3),
						   .weight_regs_4 (weight_regs_4),
						   .weight_regs_5 (weight_regs_5), 
						   .weight_regs_6 (weight_regs_6),
						   .weight_regs_7 (weight_regs_7), 
						   .weight_regs_8 (weight_regs_8),
						   .weight_regs_9 (weight_regs_9), 
						   .weight_regs_10(weight_regs_10),
						   .weight_regs_11(weight_regs_11),
						   .weight_regs_12(weight_regs_12),
						   .weight_regs_13(weight_regs_13), 
						   .weight_regs_14(weight_regs_14),
						   .weight_regs_15(weight_regs_15),
						   .weight_regs_16(weight_regs_16),
						   .weight_regs_17(weight_regs_17), 
						   .weight_regs_18(weight_regs_18),
						   .weight_regs_19(weight_regs_19),
						   .weight_regs_20(weight_regs_20),
						   .weight_regs_21(weight_regs_21), 
						   .weight_regs_22(weight_regs_22),
						   .weight_regs_23(weight_regs_23), 
						   .weight_regs_24(weight_regs_24),
						   .weight_regs_25(weight_regs_25), 
						   .weight_regs_26(weight_regs_26),
						   .weight_regs_27(weight_regs_27),
						   .weight_regs_28(weight_regs_28),
						   .weight_regs_29(weight_regs_29), 
						   .weight_regs_30(weight_regs_30),
						   .weight_regs_31(weight_regs_31),
						   .data_vec_regs_0 (data_vec_regs_0),
						   .data_vec_regs_1 (data_vec_regs_1), 
						   .data_vec_regs_2 (data_vec_regs_2),
						   .data_vec_regs_3 (data_vec_regs_3),
						   .data_vec_regs_4 (data_vec_regs_4),
						   .data_vec_regs_5 (data_vec_regs_5), 
						   .data_vec_regs_6 (data_vec_regs_6),
						   .data_vec_regs_7 (data_vec_regs_7), 
						   .data_vec_regs_8 (data_vec_regs_8),
						   .data_vec_regs_9 (data_vec_regs_9), 
						   .data_vec_regs_10(data_vec_regs_10),
						   .data_vec_regs_11(data_vec_regs_11),
						   .data_vec_regs_12(data_vec_regs_12),
						   .data_vec_regs_13(data_vec_regs_13), 
						   .data_vec_regs_14(data_vec_regs_14),
						   .data_vec_regs_15(data_vec_regs_15),
						   .data_vec_regs_16(data_vec_regs_16),
						   .data_vec_regs_17(data_vec_regs_17), 
						   .data_vec_regs_18(data_vec_regs_18),
						   .data_vec_regs_19(data_vec_regs_19),
						   .data_vec_regs_20(data_vec_regs_20),
						   .data_vec_regs_21(data_vec_regs_21), 
						   .data_vec_regs_22(data_vec_regs_22),
						   .data_vec_regs_23(data_vec_regs_23), 
						   .data_vec_regs_24(data_vec_regs_24),
						   .data_vec_regs_25(data_vec_regs_25), 
						   .data_vec_regs_26(data_vec_regs_26),
						   .data_vec_regs_27(data_vec_regs_27),
						   .data_vec_regs_28(data_vec_regs_28),
						   .data_vec_regs_29(data_vec_regs_29), 
						   .data_vec_regs_30(data_vec_regs_30),
						   .data_vec_regs_31(data_vec_regs_31),
						   .weights_progd(weights_progd),
						   .data_vec_progd(data_vec_progd)
						   );
   
   
   
   fp_mult_array i_fp_mult_array(
				 .clk(clk),
				 .rst_n(rst_n),
				 .mult_op_sel(mult_op_sel),
     .mult_en(/*weights_progd & */data_vec_progd & comp_start),
				 .weight_regs_in_0 (weight_regs_0),
				 .weight_regs_in_1 (weight_regs_1), 
				 .weight_regs_in_2 (weight_regs_2),
				 .weight_regs_in_3 (weight_regs_3),
				 .weight_regs_in_4 (weight_regs_4),
				 .weight_regs_in_5 (weight_regs_5), 
				 .weight_regs_in_6 (weight_regs_6),
				 .weight_regs_in_7 (weight_regs_7), 
				 .weight_regs_in_8 (weight_regs_8),
				 .weight_regs_in_9 (weight_regs_9), 
				 .weight_regs_in_10(weight_regs_10),
				 .weight_regs_in_11(weight_regs_11),
				 .weight_regs_in_12(weight_regs_12),
				 .weight_regs_in_13(weight_regs_13), 
				 .weight_regs_in_14(weight_regs_14),
				 .weight_regs_in_15(weight_regs_15),
				 .weight_regs_in_16(weight_regs_16),
				 .weight_regs_in_17(weight_regs_17), 
				 .weight_regs_in_18(weight_regs_18),
				 .weight_regs_in_19(weight_regs_19),
				 .weight_regs_in_20(weight_regs_20),
				 .weight_regs_in_21(weight_regs_21), 
				 .weight_regs_in_22(weight_regs_22),
				 .weight_regs_in_23(weight_regs_23), 
				 .weight_regs_in_24(weight_regs_24),
				 .weight_regs_in_25(weight_regs_25), 
				 .weight_regs_in_26(weight_regs_26),
				 .weight_regs_in_27(weight_regs_27),
				 .weight_regs_in_28(weight_regs_28),
				 .weight_regs_in_29(weight_regs_29), 
				 .weight_regs_in_30(weight_regs_30),
				 .weight_regs_in_31(weight_regs_31),
				 .data_vec_regs_in_0 (data_vec_regs_0),
				 .data_vec_regs_in_1 (data_vec_regs_1), 
				 .data_vec_regs_in_2 (data_vec_regs_2),
				 .data_vec_regs_in_3 (data_vec_regs_3),
				 .data_vec_regs_in_4 (data_vec_regs_4),
				 .data_vec_regs_in_5 (data_vec_regs_5), 
				 .data_vec_regs_in_6 (data_vec_regs_6),
				 .data_vec_regs_in_7 (data_vec_regs_7), 
				 .data_vec_regs_in_8 (data_vec_regs_8),
				 .data_vec_regs_in_9 (data_vec_regs_9), 
				 .data_vec_regs_in_10(data_vec_regs_10),
				 .data_vec_regs_in_11(data_vec_regs_11),
				 .data_vec_regs_in_12(data_vec_regs_12),
				 .data_vec_regs_in_13(data_vec_regs_13), 
				 .data_vec_regs_in_14(data_vec_regs_14),
				 .data_vec_regs_in_15(data_vec_regs_15),
				 .data_vec_regs_in_16(data_vec_regs_16),
				 .data_vec_regs_in_17(data_vec_regs_17), 
				 .data_vec_regs_in_18(data_vec_regs_18),
				 .data_vec_regs_in_19(data_vec_regs_19),
				 .data_vec_regs_in_20(data_vec_regs_20),
				 .data_vec_regs_in_21(data_vec_regs_21), 
				 .data_vec_regs_in_22(data_vec_regs_22),
				 .data_vec_regs_in_23(data_vec_regs_23), 
				 .data_vec_regs_in_24(data_vec_regs_24),
				 .data_vec_regs_in_25(data_vec_regs_25), 
				 .data_vec_regs_in_26(data_vec_regs_26),
				 .data_vec_regs_in_27(data_vec_regs_27),
				 .data_vec_regs_in_28(data_vec_regs_28),
				 .data_vec_regs_in_29(data_vec_regs_29), 
				 .data_vec_regs_in_30(data_vec_regs_30),
				 .data_vec_regs_in_31(data_vec_regs_31),
				 .data_out_0 (data_out_0),
				 .data_out_1 (data_out_1), 
				 .data_out_2 (data_out_2), 
				 .data_out_3 (data_out_3), 
				 .data_out_4 (data_out_4), 
				 .data_out_5 (data_out_5), 
				 .data_out_6 (data_out_6), 
				 .data_out_7 (data_out_7), 
				 .data_out_8 (data_out_8), 
				 .data_out_9 (data_out_9), 
				 .data_out_10(data_out_10), 
				 .data_out_11(data_out_11), 
				 .data_out_12(data_out_12), 
				 .data_out_13(data_out_13), 
				 .data_out_14(data_out_14), 
				 .data_out_15(data_out_15), 
				 .data_out_16(data_out_16), 
				 .data_out_17(data_out_17), 
				 .data_out_18(data_out_18), 
				 .data_out_19(data_out_19), 
				 .data_out_20(data_out_20), 
				 .data_out_21(data_out_21), 
				 .data_out_22(data_out_22), 
				 .data_out_23(data_out_23), 
				 .data_out_24(data_out_24), 
				 .data_out_25(data_out_25), 
				 .data_out_26(data_out_26), 
				 .data_out_27(data_out_27), 
				 .data_out_28(data_out_28), 
				 .data_out_29(data_out_29), 
				 .data_out_30(data_out_30), 
				 .data_out_31(data_out_31),
				 .data_out_vec_vld(data_out_vec_vld)
				 );

   fp_vec_add i_fp_vec_add(
			   .clk(clk),
			   .rst_n(rst_n),
			   .comp_en(data_out_vec_vld),
			   .data_in_op_sel(1'b0),
			   .accum_comp_en (accum_comp_en), 
			   .cur_accum_data(cur_accum_data),
			   .accum_add_data(accum_add_data),
			   .data_0 (data_mux_out_0),
			   .data_1 (data_mux_out_1), 
			   .data_2 (data_mux_out_2),
			   .data_3 (data_mux_out_3),
			   .data_4 (data_mux_out_4),
			   .data_5 (data_mux_out_5), 
			   .data_6 (data_mux_out_6),
			   .data_7 (data_mux_out_7), 
			   .data_8 (data_mux_out_8),
			   .data_9 (data_mux_out_9), 
			   .data_10(data_mux_out_10),
			   .data_11(data_mux_out_11),
			   .data_12(data_mux_out_12),
			   .data_13(data_mux_out_13), 
			   .data_14(data_mux_out_14),
			   .data_15(data_mux_out_15),
			   .data_16(data_mux_out_16),
			   .data_17(data_mux_out_17), 
			   .data_18(data_mux_out_18),
			   .data_19(data_mux_out_19),
			   .data_20(data_mux_out_20),
			   .data_21(data_mux_out_21), 
			   .data_22(data_mux_out_22),
			   .data_23(data_mux_out_23), 
			   .data_24(data_mux_out_24),
			   .data_25(data_mux_out_25), 
			   .data_26(data_mux_out_26),
			   .data_27(data_mux_out_27),
			   .data_28(data_mux_out_28),
			   .data_29(data_mux_out_29), 
			   .data_30(data_mux_out_30),
			   .data_31(data_mux_out_31),
			   .data_out(data_out),
			   .data_out_vld(data_out_vld)
			   ) ;
   
   logic [31:0] 				   data_out_o1;
/*   logic [31:0] 				   data_out_o2;
   logic [31:0] 				   data_out_o3;	
   assign data_out = data_out_o1 & data_out_o2 & data_out_o3;
   
   mm_buf i_mm_dbuf(
		    .clock(clk),
		    .data(data_out_31[7:0]),
		    .rdaddress(mem_mngr_data[7:0]),
		    .rden(data_out_vld),
		    .wraddress(data_out_10[9:0]),
		    .wren(data_out_10[10]),
		    .q(data_out_o2)
		    );	
   
   fifo_trial i_fifo_trial(
			   .clock(clk),
			   .data(data_out_21),
			   .rdreq(data_out_vld),
			   .wrreq(data_out_vec_vld),
			   .q(data_out_o3)
			   );*/
   
endmodule
