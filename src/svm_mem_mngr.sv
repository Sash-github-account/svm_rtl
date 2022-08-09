module svm_mem_mngr(
		    input logic 		      clk,
		    input logic 		      rst_n,

		    input logic [1:0] 		      OP_MODE_REG,
		    input logic [2:0] 		      DATA_TYPE,
		    input logic [31:0] 		      AUTO_SPLIT,
		    input logic [31:0] 		      TRAIN_DATA_BASE,
		    input logic [31:0] 		      TEST_DATA_BASE,
		    input logic [31:0] 		      TRAIN_ALGO,
		    input logic [31:0] 		      NUM_DIM,
		    input logic [31:0] 		      NUM_DATA_POINTS,
		    input logic [31:0] 		      DIM_BASE_PTR,
		    input logic [31:0] 		      DIM_BASE_PTR_NUM,
		    input logic [31:0] 		      MODE_DATASET_ORG,
		    input logic [31:0] 		      INFER_RES_BASE_PTR,
		    input logic [31:0] 		      INFER_RES_BLK_SIZE,
		    input logic [31:0] 		      WEIGTHS_BASE_ADDR,
		    input logic [0:0] 		      cfg_done,

		     input logic 		  weights_progd,
		     input logic 		  data_vec_progd,
		    input logic 		      pop_fifo,
		    output logic 		      arr_reg_data_vld,
		    output logic [DATA_WIDTH-1:0]     mem_mngr_data,
		    output logic [5:0] 		      svm_ctrl_part_num_dim,

		    // dma config intf //
		    output logic 		      start_rd,
		    output logic 		      cfg_ready,
		    output logic [ROM_ADDR_WIDTH-1:0] cfg_dma_base_addr,
		    output logic [ROM_ADDR_WIDTH-1:0] cfg_dma_num_bytes,
		    input logic 		      batch_dma_done,

		    // input fifo interface //
		    input logic [32-1:0] 	      rom_data_fifo_fifo_data_in,
		    input logic 		      rom_data_fifo_fifo_data_push,
		    output logic 		      rom_data_fifo_fifo_full,
		    output logic 		      rom_data_fifo_fifo_empty,

		    input logic 		      mem_cmd_vld,
		    input logic [3:0] 		      mem_cmd,
		    input logic [31:0] 		      mem_cmd_data,
		    output logic [2:0] 		      mem_resp,
		    output logic [31:0] 	      mem_resp_data,
		    output logic 		      mem_resp_vld                            

		    );


   typedef enum 				      logic [3:0]{
								  IDLE,
								  EXEC_MEM_CMD,
     								  SEND_INFR_RESP,
     SEND_INFR_RES_WR_RESP,
								  WAIT_NXT_MEM_CMD,
								  RD_IN_WEIGHTS,
								  LOAD_DATA_POINT,
								  WR_WEIGHTS,
								  WR_SCRATCH,
								  RD_SCRATCH
								  }t_mem_mngr_st;
   typedef enum 				      logic [3:0] {
								   LOAD_WEIGHTS,
								   LOAD_DATA,
								   WR_TO_SCRATCH_STACK,
								   WR_INFER_RES,
								   POP_SCRATCH_STACK
								   }t_mem_cmds;

   typedef enum 				      logic [2:0] {
								   WGHT_LOAD_DONE,
								   DATAVEC_LOAD_DONE,
								   WR_INFER_RES_DONE
								   }t_mem_resp;
   
   t_mem_mngr_st mem_mngr_st_cur;
   t_mem_mngr_st mem_mngr_st_nxt;
   logic [31:0] 				      datavec_cur_rd_addr;
   logic 					      upd_datvec_addr;
   logic 					      clear_datvec_addr;
   logic [31:0] 				      weigths_cur_rd_addr;
   logic 					      upd_wght_addr;
   logic 					      clear_wght_addr;
   logic 					      send_rd_cmd;
   logic 					      clr_rd_cmd;
   logic 					      capture_wghts_base;
   logic 					      capture_datavec_base;
   
   

   assign arr_reg_data_vld = !rom_data_fifo_fifo_empty;
   

   always@(posedge clk) begin
      if(!rst_n) begin
	 cfg_ready <= 0;
	 cfg_dma_base_addr <= 0;
	 cfg_dma_num_bytes <= 0;
         start_rd <= 0;
      end
      else begin
	 if(send_rd_cmd) begin
	    start_rd <= 1;
	    cfg_ready <= 1;
	    cfg_dma_base_addr <= (mem_cmd == LOAD_WEIGHTS)? weigths_cur_rd_addr : datavec_cur_rd_addr;
       cfg_dma_num_bytes <= (mem_cmd == LOAD_WEIGHTS)? (mem_cmd_data+1 << 2):(mem_cmd_data << 2);
	 end
	 else if (clr_rd_cmd) begin
	    start_rd <= 0;
	    cfg_ready <= 0;
	    cfg_dma_base_addr <= 0;
	    cfg_dma_num_bytes <= 0;
	 end
      end
   end
   

   always@(posedge clk) begin
      if(!rst_n) begin
	 weigths_cur_rd_addr <= 0;
      end
      else begin
         if(capture_wghts_base) weigths_cur_rd_addr <= WEIGTHS_BASE_ADDR;
         else if(upd_wght_addr) weigths_cur_rd_addr <= weigths_cur_rd_addr + (mem_cmd_data<<2);
	 else if (clear_wght_addr) weigths_cur_rd_addr <= 0;
	 else weigths_cur_rd_addr <= weigths_cur_rd_addr;
      end
   end


   always@(posedge clk) begin
      if(!rst_n) begin
	 datavec_cur_rd_addr <= 0;
      end
      else begin 
         if(capture_datavec_base) datavec_cur_rd_addr <= TRAIN_DATA_BASE;
         else if(upd_datvec_addr) datavec_cur_rd_addr <= datavec_cur_rd_addr + (mem_cmd_data<<2);
	 else if (clear_datvec_addr) datavec_cur_rd_addr <= 0;
	 else datavec_cur_rd_addr <= datavec_cur_rd_addr;
      end
   end   
   
   always@(posedge clk) begin
      if(!rst_n) begin
	 mem_mngr_st_cur <= IDLE;      
      end
      else begin
	 mem_mngr_st_cur <= mem_mngr_st_nxt;
      end
   end
   

   always@(*) begin
      //defaults//
      mem_mngr_st_nxt = mem_mngr_st_cur;
      mem_resp = 0;
      mem_resp_data = 0;
      mem_resp_vld = 0;
      //start_rd = 0;
      upd_wght_addr = 0;
      upd_datvec_addr = 0;
      clear_wght_addr = 0;
      send_rd_cmd = 0;
      clr_rd_cmd = 0;
      clear_wght_addr = 0;
      clear_datvec_addr = 0;
      svm_ctrl_part_num_dim = 0;
      capture_wghts_base = 0;
      capture_datavec_base = 0;
      //--------//
      
      case(mem_mngr_st_cur)

	IDLE: begin
	   clear_wght_addr = 1;
	   clear_datvec_addr = 1;
	   
	   if(cfg_done) begin
              capture_wghts_base = 1;
  	      capture_datavec_base = 1;
              mem_mngr_st_nxt = EXEC_MEM_CMD;
	   end
	end
	
	EXEC_MEM_CMD: begin
	   if(mem_cmd_vld) begin
	      case(mem_cmd)
		LOAD_WEIGHTS: begin
		   send_rd_cmd = 1;
		   //start_rd = 1;
		   svm_ctrl_part_num_dim = mem_cmd_data + 1;
		   
		   if(batch_dma_done)begin
		      send_rd_cmd = 0;
		      upd_wght_addr = 1;
		      clr_rd_cmd = 1;
		      mem_mngr_st_nxt = SEND_INFR_RESP;
		   end
		end
		
        LOAD_DATA: begin
		   send_rd_cmd = 1;
		   //start_rd = 1;
		   svm_ctrl_part_num_dim = mem_cmd_data;
		   
		   if(batch_dma_done)begin
		      send_rd_cmd = 0;
		      upd_datvec_addr = 1;
		      clr_rd_cmd = 1;
		      mem_mngr_st_nxt = SEND_INFR_RESP;
		   end          
        end
		
		WR_INFER_RES: begin
          mem_mngr_st_nxt = SEND_INFR_RES_WR_RESP;
        end
          
		default: mem_mngr_st_nxt = IDLE;
	      endcase // case (mem_cmd)
	   end // if (mem_cmd_vld)
	end // case: EXEC_MEM_CMD
	
	SEND_INFR_RESP: begin
       mem_resp_vld = 1;
	   mem_resp_data = 0;
	   mem_resp = (mem_cmd == LOAD_WEIGHTS) ? 0: ((mem_cmd == LOAD_DATA)?1:0);
      if((weights_progd & (mem_cmd == LOAD_WEIGHTS)) | ((mem_cmd == LOAD_DATA) & data_vec_progd)) mem_mngr_st_nxt = EXEC_MEM_CMD;
	end
        
    SEND_INFR_RES_WR_RESP: begin
       mem_resp_vld = 1;
	   mem_resp_data = 0;
	   mem_resp = WR_INFER_RES_DONE;
       mem_mngr_st_nxt = EXEC_MEM_CMD;      
    end
	
	default: begin
	   mem_mngr_st_nxt = IDLE;
	end
      endcase
      
   end // always@ (*)


   /*   fifo_32b_ram i_fifo_32b_ram (
    .clock(clk),
    .data(rom_data_fifo_fifo_data_in),
    .rdreq(pop_fifo),
    .wrreq(rom_data_fifo_fifo_data_push),
    .full( rom_data_fifo_fifo_full),
    .empty(rom_data_fifo_fifo_empty),
    .q(mem_mngr_data)
    );
    */
   
   generic_fifo #(.FIFO_DATA_WIDTH(32), .FIFO_DEPTH(16)) i_svm_fifo(
								    .clk (clk),
								    .reset_n (rst_n),
 								    .fifo_data_in (rom_data_fifo_fifo_data_in),
 								    .fifo_data_push (rom_data_fifo_fifo_data_push),
 								    .fifo_data_pop (pop_fifo),
 								    .fifo_data_out (mem_mngr_data),
 								    .fifo_data_out_vld (rom_data_fifo_fifo_data_out_vld),
 								    .fifo_full (rom_data_fifo_fifo_full),
 								    .fifo_empty (rom_data_fifo_fifo_empty)
								    );
   
endmodule
