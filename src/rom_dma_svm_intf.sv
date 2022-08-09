module rom_dma_svm_intf(
			input logic 			      clk,
			input logic 			      reset_n,
			// rom data fifo intf //
			output logic 			      rom_data_fifo_fifo_data_pop,
			input logic [ROM_FIFO_DATA_WIDTH-1:0] rom_data_fifo_fifo_data_out,
			input logic 			      rom_data_fifo_fifo_data_out_vld,
			input 				      rom_data_fifo_fifo_full,
			input 				      rom_data_fifo_fifo_empty,
			// interface with svm_core //
			output logic 			      req_vld,
			output logic [IEEE_32BIT-1:0] 	      req_data,
			input logic 			      intf_ready,
			input logic 			      resp_gen_cmpltd
			);
   
   
   //--------------- Declarations --------------------//
   typedef enum 					      logic[2:0]{
									 IDLE,
									 UPD_CNTR,
									 CHK_INS_SIZE_N_RD_FIFO,
									 SEND_LL_REQ_N_WAIT
									 } t_rom_dma_ll_intf_st;

   t_rom_dma_ll_intf_st 					rom_dma_ll_intf_cur_st;
   t_rom_dma_ll_intf_st 					rom_dma_ll_intf_nxt_st;
   logic [3:0] 						      fifo_pop_cntr_for_inst_constrn;
   logic [3:0] 						      fifo_pop_cntr_for_inst_constrn_plus1;
   logic 						      start_inst_constrn_pop_cntr;
   logic 						      pop_cntr_reachd_max;
   logic [ROM_FIFO_DATA_WIDTH-1:0] 			      fifo_data_word_int[0:NUM_OF_ROM_FIFO_RD_PER_INST-1]; 
   //-------------------------------------------------//






   //---------------------------------------------//
   //------------- Assemble 32b data --------------//
   //---------------------------------------------//
   assign req_data = {fifo_data_word_int[0],fifo_data_word_int[1],fifo_data_word_int[2],fifo_data_word_int[3]};
   //---------------------------------------------//
   //---------------------------------------------//
   //---------------------------------------------//






   //---------------------------------------------//
   //---------------registers --------------------//
   //---------------------------------------------//
   always_ff@(posedge clk) begin
      if(!reset_n) begin
	 for(int i=0; i<NUM_OF_ROM_FIFO_RD_PER_INST; i++) begin
	    fifo_data_word_int[i] <= 0;
	 end
      end
      else begin 
	 if(rom_data_fifo_fifo_data_out_vld & !pop_cntr_reachd_max) fifo_data_word_int[fifo_pop_cntr_for_inst_constrn] <= rom_data_fifo_fifo_data_out;
      end
   end


   assign fifo_pop_cntr_for_inst_constrn_plus1 = fifo_pop_cntr_for_inst_constrn + 1;
   assign pop_cntr_reachd_max = (fifo_pop_cntr_for_inst_constrn == NUM_OF_ROM_FIFO_RD_PER_INST);
   assign rom_data_fifo_fifo_data_pop = start_inst_constrn_pop_cntr & rom_data_fifo_fifo_data_out_vld;


   always_ff@(posedge clk) begin
      if(!reset_n) begin
	 fifo_pop_cntr_for_inst_constrn <= 0;
      end
      else begin
        if(start_inst_constrn_pop_cntr & rom_data_fifo_fifo_data_out_vld & !pop_cntr_reachd_max) 	begin
          fifo_pop_cntr_for_inst_constrn <= fifo_pop_cntr_for_inst_constrn_plus1;
        end
        else if(rom_dma_ll_intf_cur_st == SEND_LL_REQ_N_WAIT) begin
          fifo_pop_cntr_for_inst_constrn <= 0;
        end
        else	begin
          fifo_pop_cntr_for_inst_constrn <= fifo_pop_cntr_for_inst_constrn;
        end
      end
   end
   //---------------------------------------------//
   //---------------------------------------------//
   //---------------------------------------------//






   //---------------------------------------------//
   //------------ Interface FSM ------------------//
   //---------------------------------------------//
   always_ff@(posedge clk) begin
      if(!reset_n) begin
	 rom_dma_ll_intf_cur_st <= IDLE;
      end
      else begin
	 rom_dma_ll_intf_cur_st <= rom_dma_ll_intf_nxt_st;
      end
   end

   always@(*) begin
      // Defaults //
      rom_dma_ll_intf_nxt_st = rom_dma_ll_intf_cur_st;
      req_vld = 0;
      start_inst_constrn_pop_cntr = 0;
      //----------//
      
      // FSM transitions //
      case(rom_dma_ll_intf_cur_st)
	
	
	
	//------- IDLE ---------//
	IDLE: begin
	   if(rom_data_fifo_fifo_data_out_vld) rom_dma_ll_intf_nxt_st = UPD_CNTR;
	end//------- IDLE ---------//
	
	
	
	//------- UPD_CNTR ---------//
	UPD_CNTR: begin
	   start_inst_constrn_pop_cntr = 1;
	   rom_dma_ll_intf_nxt_st = CHK_INS_SIZE_N_RD_FIFO;
	end//------- UPD_CNTR ---------//
	
	
	
	//------- CHK_INS_SIZE_N_RD_FIFO ---------//
	CHK_INS_SIZE_N_RD_FIFO: begin
	   if(pop_cntr_reachd_max)  rom_dma_ll_intf_nxt_st = SEND_LL_REQ_N_WAIT;
           else 					 rom_dma_ll_intf_nxt_st = UPD_CNTR;
	end//------- CHK_INS_SIZE_N_RD_FIFO ---------//
	
	
	
	
	//------- SEND_LL_REQ_N_WAIT ---------//
	SEND_LL_REQ_N_WAIT: begin
	   if( intf_ready)begin
	      req_vld = 1;
	      //if(resp_gen_cmpltd)  rom_dma_ll_intf_nxt_st = IDLE;
	      rom_dma_ll_intf_nxt_st = IDLE;
	   end
	end//------- SEND_LL_REQ_N_WAIT ---------//
	
	
	
	//------- default ---------//
	default: begin
	   rom_dma_ll_intf_nxt_st = IDLE;
	end//------- default ---------//
	
	
      endcase
      //-----------------//

   end
   //---------------------------------------------//
   //---------------------------------------------//
   //---------------------------------------------//
endmodule // rom_dma_ll_intf.sv //
