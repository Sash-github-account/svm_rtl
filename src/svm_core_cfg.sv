module svm_core_cfg(
		    input logic 	clk,
		    input logic 	rst_n,
		    input logic 	cfg_data_rb_w,
		    input logic 	cfg_req_vld,
		    output logic 	cfg_data_rd_vld,
		    output logic [31:0] cfg_rd_data, 
		    input logic [31:0] 	cfg_data,
		    input logic [15:0] 	cfg_addr,
		    output logic [1:0] 	OP_MODE_REG,
		    output logic [2:0] 	DATA_TYPE,
		    output logic [31:0] AUTO_SPLIT,
		    output logic [31:0] TRAIN_DATA_BASE,
		    output logic [31:0] TEST_DATA_BASE,
		    output logic [31:0] TRAIN_ALGO,
		    output logic [31:0] NUM_DIM,
		    output logic [31:0] NUM_DATA_POINTS,
		    output logic [31:0] DIM_BASE_PTR,
		    input logic [31:0] 	DIM_BASE_PTR_NUM,
			 output logic [31:0] INFER_RES_BASE_PTR,
			 output logic [31:0] INFER_RES_BLK_SIZE,
		    output logic [31:0] MODE_DATASET_ORG,
		    input logic 	batch_comp_done,
		    output logic [31:0] cfg_done

		    );
   
   
   localparam 	DIM_BASE_PTR_MAX_DIM = 1;
   
   logic [31:0] 			cfg_regs[0:15+DIM_BASE_PTR_MAX_DIM];
   

   assign  OP_MODE_REG = cfg_regs[0][1:0];    
   assign  DATA_TYPE = cfg_regs[1][2:0];       
   assign  AUTO_SPLIT = cfg_regs[2];      
   assign  TRAIN_DATA_BASE = cfg_regs[3]; 
   assign  TEST_DATA_BASE = cfg_regs[4];  
   assign  TRAIN_ALGO = cfg_regs[5];      
   assign  NUM_DIM = cfg_regs[6];         
   assign  NUM_DATA_POINTS = cfg_regs[7]; 
   assign  DIM_BASE_PTR = cfg_regs[12];    
   assign  MODE_DATASET_ORG = cfg_regs[10];
	assign cfg_done = cfg_regs[9][0];
	assign INFER_RES_BASE_PTR = cfg_regs[12 ];
	assign INFER_RES_BLK_SIZE = cfg_regs[13 ];

   
   
   always@(posedge clk) begin
      if(!rst_n) begin
	 for(int i = 0; i < DIM_BASE_PTR_MAX_DIM+16; i++) begin
	    cfg_regs[i] <= 0;		      
	 end		   
      end
      else begin
	 cfg_regs[ 0 ] <= 1; //train mode
	 cfg_regs[ 1 ] <= 2; //float
	 cfg_regs[ 2 ] <= 32'h3e4ccccd; // 0.2 test set
	 cfg_regs[ 3 ] <= 32'h0; //train/test data base addr
	 cfg_regs[ 4 ] <= 0; //test data is auto split
	 cfg_regs[ 5 ] <= 1; // training algo: gradient desc
	 cfg_regs[ 6 ] <= 2; // num dims
	 cfg_regs[ 7 ] <= 1024; // no. data points
	 cfg_regs[ 8 ] <= 2; // entire data point is consecutively arrgnd
	 cfg_regs[ 9 ] <= 1; // cfg done
	 cfg_regs[10 ] <= batch_comp_done; // requested comp done
	 cfg_regs[11 ] <= 0; //cfg error
	 cfg_regs[12 ] <= 32'h00000200; // infer res base ptr
	 cfg_regs[13 ] <= 1; // res str stack size
	 cfg_regs[14 ] <= 0; // Scatter DS base ptr

	 if(cfg_req_vld & (cfg_regs[9] != 1) & cfg_data_rb_w) begin
	    cfg_regs[cfg_addr] <= cfg_data;	    
	 end
	 else if(cfg_req_vld & !cfg_data_rb_w) begin
	    cfg_rd_data <= cfg_regs[cfg_addr];
	    cfg_data_rd_vld <= 1;	    
	 end
	 else begin
	    for(int i = 0; i < DIM_BASE_PTR_MAX_DIM+16; i++) begin
	       cfg_regs[i] <= cfg_regs[i];		      
	    end		    
	 end
      end
   end


endmodule
