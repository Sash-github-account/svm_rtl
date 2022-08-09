// Code your design here
module svm_core_top(
		    input logic 		      clk,
		    input logic 		      rst_n,

		    /*
		     input logic 		      cfg_data_rb_w,
		     input logic 		      cfg_req_vld,
		     output logic 		      cfg_data_rd_vld,
		     output logic [31:0] 	      cfg_rd_data, 
		     input logic [31:0] 		      cfg_data,
		     input logic [15:0] 		      cfg_addr,*/

		    // dma config intf //
		    output logic 		      start_rd,
		    output logic 		      cfg_ready,
		    output logic [ROM_ADDR_WIDTH-1:0] cfg_dma_base_addr,
		    output logic [ROM_ADDR_WIDTH-1:0] cfg_dma_num_bytes,
		    input logic 		      batch_dma_done,

		    input logic [32-1:0] 	      rom_data_fifo_fifo_data_in,
		    input logic 		      rom_data_fifo_fifo_data_push,
		    output logic 		      rom_data_fifo_fifo_full      

		    );


   logic [31:0] 				      mem_mngr_data;
   logic [31:0] 				      pop_fifo;
   logic [31:0] 				      mem_mngr_data_vld;
   logic [31:0] 				      svm_ctrl_part_num_dim;
   logic [31:0] 				      comp_start;
   logic [31:0] 				      accum_comp_en;
   logic [31:0] 				      arr_wghtbar_data;
   logic [31:0] 				      prog_accum_inputs;
   logic  				      clear_weights;
   logic  				      clear_data_vec;
   logic [31:0] 				      comp_en_for_accum;
   logic [31:0] 				      cur_accum_data;
   logic [31:0] 				      accum_add_data;
   logic [31:0] 				      data_out;
   logic [31:0] 				      data_out_vld;
   logic [31:0] 				      weights_progd;
   logic [31:0] 				      data_vec_progd;
   logic [31:0] 				      mem_cmd_vld;
   logic [31:0] 				      mem_cmd;
   logic [31:0] 				      mem_cmd_data;
   logic [31:0] 				      mem_resp;
   logic [31:0] 				      mem_resp_data;
   logic [31:0] 				      mem_resp_vld;
   logic [31:0] 				      OP_MODE_REG;         
   logic [31:0] 				      DATA_TYPE;           
   logic [31:0] 				      AUTO_SPLIT;          
   logic [31:0] 				      TRAIN_DATA_BASE;     
   logic [31:0] 				      TEST_DATA_BASE;      
   logic [31:0] 				      TRAIN_ALGO;          
   logic [31:0] 				      NUM_DIM;             
   logic [31:0] 				      NUM_DATA_POINTS;     
   logic [31:0] 				      DIM_BASE_PTR;        
   logic [31:0] 				      DIM_BASE_PTR_NUM;    
   logic [31:0] 				      INFER_RES_BASE_PTR;  
   logic [31:0] 				      INFER_RES_BLK_SIZE;  
   logic [31:0] 				      WEIGTHS_BASE_ADDR;   
   logic [31:0] 				      MODE_DATASET_ORG;    
   logic [31:0] 				      batch_comp_done;
   logic [31:0] 				      cfg_done;

   
   svm_comp_core i_svm_comp_core(
				 .clk(clk),                       
				 .rst_n(rst_n),                     
				 .mem_mngr_data(mem_mngr_data),             
				 .mem_mngr_data_vld(mem_mngr_data_vld),
				 .pop_fifo(pop_fifo),                     
				 .svm_ctrl_part_num_dim(svm_ctrl_part_num_dim),     
				 .comp_start(comp_start),                
				 .comp_en_for_accum(comp_en_for_accum),         
				 .arr_wghtbar_data(arr_wghtbar_data),          
				 .prog_accum_inputs(prog_accum_inputs),         
				 .clear_data_vec(clear_data_vec),  
     .clear_weights(clear_weights),     
				 .accum_comp_en(accum_comp_en),             
				 .cur_accum_data(cur_accum_data),            
				 .accum_add_data(accum_add_data),            
				 .data_out(data_out),                  
				 .data_out_vld(data_out_vld),              
				 .weights_progd(weights_progd),             
				 .data_vec_progd(data_vec_progd)
				 );


   svm_inference i_svm_inference(
				 .clk(clk),                         				 
				 .rst_n(rst_n),                       

				 .OP_MODE_REG(       OP_MODE_REG),     
				 .DATA_TYPE(         DATA_TYPE),       
				 .AUTO_SPLIT(        AUTO_SPLIT),      
				 .NUM_DIM(           NUM_DIM),         
				 .NUM_DATA_POINTS(   NUM_DATA_POINTS), 
				 .MODE_DATASET_ORG(  MODE_DATASET_ORG),            
				 .cfg_done(cfg_done),                    
				 .batch_comp_done(batch_comp_done),             
      
				 .mem_cmd_vld(mem_cmd_vld),                 
				 .mem_cmd(mem_cmd),                     
				 .mem_cmd_data(mem_cmd_data),                
				 .mem_resp(mem_resp),                    
				 .mem_resp_data(mem_resp_data),               
				 .mem_resp_vld(mem_resp_vld),                
      
				 .accum_comp_en(accum_comp_en),               
				 .cur_accum_data(cur_accum_data),              
				 .accum_add_data(accum_add_data),              
				 .data_out_frm_comp(data_out),           
				 .data_out_frm_comp_vld(data_out_vld),       
				 .weights_progd(weights_progd),               
				 .data_vec_progd(data_vec_progd),              
				 .comp_en_for_accum(comp_en_for_accum),           
				 .prog_accum_inputs(prog_accum_inputs),           
				 .comp_start(comp_start),                  
				 .clear_data_vec(clear_data_vec),  
     .clear_weights(clear_weights),
				 .arr_wghtbar_data(arr_wghtbar_data)
				 );
   

   logic 					      cfg_data_rb_w;
   logic 					      cfg_req_vld;

   logic [31:0] 				      cfg_data;
   logic [15:0] 				      cfg_addr;
   assign  cfg_data_rb_w = 0;
   
   assign  cfg_req_vld = 0;   
   assign  cfg_data = 0;      
   assign	   cfg_addr = 0;    

   svm_core_cfg i_svm_core_cfg (
				.clk(clk),               				
				.rst_n(rst_n),             
				.cfg_data_rb_w(    cfg_data_rb_w),  
				.cfg_req_vld(      cfg_req_vld),    
				.cfg_data_rd_vld(  cfg_data_rd_vld),
				.cfg_rd_data(      cfg_rd_data),    
				.cfg_data(         cfg_data),       
				.cfg_addr(         cfg_addr),       				

				.OP_MODE_REG(        OP_MODE_REG),       
				.DATA_TYPE(          DATA_TYPE),         
				.AUTO_SPLIT(         AUTO_SPLIT),        
				.TRAIN_DATA_BASE(    TRAIN_DATA_BASE),   
				.TEST_DATA_BASE(     TEST_DATA_BASE),    
				.TRAIN_ALGO(         TRAIN_ALGO),        
				.NUM_DIM(            NUM_DIM),           
				.NUM_DATA_POINTS(    NUM_DATA_POINTS),   
				.DIM_BASE_PTR(       DIM_BASE_PTR),      
				.DIM_BASE_PTR_NUM(   DIM_BASE_PTR_NUM),  
				.INFER_RES_BASE_PTR( INFER_RES_BASE_PTR),
				.INFER_RES_BLK_SIZE( INFER_RES_BLK_SIZE),
				.WEIGTHS_BASE_ADDR(  WEIGTHS_BASE_ADDR), 
				.MODE_DATASET_ORG(   MODE_DATASET_ORG),    
				.batch_comp_done(batch_comp_done),   
				.cfg_done(cfg_done)
				);


   svm_mem_mngr i_svm_mem_mngr(
			       .clk(clk),                                    		
			       .rst_n(rst_n),                                  
      
			       .OP_MODE_REG(           OP_MODE_REG),      
			       .DATA_TYPE(        	   DATA_TYPE),        
			       .AUTO_SPLIT(       	   AUTO_SPLIT),       
			       .TRAIN_DATA_BASE(  	   TRAIN_DATA_BASE),
			       .TEST_DATA_BASE(TEST_DATA_BASE),
			       .TRAIN_ALGO(       	   TRAIN_ALGO),
			       .NUM_DIM(          	   NUM_DIM),
			       .NUM_DATA_POINTS(  	   NUM_DATA_POINTS),
			       .DIM_BASE_PTR(     	   DIM_BASE_PTR),
			       .DIM_BASE_PTR_NUM( 	   DIM_BASE_PTR_NUM), 
			       .MODE_DATASET_ORG( 	   MODE_DATASET_ORG), 
			       .INFER_RES_BASE_PTR(	   INFER_RES_BASE_PTR),
			       .INFER_RES_BLK_SIZE(	   INFER_RES_BLK_SIZE),
			       .WEIGTHS_BASE_ADDR(	   WEIGTHS_BASE_ADDR),
      
			       .cfg_done(cfg_done),                   
				 .weights_progd(weights_progd),               
				 .data_vec_progd(data_vec_progd),      
			       .pop_fifo(pop_fifo),                               
			       .arr_reg_data_vld(mem_mngr_data_vld),                       
			       .mem_mngr_data(mem_mngr_data),                          
			       .svm_ctrl_part_num_dim(svm_ctrl_part_num_dim),
			       .start_rd(start_rd),                               
			       .cfg_ready(cfg_ready),                              
			       .cfg_dma_base_addr(cfg_dma_base_addr),                      
			       .cfg_dma_num_bytes(cfg_dma_num_bytes),                      
			       .batch_dma_done(batch_dma_done),                         
      
      
			       .rom_data_fifo_fifo_data_in(rom_data_fifo_fifo_data_in),
			       .rom_data_fifo_fifo_data_push(rom_data_fifo_fifo_data_push),
			       .rom_data_fifo_fifo_full(rom_data_fifo_fifo_full),                
			       .rom_data_fifo_fifo_empty(),               
      
			       .mem_cmd_vld(mem_cmd_vld),                 
			       .mem_cmd(mem_cmd),                     
			       .mem_cmd_data(mem_cmd_data),                
			       .mem_resp(mem_resp),                    
			       .mem_resp_data(mem_resp_data),               
			       .mem_resp_vld(mem_resp_vld)
			       );


endmodule
