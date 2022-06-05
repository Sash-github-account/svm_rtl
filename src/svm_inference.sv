module svm_inference(
		     input logic 		  clk,
		     input logic 		  rst_n,

		     input logic [1:0] 		  OP_MODE_REG,
		     input logic [2:0] 		  DATA_TYPE,
		     input logic [31:0] 	  AUTO_SPLIT, 
		     input logic [31:0] 	  NUM_DIM,
		     input logic [31:0] 	  NUM_DATA_POINTS,
		     input logic [31:0] 	  MODE_DATASET_ORG,
		     input logic 		  cfg_done,
		     output logic 		  batch_comp_done,

		     output logic 		  mem_cmd_vld,
		     output logic [3:0] 	  mem_cmd,
		     output logic [31:0] 	  mem_cmd_data,
		     input logic [2:0] 		  mem_resp,
		     input logic [31:0] 	  mem_resp_data,
		     input logic 		  mem_resp_vld,
		     
		     output logic 		  accum_comp_en,
		     output logic [31:0] 	  cur_accum_data,
		     output logic [31:0] 	  accum_add_data,
		     input logic [DATA_WIDTH-1:0] data_out_frm_comp,
		     input logic 		  data_out_frm_comp_vld,
		     input logic 		  weights_progd,
		     input logic 		  data_vec_progd,
		     output logic 		  comp_en_for_accum, 
		     output logic 		  prog_accum_inputs,
		     output logic 		  comp_start,
		     output logic 		  clear_weights_n_data,
		     output logic 		  arr_wghtbar_data

		     );


   //----Declaration------//
   logic [31:0] 			 num_dim_min_32;
   logic 				 data_pnt_not_done_flg;
   //logic 				 res_in_scratch_stack;
   //logic [31:0]				 dp_done_cntr;
   //logic 				 dp_done_flg;
   //logic [31:0] 			 stack_cntr;
   //logic 				 upd_stack_cntr;
   //logic 				 dec_stack_cntr;
   //logic [31:0] 			 dec_stack_cntr_by;
   logic [31:0] 			 num_dp_remaining;
   logic 				 dec_num_dp_remaining;
   logic [31:0] 			 cur_accum_val;
   logic 				 capture_nxt_data_for_accum;
   logic [31:0] 			 nxt_data_for_accum;
   logic 				 accum_res_capture_en;
   logic 				 is_last_dim_set;
   
   
   typedef enum  logic [2:0]{
	       		     IDLE,
	       		     MEM_REQ_LOAD_WEIGHTS,
	       		     MEM_REQ_LOAD_WEIGHTS_NUM,
	       		     MEM_REQ_LOAD_DATA,
	       		     MEM_REQ_LOAD_DATA_NUM,
	       		     START_COMP,
			     COMP_FINAL_FOR_DP,
			     ACCUM_COMP,
			     MEM_REQ_WR_SCRATCH,
			     POP_STACK_TO_DATAVEC,
			     STACK_RES_ACCUM,
	       		     MEM_REQ_WR_DP_RES
			     }t_svm_infer_st;
   
   t_svm_infer_st svm_infer_cur_st;
   t_svm_infer_st svm_infer_nxt_st;

   typedef enum logic [3:0] {
			     LOAD_WEIGHTS_NUM,
			     LOAD_WEIGTHS_FULL,
			     LOAD_DATA_NUM,
			     LOAD_DATA_FULL,
			     WR_TO_SCRATCH_STACK,
			     WR_INFER_RES,
			     POP_SCRATCH_STACK
			     }t_mem_cmds;

   typedef enum logic [2:0] {
			    WGHT_LOAD_DONE,
			    DATAVEC_LOAD_DONE,
			    WR_INFER_RES_DONE,
			    SCRATCH_1_PUSH_DONE,
			    SCRATCH_1_POP_DONE,
			    SCRATCH_2_PUSH_DONE,
			    SCRATCH_2_POP_DONE
			    }t_mem_resp;

    enum logic [31:0] {
		       CLASS_0,
		       CLASS_1
		       }t_class_inferd;
   //------------------------//
 
  
   assign is_last_dim_set = (num_dim_min_32 < 32 && num_dim_min_32 > 0);
   

   
   always@(posedge clk) begin
      if(!rst_n) begin
	 nxt_data_for_accum <= 0;
      end
      else begin
	 if(dec_num_dp_remaining) nxt_data_for_accum <= 0;
	 else if(data_out_frm_comp_vld & capture_nxt_data_for_accum) nxt_data_for_accum <= data_out_frm_comp;
	 else nxt_data_for_accum <= nxt_data_for_accum;
      end
   end

   
   always@(posedge clk) begin
      if(!rst_n) begin
	 cur_accum_val <= 0;
      end
      else begin
	 if(dec_num_dp_remaining) cur_accum_val <= 0;
	 else if(data_out_frm_comp_vld & accum_res_capture_en) cur_accum_val <= data_out_frm_comp;
	 else cur_accum_val <= cur_accum_val;
      end
   end


  // assign res_in_scratch_stack = (stack_cntr > 0);

   always@(posedge clk) begin
      if(!rst_n) begin
	 num_dp_remaining <= 0;
      end
      else begin
	 if(cfg_done & svm_infer_cur_st==IDLE) num_dp_remaining <= NUM_DATA_POINTS;
	 else if (dec_num_dp_remaining)  num_dp_remaining <= num_dp_remaining - 1;
	 else num_dp_remaining <= num_dp_remaining;
      end
   end
 
/*
   always@(posedge clk) begin
      if(!rst_n) begin
	 stack_cntr <= 0;
      end
      else begin
	 if(upd_stack_cntr)stack_cntr <= stack_cntr + 1;
	 else if (dec_stack_cntr) stack_cntr <= stack_cntr - dec_stack_cntr_by;
	 else if(svm_infer_cur_st == MEM_REQ_WR_DP_RES) stack_cntr <= 0;
	 else stack_cntr <= stack_cntr;
      end
   end 
   
   always@(posedge clk) begin
      if(!rst_n) begin
	 dp_done_cntr <= 0;
      end
      else begin
	 if(dp_done_flg) dp_done_cntr <= dp_done_cntr + 1;
	 else if()
	 
      end
   end*/
   


   always@(posedge clk) begin
      if(!rst_n) begin
	 num_dim_min_32 <= 0;	 
      end
      else begin
	 if(cfg_done & svm_infer_cur_st==IDLE) num_dim_min_32 <= NUM_DIM;
	 else if(data_pnt_not_done_flg)        num_dim_min_32 <= num_dim_min_32 - 32;
	 else num_dim_min_32 <= num_dim_min_32;	 
      end
   end




   
   
   always@(posedge clk) begin
      if(!rst_n) begin
	 svm_infer_cur_st <= IDLE;
      end
      else begin
	 svm_infer_cur_st <= svm_infer_nxt_st;
      end
   end
   
   always@(*) begin
      //----Defaults----//
      svm_infer_nxt_st = svm_infer_cur_st;
      mem_cmd_vld = 0;
      mem_cmd = 0;
      mem_cmd_data = 0;
      arr_wghtbar_data = 0;
      comp_start = 0;
      data_pnt_not_done_flg = 0;
      //dp_done_flg = 0;
      batch_comp_done = 0;
      //upd_stack_cntr =0;
      clear_weights_n_data = 0;
      prog_accum_inputs = 0;
      comp_en_for_accum = 0;
      //dec_stack_cntr_by = 0;
      //dec_stack_cntr = 0;
      dec_num_dp_remaining = 0;
      capture_nxt_data_for_accum = 0;
      cur_accum_data = 0;
      accum_add_data = 0;
      accum_comp_en = 0;
      accum_res_capture_en = 0;
      
      //----------------//
      
      case(svm_infer_cur_st)
	IDLE: begin
	   if(cfg_done) begin
	      if(OP_MODE_REG == 2) begin
		 if(num_dim_min_32 <= 32) svm_infer_nxt_st = MEM_REQ_LOAD_WEIGHTS_NUM;
		 else                    svm_infer_nxt_st = MEM_REQ_LOAD_WEIGHTS;
	      end
	      else svm_infer_nxt_st = IDLE;
	   end
	   else begin
	      svm_infer_nxt_st = IDLE;
	   end
	end // case: IDLE
	
	MEM_REQ_LOAD_WEIGHTS: begin
	   mem_cmd_vld = 1;	   
	   mem_cmd = (is_last_dim_set)? LOAD_WEIGHTS_NUM : LOAD_WEIGTHS_FULL;
	   mem_cmd_data = num_dim_min_32;	   
	   arr_wghtbar_data = 0;
	   
	   if(mem_resp_vld & (mem_resp==WGHT_LOAD_DONE) & weights_progd) svm_infer_nxt_st = MEM_REQ_LOAD_DATA;	   
	end

	/*
	MEM_REQ_LOAD_WEIGHTS_NUM: begin
	   mem_cmd_vld = 1;	   
	   mem_cmd = LOAD_WEIGHTS_NUM;
	   mem_cmd_data = num_dim_min_32;
	   arr_wghtbar_data = 0;
	   
	   if(mem_resp_vld & (mem_resp==WGHT_LOAD_DONE) & weights_progd) svm_infer_nxt_st = MEM_REQ_LOAD_DATA_NUM;
	end*/
	
	MEM_REQ_LOAD_DATA: begin
	   mem_cmd_vld = 1;	   
	   mem_cmd = (is_last_dim_set)? LOAD_DATA_NUM : LOAD_DATA_FULL;
	   mem_cmd_data = num_dim_min_32;
	   arr_wghtbar_data = 1;
	   
	   if(mem_resp_vld & (mem_resp==DATAVEC_LOAD_DONE) & data_vec_progd & weights_progd) begin
	      svm_infer_nxt_st = START_COMP;	      
	      data_pnt_not_done_flg = (is_last_dim_set)? 0:1;
	   end
	   else begin
	      svm_infer_nxt_st = MEM_REQ_LOAD_DATA;
	   end
	end // case: MEM_REQ_LOAD_DATA
	
	/*
	MEM_REQ_LOAD_DATA_NUM: begin
	   mem_cmd_vld = 1;	   
	   mem_cmd = LOAD_DATA_NUM;
	   mem_cmd_data = num_dim_min_32;
	   arr_wghtbar_data = 1;
	   
	   if(mem_resp_vld & (mem_resp==WGHT_LOAD_DONE) & data_vec_progd & weights_progd) begin
	      svm_infer_nxt_st = COMP_FINAL_FOR_DP;
	   end
	   else begin
	      svm_infer_nxt_st = MEM_REQ_LOAD_DATA_NUM;
	   end
	end // case: MEM_REQ_LOAD_DATA_NUM
	*/
	
	START_COMP: begin
	   comp_start = 1;

	   if(data_out_frm_comp_vld) begin
	      clear_weights_n_data = 1;
	      capture_nxt_data_for_accum = 1;
	      svm_infer_nxt_st = ACCUM_COMP;
	   end
	end

	/*
	COMP_FINAL_FOR_DP: begin
	   comp_start = 1;

	   if(data_out_frm_comp_vld) begin
	      clear_weights_n_data = 1;
	      
	      if(res_in_scratch_stack) begin
		 svm_infer_nxt_st = POP_STACK_TO_DATAVEC;
		 dec_num_dp_remaining = 1;
	      end
	      else svm_infer_nxt_st = MEM_REQ_WR_DP_RES;
	   end
	end // case: COMP_FINAL_FOR_DP
	*/
	ACCUM_COMP: begin
	   cur_accum_data = cur_accum_val;
	   accum_add_data = nxt_data_for_accum;
	   accum_comp_en = 1;

	   if(data_out_frm_comp_vld) begin
	      accum_res_capture_en = 1;
	      
	      if(is_last_dim_set) begin
		 svm_infer_nxt_st = MEM_REQ_WR_DP_RES;
	      end
	      else svm_infer_nxt_st = MEM_REQ_LOAD_WEIGHTS;
	   end
	   else svm_infer_nxt_st = ACCUM_COMP;
	end // case: ACCUM_COMP
	
	/*
	MEM_REQ_WR_SCRATCH: begin
	   mem_cmd_vld = 1;
	   mem_cmd = WR_TO_SCRATCH_STACK;
	   mem_cmd_data = data_out_frm_comp;
	   
	   if(mem_resp_vld && (mem_resp == SCRATCH_1_PUSH_DONE)) begin
	      upd_stack_cntr =1;
	      
	      if(num_dim_min_32 < 32 && num_dim_min_32 > 0)  begin
		 svm_infer_nxt_st = MEM_REQ_LOAD_WEIGHTS_NUM;
	      end
	      else if(num_dim_min_32 >= 32) svm_infer_nxt_st = MEM_REQ_LOAD_WEIGHTS;
	      else svm_infer_nxt_st = MEM_REQ_WR_SCRATCH;
	   end
	end

	POP_STACK_TO_DATAVEC: begin
	   mem_cmd_vld = 1;
	   mem_cmd = POP_SCRATCH_STACK;	 
	   mem_cmd_data = (stack_cntr > 32) 32 : stack_cntr;
	   prog_accum_inputs = 1;
	   
	   if((mem_resp==SCRATCH_1_POP_DONE) && mem_resp_vld) begin
	      dec_stack_cntr = 1;
	      dec_stack_cntr_by = (stack_cntr > 32) 32 : stack_cntr;
	      svm_infer_nxt_st = STACK_RES_ACCUM;
	   end
	   else begin
	      svm_infer_nxt_st = POP_STACK_TO_DATAVEC;	      
	   end
	end

	STACK_RES_ACCUM: begin
	   comp_en_for_accum = 1;
	   
	   if(data_out_frm_comp_vld) begin
	      if(stack_cntr == 0) svm_infer_nxt_st = MEM_REQ_WR_DP_RES;
	      else if(stack_cntr > 0) svm_infer_nxt_st = POP_STACK_TO_DATAVEC;
	      else svm_infer_nxt_st = POP_STACK_TO_DATAVEC;
	   end
	end
	*/
	
	MEM_REQ_WR_DP_RES: begin
	   mem_cmd_vld = 1;
	   mem_cmd = WR_INFER_RES;
	   mem_cmd_data = (cur_accum_val[31] == 1'b1)? CLASS_1 : CLASS_0; // Inference based on sign bit

	   if(mem_resp_vld & (mem_resp==WR_INFER_RES_DONE)) begin
	      if(num_dp_remaining > 0) begin 
		 svm_infer_nxt_st = MEM_REQ_LOAD_WEIGHTS;
		 dec_num_dp_remaining = 1;
	      end
	      else begin
		 svm_infer_nxt_st = IDLE;
		 batch_comp_done = 1;
	      end
	   end
	   else svm_infer_nxt_st = MEM_REQ_WR_DP_RES;
	end
	
	default: begin
	   svm_infer_nxt_st = IDLE;
	end
      endcase
   end

endmodule
