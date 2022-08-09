module rom_dma_top(
		   input logic 			     clk,
		   input logic 			     reset_n,
		   // interface with ROM //
		   output logic [ROM_ADDR_WIDTH-1:0] rom_rd_addr,
		   output logic 		     CE_bar,
		   output logic 		     OE_bar,
		   output logic 		     WE_bar,
		   input logic [ROM_DATA_WIDTH-1:0]  rom_rd_data,
		   // interface with svm_core //
		   output logic 		     req_vld,
		   output logic [IEEE_32BIT-1:0]     req_data,
		   input logic 			     svm_fifo_full,
		   
		   input logic 			     start_rd,
		   input logic 			     cfg_ready,
		   input logic [ROM_ADDR_WIDTH-1:0]  cfg_dma_base_addr,
		   input logic [ROM_ADDR_WIDTH-1:0]  cfg_dma_num_bytes, 
		   output logic 		     batch_dma_done    
		   );
   
   
   //------------- Declarations -----------------//
   logic [7:0] 					     rom_data_fifo_fifo_data_in;
   logic [7:0] 					     rom_data_fifo_fifo_data_out;
   logic 					     resp_gen_cmpltd;
   //--------------------------------------------//

   assign intf_ready = !svm_fifo_full;
   assign resp_gen_cmpltd = 0;
   

   //---------Gen by Python Script: integration_script.py ---------------//


   rom_dma_svm_intf i_rom_dma_svm_intf(
					       .clk (clk),
 					       .reset_n (reset_n),
 					       .rom_data_fifo_fifo_data_pop (rom_data_fifo_fifo_data_pop),
 					       .rom_data_fifo_fifo_data_out (rom_data_fifo_fifo_data_out),
 					       .rom_data_fifo_fifo_data_out_vld (rom_data_fifo_fifo_data_out_vld),
 					       .rom_data_fifo_fifo_full (rom_data_fifo_fifo_full),
 					       .rom_data_fifo_fifo_empty (rom_data_fifo_fifo_empty),
 					       .req_vld (req_vld),
 					       .req_data (req_data),
 					       .intf_ready (intf_ready),
 					       .resp_gen_cmpltd (resp_gen_cmpltd)
					       );



   rom_dma_ctrl i_rom_dma_ctrl(
			       .clk (clk),
 			       .reset_n (reset_n),
 			       .rom_data_fifo_fifo_data_in (rom_data_fifo_fifo_data_in),
 			       .rom_data_fifo_fifo_data_push (rom_data_fifo_fifo_data_push),
 			       .rom_data_fifo_fifo_full (rom_data_fifo_fifo_full),
 			       .rom_data_fifo_fifo_empty (rom_data_fifo_fifo_empty),
			       .rom_data_fifo_fifo_data_pop(rom_data_fifo_fifo_data_pop),
 			       .rom_rd_addr (rom_rd_addr),
 			       .CE_bar (CE_bar),
 			       .OE_bar (OE_bar),
 			       .WE_bar (WE_bar),
 			       .rom_rd_data (rom_rd_data),
 			       .start_rd (start_rd),
 			       .cfg_ready (cfg_ready),
 			       .cfg_dma_base_addr (cfg_dma_base_addr),
 			       .cfg_dma_num_bytes (cfg_dma_num_bytes),
			       .batch_dma_done(batch_dma_done)
			       );



   generic_fifo #(.FIFO_DATA_WIDTH(8), .FIFO_DEPTH(16)) i_rom_data_fifo(
									.clk (clk),
 									.reset_n (reset_n),
 									.fifo_data_in (rom_data_fifo_fifo_data_in),
 									.fifo_data_push (rom_data_fifo_fifo_data_push),
 									.fifo_data_pop (rom_data_fifo_fifo_data_pop),
 									.fifo_data_out (rom_data_fifo_fifo_data_out),
 									.fifo_data_out_vld (rom_data_fifo_fifo_data_out_vld),
 									.fifo_full (rom_data_fifo_fifo_full),
 									.fifo_empty (rom_data_fifo_fifo_empty)
									);


endmodule //rom_dma_top.sv

//---------Gen by Python Script: integration_script.py ---------------//
