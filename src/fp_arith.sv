// Code your design here
`include "param.sv"

module fp_arith (
  input logic clk,
  input logic rst_n,
		 input logic [DATA_WIDTH-1:0]      data_1,
		 input logic [DATA_WIDTH-1:0]      data_2,
		 input logic			     op_sel,
  		 input logic			     en,
  output logic [DATA_WIDTH-1:0] data_accum_o,
  output logic data_o_vld
		 );



   // Declarations //
  logic [24:0] 				     temp_sum;
  logic [23:0] 				     temp_diff;
  logic [23:0] 				     data_1_mantissa;
  logic [23:0] 				     data_2_mantissa;
  logic [23:0] 				     sum_final_mantissa;
  logic [23:0] 				     diff_final_mantissa;
  logic [7:0] 				     exp_diff;
  logic [7:0] 				     exp_out;   
  logic [7:0] 				     diff_exp_out;   
  logic [7:0] 				     ovrfl_exp_out;   
  logic [23:0] 				     first_opnd;
  logic [23:0] 				     second_opnd;
  logic [7:0] 				     first_opnd_exp;
  logic [7:0] 				     second_opnd_exp;
  logic [23:0] 				     data_to_shift;   
  logic [23:0] 				     shifted_data;  
  logic 				     exp_are_equal;
  logic 				     data_1_exp_greater;
  logic 				     final_data_1_greater;
  logic [4:0] 				     diff_shift_by;
  logic [1:0] mux_ctrl_bits;
  logic [DATA_WIDTH-1:0] data_o;
   //_____________________//



   // mantissa extraction //
  assign data_1_mantissa = {1'b1, data_1[22:0]};
  assign data_2_mantissa = {1'b1, data_2[22:0]};
   //_____________________//

   
   
   // exponent related calculations //
   assign exp_are_equal = ~(|(data_1[30:23] ^ data_2[30:23]));
   assign data_1_exp_greater = (data_1[30:23] > data_2[30:23]);   
   assign exp_out = (exp_are_equal) ? data_1[30:23] : ((data_1_exp_greater) ? data_1[30:23] : data_2[30:23]);
   assign first_opnd_exp = (data_1_exp_greater) ? data_1[30:23] : data_2[30:23];
   assign second_opnd_exp = (data_1_exp_greater) ? data_2[30:23] : data_1[30:23];
   assign exp_diff = first_opnd_exp - second_opnd_exp;
   //_____________________//


   
   // shifting operation //
   assign data_to_shift = (data_1_exp_greater)? data_2_mantissa : data_1_mantissa;  
   assign shifted_data = data_to_shift >> exp_diff;
   //_____________________//


   
   // detection of greater operand //   
   assign final_data_1_greater = (exp_are_equal)? ((data_1_mantissa> data_2_mantissa)? 1'b1 : 1'b0 ) :((data_1_exp_greater)? ((data_1_mantissa > shifted_data)? 1'b1 : 1'b0):((data_2_mantissa > shifted_data)? 1'b0 : 1'b1));
  assign first_opnd = (exp_are_equal)? ((data_1_mantissa>= data_2_mantissa)? data_1_mantissa : data_2_mantissa ) :((data_1_exp_greater)? ((data_1_mantissa >= shifted_data)? data_1_mantissa : shifted_data):((data_2_mantissa >= shifted_data)? data_2_mantissa : shifted_data));
  assign second_opnd = (exp_are_equal)? ((data_1_mantissa>= data_2_mantissa)? data_2_mantissa : data_1_mantissa ) :((data_1_exp_greater)? ((data_1_mantissa >= shifted_data)? shifted_data : data_1_mantissa):((data_2_mantissa >= shifted_data)?  shifted_data : data_2_mantissa));
  assign mux_ctrl_bits = (final_data_1_greater)? {data_1[31],data_2[31]}:{data_1[31],data_2[31]};
   //_____________________//


   
   // adder and shifter //
   assign temp_sum = first_opnd + second_opnd;
  assign sum_final_mantissa = (temp_sum[24])? temp_sum >> 1: temp_sum;   
  assign ovrfl_exp_out = (temp_sum[24]) ? exp_out+1 : exp_out; 
   //_____________________//
   

   
   // subtraction operation //
   assign temp_diff = first_opnd - second_opnd;
   detect_pos_first_one #(.D_WIDTH(24)) num_to_shift (.data_i(temp_diff), .pos_o(diff_shift_by));
   assign diff_final_mantissa = temp_diff << diff_shift_by;
   assign diff_exp_out = exp_out - diff_shift_by;
   //_____________________//


   
   // final output determination based on sign bit //
   always@(*) begin
      
      data_o  = ACCUM_INIT;
   
       case (mux_ctrl_bits)
	2'b00: begin // Both numbers are positive
      if(~op_sel) begin // ADDITION
	      data_o[31] = 1'b0;
        data_o[30:23] = ovrfl_exp_out;
	      data_o[22:0] = sum_final_mantissa[22:0];
	   end
	   else begin // SUBTRACTION
	      data_o[31] = ~final_data_1_greater;
	      data_o[30:23] = diff_exp_out;	      
	      data_o[22:0] = diff_final_mantissa[22:0];	      
	   end	   	   
	end

	2'b01: begin // data_1 is positive and data_2 is negative
      if(~op_sel ) begin // ADDITION
        data_o[31] = ~final_data_1_greater;
	      data_o[30:23] = diff_exp_out;
	      data_o[22:0] = diff_final_mantissa[22:0];
	   end
	   else begin // SUBTRACTION
	      data_o[31] = 1'b0;
	      data_o[30:23] = ovrfl_exp_out;	      
	      data_o[22:0] =  sum_final_mantissa[22:0];
	   end	   
	end

	2'b10: begin // data_1 is negative and data_2 is positive
      if(~op_sel ) begin // ADDITION
	      data_o[31] = final_data_1_greater;	   
	      data_o[30:23] = diff_exp_out;
	      data_o[22:0] = diff_final_mantissa[22:0];
	   end
	   else begin // SUBTRACTION
	      data_o[31] = 1'b1;
	      data_o[30:23] = ovrfl_exp_out;	      
	      data_o[22:0] =  sum_final_mantissa[22:0];
	   end 
	end

	2'b11: begin // both numbers are negative
	   if(~op_sel) begin // ADDITION
	      data_o[31] = 1'b1;
	      data_o[30:23] =ovrfl_exp_out;
	      data_o[22:0] = sum_final_mantissa[22:0];
	   end
	   else begin // SUBTRACTION
	      data_o[31] = final_data_1_greater;	   
	      data_o[30:23] = diff_exp_out;
	      data_o[22:0] = diff_final_mantissa[22:0];
	   end	   
	end
	 default : data_o  = ACCUM_INIT;	
      endcase // case (data_1[31],data_2[31])      

   end
   //_____________________//

  
  accumulator i_fp_arith_accum(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_o),
    .stg_en(en),
    .accum_data_out(data_accum_o),
    .accum_data_vld(data_o_vld)
		    );

   
endmodule // fp_arith
