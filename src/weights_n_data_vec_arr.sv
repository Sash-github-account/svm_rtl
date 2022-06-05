module weights_n_data_vec_arr(
			      input logic 		    clk,
			      input logic 		    rst_n,
			      input logic [DATA_WIDTH-1:0]  mem_mngr_data,
			      input logic 		    mem_mngr_data_vld,
			      input logic [5:0] 	    svm_ctrl_part_num_dim,
			      input logic 		    loading_weights,
			      input logic 		    loading_data,
			      input logic 		    clear_weights_n_data,
			      output logic [DATA_WIDTH-1:0] weight_regs_0,
			      output logic [DATA_WIDTH-1:0] weight_regs_1, 
			      output logic [DATA_WIDTH-1:0] weight_regs_2,
			      output logic [DATA_WIDTH-1:0] weight_regs_3,
			      output logic [DATA_WIDTH-1:0] weight_regs_4,
			      output logic [DATA_WIDTH-1:0] weight_regs_5, 
			      output logic [DATA_WIDTH-1:0] weight_regs_6,
			      output logic [DATA_WIDTH-1:0] weight_regs_7, 
			      output logic [DATA_WIDTH-1:0] weight_regs_8,
			      output logic [DATA_WIDTH-1:0] weight_regs_9, 
			      output logic [DATA_WIDTH-1:0] weight_regs_10,
			      output logic [DATA_WIDTH-1:0] weight_regs_11,
			      output logic [DATA_WIDTH-1:0] weight_regs_12,
			      output logic [DATA_WIDTH-1:0] weight_regs_13, 
			      output logic [DATA_WIDTH-1:0] weight_regs_14,
			      output logic [DATA_WIDTH-1:0] weight_regs_15,
			      output logic [DATA_WIDTH-1:0] weight_regs_16,
			      output logic [DATA_WIDTH-1:0] weight_regs_17, 
			      output logic [DATA_WIDTH-1:0] weight_regs_18,
			      output logic [DATA_WIDTH-1:0] weight_regs_19,
			      output logic [DATA_WIDTH-1:0] weight_regs_20,
			      output logic [DATA_WIDTH-1:0] weight_regs_21, 
			      output logic [DATA_WIDTH-1:0] weight_regs_22,
			      output logic [DATA_WIDTH-1:0] weight_regs_23, 
			      output logic [DATA_WIDTH-1:0] weight_regs_24,
			      output logic [DATA_WIDTH-1:0] weight_regs_25, 
			      output logic [DATA_WIDTH-1:0] weight_regs_26,
			      output logic [DATA_WIDTH-1:0] weight_regs_27,
			      output logic [DATA_WIDTH-1:0] weight_regs_28,
			      output logic [DATA_WIDTH-1:0] weight_regs_29, 
			      output logic [DATA_WIDTH-1:0] weight_regs_30,
			      output logic [DATA_WIDTH-1:0] weight_regs_31,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_0,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_1, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_2,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_3,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_4,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_5, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_6,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_7, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_8,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_9, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_10,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_11,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_12,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_13, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_14,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_15,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_16,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_17, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_18,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_19,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_20,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_21, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_22,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_23, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_24,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_25, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_26,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_27,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_28,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_29, 
			      output logic [DATA_WIDTH-1:0] data_vec_regs_30,
			      output logic [DATA_WIDTH-1:0] data_vec_regs_31,
			      output logic 		    weights_progd,
			      output logic 		    data_vec_progd
			      );

   logic [DATA_WIDTH-1:0] 				    weight_regs[0:31];
   logic [DATA_WIDTH-1:0] 				    data_vec_regs[0:31];
   logic [5:0] 						    weight_addr_cntr;
   logic [5:0] 						    data_vec_addr_cntr;


   assign   weight_regs_0 =        weight_regs[ 0 ];  
   assign   weight_regs_1 =        weight_regs[ 1 ];  
   assign   weight_regs_2 =        weight_regs[ 2 ];  
   assign   weight_regs_3 =        weight_regs[ 3 ];  
   assign   weight_regs_4 =        weight_regs[ 4 ];  
   assign   weight_regs_5 =        weight_regs[ 5 ];  
   assign   weight_regs_6 =        weight_regs[ 6 ];  
   assign   weight_regs_7 =        weight_regs[ 7 ];  
   assign   weight_regs_8 =        weight_regs[ 8 ];  
   assign   weight_regs_9 =        weight_regs[ 9 ];  
   assign   weight_regs_10 =       weight_regs[10 ];  
   assign   weight_regs_11 =       weight_regs[11 ];  
   assign   weight_regs_12 =       weight_regs[12 ];  
   assign   weight_regs_13 =       weight_regs[13 ];  
   assign   weight_regs_14 =       weight_regs[14 ];  
   assign   weight_regs_15 =       weight_regs[15 ];  
   assign   weight_regs_16 =       weight_regs[16 ];  
   assign   weight_regs_17 =       weight_regs[17 ];  
   assign   weight_regs_18 =       weight_regs[18 ];  
   assign   weight_regs_19 =       weight_regs[19 ];  
   assign   weight_regs_20 =       weight_regs[20 ];  
   assign   weight_regs_21 =       weight_regs[21 ];  
   assign   weight_regs_22 =       weight_regs[22 ];  
   assign   weight_regs_23 =       weight_regs[23 ];  
   assign   weight_regs_24 =       weight_regs[24 ];  
   assign   weight_regs_25 =       weight_regs[25 ];  
   assign   weight_regs_26 =       weight_regs[26 ];  
   assign   weight_regs_27 =       weight_regs[27 ];  
   assign   weight_regs_28 =       weight_regs[28 ];  
   assign   weight_regs_29 =       weight_regs[29 ];  
   assign   weight_regs_30 =       weight_regs[30 ];  
   assign   weight_regs_31 =       weight_regs[31 ];  
   assign   data_vec_regs_0 =      data_vec_regs[ 0 ];
   assign   data_vec_regs_1 =      data_vec_regs[ 1 ];
   assign   data_vec_regs_2 =      data_vec_regs[ 2 ];
   assign   data_vec_regs_3 =      data_vec_regs[ 3 ];
   assign   data_vec_regs_4 =      data_vec_regs[ 4 ];
   assign   data_vec_regs_5 =      data_vec_regs[ 5 ];
   assign   data_vec_regs_6 =      data_vec_regs[ 6 ];
   assign   data_vec_regs_7 =      data_vec_regs[ 7 ];
   assign   data_vec_regs_8 =      data_vec_regs[ 8 ];
   assign   data_vec_regs_9 =      data_vec_regs[ 9 ];
   assign   data_vec_regs_10 =     data_vec_regs[10 ];
   assign   data_vec_regs_11 =     data_vec_regs[11 ];
   assign   data_vec_regs_12 =     data_vec_regs[12 ];
   assign   data_vec_regs_13 =     data_vec_regs[13 ];
   assign   data_vec_regs_14 =     data_vec_regs[14 ];
   assign   data_vec_regs_15 =     data_vec_regs[15 ];
   assign   data_vec_regs_16 =     data_vec_regs[16 ];
   assign   data_vec_regs_17 =     data_vec_regs[17 ];
   assign   data_vec_regs_18 =     data_vec_regs[18 ];
   assign   data_vec_regs_19 =     data_vec_regs[19 ];
   assign   data_vec_regs_20 =     data_vec_regs[20 ];
   assign   data_vec_regs_21 =     data_vec_regs[21 ];
   assign   data_vec_regs_22 =     data_vec_regs[22 ];
   assign   data_vec_regs_23 =     data_vec_regs[23 ];
   assign   data_vec_regs_24 =     data_vec_regs[24 ];
   assign   data_vec_regs_25 =     data_vec_regs[25 ];
   assign   data_vec_regs_26 =     data_vec_regs[26 ];
   assign   data_vec_regs_27 =     data_vec_regs[27 ];
   assign   data_vec_regs_28 =     data_vec_regs[28 ];
   assign   data_vec_regs_29 =     data_vec_regs[29 ];
   assign   data_vec_regs_30 =     data_vec_regs[30 ];
   assign   data_vec_regs_31 =     data_vec_regs[31 ];


   assign weights_progd = weight_addr_cntr == svm_ctrl_part_num_dim;
   assign data_vec_progd = data_vec_addr_cntr == svm_ctrl_part_num_dim;


   always@(posedge clk) begin
      if(!rst_n) begin
	 weight_addr_cntr <= 0;
	 data_vec_addr_cntr <= 0;
	 for (int i = 0; i < 32; i++) begin
	    weight_regs[i] <= 0;
	    data_vec_regs[i] <= 32'h3f800000;
	 end
      end
      else begin
	 if(clear_weights_n_data) begin
	    weight_addr_cntr <= 0;
	    data_vec_addr_cntr <= 0;
	    for (int i = 0; i < 32; i++) begin
	       weight_regs[i] <= 0;
	       data_vec_regs[i] <= 32'h3f800000;
	    end				
	 end
	 
	 if(mem_mngr_data_vld) begin
	    if(loading_weights) begin
	       weight_regs[weight_addr_cntr] <= mem_mngr_data;
	       if(weight_addr_cntr < svm_ctrl_part_num_dim) weight_addr_cntr <= weight_addr_cntr  + 1;
	    end

	    if(loading_data) begin
	       data_vec_regs[data_vec_addr_cntr] <= mem_mngr_data;
	       if(data_vec_addr_cntr < svm_ctrl_part_num_dim) data_vec_addr_cntr <= data_vec_addr_cntr  + 1;
	    end
	 end
      end
   end   

   

endmodule
