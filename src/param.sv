`ifndef _parameters_vh_
`define _parameters_vh_
parameter integer DATA_WIDTH = 32;
parameter integer NUM_MODES = 3;
parameter integer MAX_NUM_TERMS = 32;
parameter integer RES_WIDTH = $clog2(MAX_NUM_TERMS);
parameter [31:0] ACCUM_INIT = 32'h3f800000;
parameter integer NUM_COEFF = 33;
parameter integer ADDR_WIDTH = 6;
parameter integer FIFO_DEPTH = 32;
parameter integer FIFO_CNT_WIDTH = $clog2(FIFO_DEPTH);
parameter integer CNTR_DEPTH = $clog2(MAX_NUM_TERMS)+1;
parameter MLRN_FSM_WD = 5;
parameter TERM_CNTR_WD = RES_WIDTH;
parameter NUM_PAD_BITS = 1;
parameter NUM_MODE_BITS = 3;
parameter NUM_RES_BITS = 4;
parameter IEEE_32BIT = 32;
parameter INST_SIZE = NUM_PAD_BITS + NUM_MODE_BITS + NUM_RES_BITS + IEEE_32BIT;
parameter ROM_DATA_WIDTH = 8;
parameter ROM_ADDR_WIDTH = 15;
parameter RAM_DATA_WIDTH = 8;
parameter RAM_ADDR_WIDTH = 10;
parameter INST_SIZE_MOD_ROM_DATA_WIDTH = INST_SIZE%ROM_DATA_WIDTH;
parameter ADD_ONE = (INST_SIZE_MOD_ROM_DATA_WIDTH > 0) ? 1 : 0;
parameter NUM_OF_ROM_FIFO_RD_PER_INST = (INST_SIZE/ROM_DATA_WIDTH) + ADD_ONE;
parameter FIFO_DATA_WIDTH = 32;
parameter ROM_FIFO_DATA_WIDTH = 8;
parameter NUM_VLD_ROM_DATA = 20;
parameter BYTES_PER_BURST = 4;
parameter SCIACC_RESP_FIFO_DATA_WIDTH = 32;
parameter ROM_WR_DATA_WD = 8;
parameter BATCH_WD = 20;
parameter ROM_WR_ADDR_WD = 15;
 
typedef enum logic[NUM_MODE_BITS-1:0]{
			EXP, //0
			SIN, //1
			COS //2 
			} t_mainop_types;
/*
`include "accumulator.sv"
`include "coeff_rom.sv"
`include "detect_pos_first_one.sv"
`include "fifo.sv"
`include "fp_arith.sv"
`include "fp_mult.sv"
`include "generic_fifo.sv"
`include "heart_beat.sv"
`include "pulse_to_level.sv"
`include "ram_dma_wr_ctrl.sv"
`include "ram_wr_dma_top.sv"
`include "rom_dma_ctrl.sv"
`include "rom_dma_sci_acc_intf.sv"
`include "rom_dma_top.sv"
`include "sci_acc_maclauren_exp_ctrl.sv"
`include "sci_acc_sce_mclrn_comp_core.sv"
`include "term_counter.sv"*/
`endif


