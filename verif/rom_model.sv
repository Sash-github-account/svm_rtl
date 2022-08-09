
module rom_model#(parameter WR_ADDR_WD = 8, parameter WR_DATA_WD = 8, parameter DATA_DEPTH = 124)(
								 input logic clk,
								 input logic reset_n,
								 // From/to read controller //
								 input logic 		  rd_vld,
								 input logic [WR_ADDR_WD-1:0]  rd_addr,
								 output logic [WR_DATA_WD-1:0] rd_data,
								 output logic 		  rd_data_out_vld
								 );


   // Declarations //
	/*
	# (
parameter WR_DATA_WD = DATA_WIDTH,
parameter DATA_DEPTH = DATAMEM_DEPTH,
parameter WR_ADDR_WD = $clog2(DATAMEM_DEPTH),
parameter RD_ADDR_WD  = $clog2(DATAMEM_DEPTH),
parameter RD_DATA_WD  = DATA_WIDTH
					)
	*/
   logic [WR_DATA_WD-1:0] 				  data_mem [0:DATA_DEPTH-1];
  logic [WR_DATA_WD-1:0] data_wire;
   //--------------//
  
  assign data_wire = data_mem[rd_addr];
  
   always_ff@(posedge clk) begin
      if(!reset_n)begin
	 for(int i=0; i < DATA_DEPTH-1; i++) begin
       data_mem[i] <= 8'b00000000;
	    
	 end
	 
      end
      else begin
		data_mem[ 0 ]   <= 8'b00111111;  
		data_mem[  1]   <= 8'b10000000;  
		data_mem[  2]   <= 8'b00000000;  
		data_mem[  3]   <= 8'b00000000;  
		data_mem[  4]   <= 8'b01000000;  
		data_mem[  5]   <= 8'b00000000;  
		data_mem[  6]   <= 8'b00000000;  
		data_mem[  7]   <= 8'b00000000;  
		data_mem[  8]   <= 8'b01000000;  
		data_mem[  9]   <= 8'b10100000;  
		data_mem[ 10]   <= 8'b00000000;  
		data_mem[ 11]   <= 8'b00000000;  
		data_mem[ 12]   <= 8'b01000001;  
		data_mem[ 13]   <= 8'b00000000;  
		data_mem[ 14]   <= 8'b00000000;  
		data_mem[ 15]   <= 8'b00000000;  
		data_mem[ 16]   <= 8'b00111111;  
		data_mem[ 17]   <= 8'b11000000;  
		data_mem[ 18]   <= 8'b00000000;  
		data_mem[ 19]   <= 8'b00000000;
		data_mem[ 20]   <= 8'b00111111;
		data_mem[ 21]   <= 8'b11100110;
		data_mem[ 22]   <= 8'b01100110;
		data_mem[ 23]   <= 8'b01100110;
		data_mem[ 24]   <= 8'b01000001;
		data_mem[ 25]   <= 8'b00000000;
		data_mem[ 26]   <= 8'b00000000;
		data_mem[ 27]   <= 8'b00000000;
		data_mem[ 28]   <= 8'b01000001;
		data_mem[ 29]   <= 8'b00000000;
		data_mem[ 30]   <= 8'b00000000;
		data_mem[ 31]   <= 8'b00000000;
		data_mem[ 32]   <= 8'b00111111;
		data_mem[ 33]   <= 8'b10000000;
		data_mem[ 34]   <= 8'b00000000;
		data_mem[ 35]   <= 8'b00000000;
		data_mem[ 36]   <= 8'b00111111;
		data_mem[ 37]   <= 8'b00011001;
		data_mem[ 38]   <= 8'b10011001;
		data_mem[ 39]   <= 8'b10011001;
		data_mem[ 40]   <= 8'b01000001;
		data_mem[ 41]   <= 8'b00010000;
		data_mem[ 42]   <= 8'b00000000;
		data_mem[ 43]   <= 8'b00000000;
		data_mem[ 44]   <= 8'b01000001;
		data_mem[ 45]   <= 8'b00110000;
		data_mem[ 46]   <= 8'b00000000;
		data_mem[ 47]   <= 8'b00000000;
		data_mem[ 48]   <= 8'b01000000;
		data_mem[ 49]   <= 8'b11100000;
		data_mem[ 50]   <= 8'b00000000;
		data_mem[ 51]   <= 8'b00000000;
		data_mem[ 52]   <= 8'b01000001;
		data_mem[ 53]   <= 8'b00100000;
		data_mem[ 54]   <= 8'b00000000;
		data_mem[ 55]   <= 8'b00000000;
		data_mem[ 56]   <= 8'b01000001;
		data_mem[ 57]   <= 8'b00001011;
		data_mem[ 58]   <= 8'b00110011;
		data_mem[ 59]   <= 8'b00110011;
		data_mem[ 60]   <= 8'b01000001;
		data_mem[ 61]   <= 8'b00010110;
		data_mem[ 62]   <= 8'b01100110;
		data_mem[ 63]   <= 8'b01100110;
		data_mem[ 64]   <= 8'b01000000;
		data_mem[ 65]   <= 8'b00010011;
		data_mem[ 66]   <= 8'b00110011;
		data_mem[ 67]   <= 8'b00110011;
		data_mem[ 68]   <= 8'b01000000;
		data_mem[ 69]   <= 8'b10000000;
		data_mem[ 70]   <= 8'b00000000;
		data_mem[ 71]   <= 8'b00000000;
		data_mem[ 72]   <= 8'b01000000;
		data_mem[ 73]   <= 8'b10110000;
		data_mem[ 74]   <= 8'b00000000;
		data_mem[ 75]   <= 8'b00000000;
		data_mem[ 76]   <= 8'b01000000;
		data_mem[ 77]   <= 8'b01000000;
		data_mem[ 78]   <= 8'b00000000;
		data_mem[ 79]   <= 8'b00000000;
		data_mem[ 80]   <= 8'b01000000;
		data_mem[ 81]   <= 8'b11110110;
		data_mem[ 82]   <= 8'b01100110;
		data_mem[ 83]   <= 8'b01100110;
		data_mem[ 84]   <= 8'b01000001;
		data_mem[ 85]   <= 8'b00001100;
		data_mem[ 86]   <= 8'b11001100;
		data_mem[ 87]   <= 8'b11001100;
		data_mem[ 88]   <= 8'b01000000;
		data_mem[ 89]   <= 8'b11000011;
		data_mem[ 90]   <= 8'b00110011;
		data_mem[ 91]   <= 8'b00110011;
		data_mem[ 92]   <= 8'b01000000;
		data_mem[ 93]   <= 8'b11110000;
		data_mem[ 94]   <= 8'b00000000;
		data_mem[ 95]   <= 8'b00000000;
	 
		data_mem[ 96]   <= 8'b00111110;
		data_mem[ 97]   <= 8'b00001000;
		data_mem[ 98]   <= 8'b01111000;
		data_mem[ 99]   <= 8'b01000101;
		data_mem[100]   <= 8'b00111110;
		data_mem[101]   <= 8'b11011010;
		data_mem[102]   <= 8'b01110101;
		data_mem[103]   <= 8'b00100010;
        data_mem[104]   <= 8'b11000000;
        data_mem[105]   <= 8'b01000000;
        data_mem[106]   <= 8'b11010110;
        data_mem[107]   <= 8'b01100101;
     end

   end


   
   // Read logic //
   always_ff@(posedge clk) begin
      if(!reset_n) begin
	 rd_data <= 0;	 
	 rd_data_out_vld <= 0;
      end
      else begin
	 if(rd_vld) begin
	    rd_data <= data_wire;
	    rd_data_out_vld <= 1;
	 end
	 else begin
	    rd_data_out_vld <= 0;
	    rd_data <= 0;	    
	 end
      end
      
   end 
   //------------//

   
endmodule // linked_list_data_mem
						
						
