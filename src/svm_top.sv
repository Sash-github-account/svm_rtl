`include "param.sv"

module svm_top(
	       input logic 			 clk,
	       input logic 			 reset_n,
	       // interface with ROM //
	       output logic [ROM_ADDR_WIDTH-1:0] rom_rd_addr,
	       output logic 			 CE_bar,
	       output logic 			 OE_bar,
	       output logic 			 WE_bar,
	       input logic [ROM_DATA_WIDTH-1:0]  rom_rd_data


	       );


   logic 					 req_vld;
   logic [31:0] 				 req_data;
   logic 					 svm_fifo_full;
   logic 					 start_rd;  
   logic [31:0] 				 cfg_ready;
   logic [31:0] 				 cfg_dma_base_addr;
   logic [31:0] 				 cfg_dma_num_bytes;
   logic [31:0] 				 batch_dma_done;
   
   

   rom_dma_top i_rom_dma_top(
			     .clk(clk),              
			     .reset_n(reset_n),          
      
			     .rom_rd_addr(rom_rd_addr),
			     .CE_bar(     CE_bar),     
			     .OE_bar(     OE_bar),     
			     .WE_bar(     WE_bar),     
			     .rom_rd_data(rom_rd_data),
      
      
			     .req_vld(req_vld),          
			     .req_data(req_data),         
			     .svm_fifo_full(svm_fifo_full),    

			     .start_rd(start_rd),
			     .cfg_ready(cfg_ready),        
			     .cfg_dma_base_addr(cfg_dma_base_addr),
			     .cfg_dma_num_bytes(cfg_dma_num_bytes),
			     .batch_dma_done    (batch_dma_done)

			     );
   

  logic [31:0] req_data;
  
   svm_core_top i_svm_core_top(
			       .clk(clk),                         
			       .rst_n(reset_n),                       

			       .start_rd(start_rd),
			       .cfg_ready(cfg_ready),        
			       .cfg_dma_base_addr(cfg_dma_base_addr),
			       .cfg_dma_num_bytes(cfg_dma_num_bytes),
			       .batch_dma_done    (batch_dma_done),             
      
     .rom_data_fifo_fifo_data_in(req_data),  
     .rom_data_fifo_fifo_data_push(req_vld),			    
			       .rom_data_fifo_fifo_full      (svm_fifo_full)


			       );
   


endmodule
