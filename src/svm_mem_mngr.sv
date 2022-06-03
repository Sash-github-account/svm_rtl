module svm_mem_mngr(
		    input logic 	clk,
		    input logic 	rst_n,

		    input logic [1:0] 	OP_MODE_REG,
		    input logic [2:0] 	DATA_TYPE,
		    input logic [31:0] 	AUTO_SPLIT,
		    input logic [31:0] 	TRAIN_DATA_BASE,
		    input logic [31:0] 	TEST_DATA_BASE​,
		    input logic [31:0] 	TRAIN_ALGO,
		    input logic [31:0] 	NUM_DIM,
		    input logic [31:0] 	NUM_DATA_POINTS​,
		    input logic [31:0] 	DIM_BASE_PTR,
		    input logic [31:0] 	DIM_BASE_PTR_NUM,
		    input logic [31:0] 	MODE_DATASET_ORG,
		    input logic [31:0] 	INFER_RES_BASE_PTR,
		    input logic [31:0] 	INFER_RES_BLK_SIZE,

		    input logic 	mem_dma_rdy,
		    output logic 	mem_dma_req_vld,
		    output logic 	mem_dma_rdbar_wr,
		    output logic [31:0] mem_dma_req_addr,
		    output logic [31:0] mem_dma_req_data,
		    input logic [31:0] 	mem_dma_rd_data,
		    input logic 	mem_dma_rd_data_vld,
					
		    output logic [31:0] arr_reg_data,
		    output logic 	arr_wghtbar_data,
		    output logic [4:0] 	arr_reg_pos,
		    output logic 	arr_reg_data_vld,
		    
		    input logic 	mem_cmd_vld,
		    input logic [3:0] 	mem_cmd,
		    output logic [2:0] 	mem_resp,
		    output logic 	mem_resp_vld

		    );


   typedef enum logic [3:0]{
			    IDLE,
			    LOAD_WEIGHTS,
			    LOAD_DATA_POINT,
			    WR_WEIGHTS,
			    WR_SCRATCH,
			    RD_SCRATCH
			    }t_mem_mngr_st;
   

   
   
   


endmodule
