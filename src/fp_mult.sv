`include "param.sv"
//`include "detect_pos_first_one.v"



module fp_mult (
  input logic clk,
  input logic rst_n,
  input logic mult_op_sel,
  input logic mult_en,
  input logic [DATA_WIDTH-1:0] 	    data_1,
  input logic [DATA_WIDTH-1:0] 	    data_2,
  output logic [DATA_WIDTH-1:0] data_prod,
  output logic [DATA_WIDTH-1:0] data_prod_o,
  output logic data_prod_o_vld

		);


   
   // Declarations //
  parameter [8:0]         BIAS = 9'd127;
  parameter [8:0]		EXP_MAX = 9'b011111111;
  logic [47:0] 				    data_prod_full;
  logic  [47:0] 				    data_prod_full_normalized;
  logic  [23:0] 				    data_1_mult_in;
  logic  [23:0] 				    data_2_mult_in;   
 logic  				    sign_bit;
 logic  [8:0] 				    data_exp;
 logic [5:0] 				    shift_exp_by;
 logic  [7:0] 				    exp_final; 
  logic							prod_infinite;
  logic							prod_zero;
  logic							is_no_shft_rqd;
  logic							is_l_shft_rqd;
  logic							is_r_shft_rqd;
   //______________//

   
   
   // iteration variable //
   //genvar 				    i;
   //______________//



   // Mantissa multiplication inputs //
  assign data_1_mult_in = { 1'b1, data_1[22:0]};
  assign data_2_mult_in = { 1'b1, data_2[22:0]};
   //______________//

   
   
   // Sign bit and exponent value determination //
   assign sign_bit = data_1[31] ^ data_2[31];
  assign data_exp = {1'b0, data_1[30:23]} + {1'b0, data_2[30:23]} - BIAS;
  assign prod_infinite = ((data_exp >= EXP_MAX) | data_exp[8]) ? 1:0;
  assign prod_zero = (data_exp == 0)? 1:0;
   //______________//


   
   // Multiplier for Manitissa //
	//assign data_prod_full = data_1_mult_in * data_2_mult_in;
  
   always @( data_1_mult_in or data_2_mult_in ) begin // FULL MULTIPLICATION        
      data_prod_full = 0;
     for(int i=0; i<24; i=i+1) begin      
       if( data_1_mult_in[i] == 1'b1 ) data_prod_full = data_prod_full + ({24'h0, data_2_mult_in} << i );
      
	   end
     data_prod_full = data_prod_full + 1'b1;
   end
   //______________//



   // detect the first 1 in the product //
   detect_pos_first_one #(.D_WIDTH(48)) shift_for_exp (.data_i(data_prod_full), .pos_o(shift_exp_by));
  assign is_r_shft_rqd = (shift_exp_by == 0);
  assign is_no_shft_rqd = (shift_exp_by == 1);
  assign is_l_shft_rqd = !(is_r_shft_rqd | is_no_shft_rqd);
  //assign data_prod_full_normalized = (is_l_shft_rqd)?  (data_prod_full << (shift_exp_by -1)) : ((is_r_shft_rqd)? (data_prod_full>>1):data_prod_full); 
  //assign data_prod_full_normalized = (is_r_shft_rqd) ? data_prod_full : data_prod_full[46:23]+1'b1;
  assign exp_final = ((is_r_shft_rqd)? (data_exp[8:0] + 1):(data_exp[8:0]));  
   //______________//


   
   // Final output product //
   always@(*) begin
     if(!(prod_infinite | prod_zero)) begin
      data_prod[31] <= sign_bit;
      data_prod[30:23] <= exp_final;
       data_prod[22:0] <= (is_r_shft_rqd)? data_prod_full[47:24]: data_prod_full[46:23] + 1'b1; 
     end
     else begin
       if(prod_infinite) begin
        data_prod[31] <= sign_bit;
         data_prod[30:23] <= 8'b11111111;
         data_prod[22:0] <= 23'h0; 
       end
       else begin
         data_prod[31] <= sign_bit;
         data_prod[30:23] <= 8'b00000000;
         data_prod[22:0] <= 23'h0;          
       end
     end
   end
   //______________//
   

  
  //------accum inst---------//
    
  accumulator i_fp_mult_accum(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(data_prod),
    .stg_en(mult_en),
    .accum_data_out(data_prod_o),
    .accum_data_vld(data_prod_o_vld)
		    );
  //-------------------------//
   
endmodule // fp_mult
