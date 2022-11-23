// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

module riscv_tb;
	reg clock;
	reg rtc;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	wire [37:0] mprj_io_0;


	reg cpu_reset;





	assign mprj_io_0 = mprj_io;
	// assign mprj_io_0 = {mprj_io[8:4],mprj_io[2:0]};

	// assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;
	// assign mprj_io[3] = 1'b1;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #25 clock <= (clock === 1'b0);
	always #1000 rtc <= (rtc === 1'b0);

	initial begin
		clock = 0;
		rtc = 0;
	end


	`ifdef ENABLE_SDF
		initial begin
			$sdf_annotate("../../../sdf/user_proj_example.sdf", uut.mprj) ;
			$sdf_annotate("../../../sdf/user_project_wrapper.sdf", uut.mprj.mprj) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/DFFRAM.sdf", uut.soc.DFFRAM_0) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/mgmt_core.sdf", uut.soc.core) ;
			$sdf_annotate("../../../caravel/sdf/housekeeping.sdf", uut.housekeeping) ;
			$sdf_annotate("../../../caravel/sdf/chip_io.sdf", uut.padframe) ;
			$sdf_annotate("../../../caravel/sdf/mprj_logic_high.sdf", uut.mgmt_buffers.mprj_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mprj2_logic_high.sdf", uut.mgmt_buffers.mprj2_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect_hv.sdf", uut.mgmt_buffers.powergood_check) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect.sdf", uut.mgmt_buffers) ;
			$sdf_annotate("../../../caravel/sdf/caravel_clocking.sdf", uut.clocking) ;
			$sdf_annotate("../../../caravel/sdf/digital_pll.sdf", uut.pll) ;
			$sdf_annotate("../../../caravel/sdf/xres_buf.sdf", uut.rstb_level) ;
			$sdf_annotate("../../../caravel/sdf/user_id_programming.sdf", uut.user_id_value) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[11] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[12] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[13] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[14] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[15] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_5) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_6) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_7) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_8) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_9) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_10) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_11) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_12) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_13) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_14) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_15) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_16) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_17) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_18) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_19) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_20) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_21) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_22) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_23) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_24) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_25) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_26) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_27) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_28) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_29) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_30) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_31) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_32) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_33) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_34) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_35) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_36) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_37) ;
		end
	`endif 

	initial begin
		$dumpfile("riscv.vcd");
		$dumpvars(0, riscv_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (1000) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		$display("%c[0m",27);
		$finish;
	end


	initial begin
		cpu_reset = 1'b1;
		RSTB = 1'b0;
		CSB  = 1'b1;		// Force CSB high
		#2000;
		RSTB = 1'b1;	    	// Release reset
		#600000;
		CSB = 1'b0;		// CSB can be released
		#1200000;
		cpu_reset = 1'b0;
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end


	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("riscv.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

wire [15:0] io_hspi_rx_data;
wire [15:0] io_hspi_tx_data;
wire io_hspi_rx_enable;
wire io_hspi_tx_enable;
wire hspi_clk;
wire hartIsInReset;
wire hartResetReq;
wire hartHaltReq;
wire msi;
wire mti;
wire ssi;
wire sti;
wire mei;
wire sei;

  wire         memory_0_aw_ready;
  wire         memory_0_aw_valid;
  wire [3:0]   memory_0_aw_bits_id;
  wire [31:0]  memory_0_aw_bits_addr;
  wire [7:0]   memory_0_aw_bits_len;
  wire [2:0]   memory_0_aw_bits_size;
  wire [1:0]   memory_0_aw_bits_burst;
  wire         memory_0_aw_bits_lock;
  wire [3:0]   memory_0_aw_bits_cache;
  wire [2:0]   memory_0_aw_bits_prot;
  wire [3:0]   memory_0_aw_bits_qos;
  wire         memory_0_w_ready;
  wire         memory_0_w_valid;
  wire [127:0] memory_0_w_bits_data;
  wire [15:0]  memory_0_w_bits_strb;
  wire         memory_0_w_bits_last;
  wire         memory_0_b_ready;
  wire         memory_0_b_valid;
  wire [3:0]   memory_0_b_bits_id;
  wire [1:0]   memory_0_b_bits_resp;
  wire         memory_0_ar_ready;
  wire         memory_0_ar_valid;
  wire [3:0]   memory_0_ar_bits_id;
  wire [31:0]  memory_0_ar_bits_addr;
  wire [7:0]   memory_0_ar_bits_len;
  wire [2:0]   memory_0_ar_bits_size;
  wire [1:0]   memory_0_ar_bits_burst;
  wire         memory_0_ar_bits_lock;
  wire [3:0]   memory_0_ar_bits_cache;
  wire [2:0]   memory_0_ar_bits_prot;
  wire [3:0]   memory_0_ar_bits_qos;
  wire         memory_0_r_ready;
  wire         memory_0_r_valid;
  wire [3:0]   memory_0_r_bits_id;
  wire [127:0] memory_0_r_bits_data;
  wire [1:0]   memory_0_r_bits_resp;
  wire         memory_0_r_bits_last;


Rift2LinkB i_Rift2LinkB(
  .clock(hspi_clk),
  .reset(cpu_reset),
  .io_rtc_clock(rtc),
  .io_JtagIO_TRSTn(1'b0),
  .io_JtagIO_TCK(1'b0),
  .io_JtagIO_TMS(1'b0),
  .io_JtagIO_TDI(1'b0),
  .io_JtagIO_TDO(),
  .io_JtagIO_TDO_driven(),
  .io_ndreset(),
  .io_interrupt_0(1'b0),
  .io_interrupt_1(1'b0),
  .io_interrupt_2(1'b0),
  .io_interrupt_3(1'b0),
  .io_interrupt_4(1'b0),
  .io_interrupt_5(1'b0),
  .io_interrupt_6(1'b0),
  .io_interrupt_7(1'b0),
  .io_interrupt_8(1'b0),
  .io_interrupt_9(1'b0),
  .io_interrupt_10(1'b0),
  .io_interrupt_11(1'b0),
  .io_interrupt_12(1'b0),
  .io_interrupt_13(1'b0),
  .io_interrupt_14(1'b0),
  .io_interrupt_15(1'b0),
  .io_interrupt_16(1'b0),
  .io_interrupt_17(1'b0),
  .io_interrupt_18(1'b0),
  .io_interrupt_19(1'b0),
  .io_interrupt_20(1'b0),
  .io_interrupt_21(1'b0),
  .io_interrupt_22(1'b0),
  .io_interrupt_23(1'b0),
  .io_interrupt_24(1'b0),
  .io_interrupt_25(1'b0),
  .io_interrupt_26(1'b0),
  .io_interrupt_27(1'b0),
  .io_interrupt_28(1'b0),
  .io_interrupt_29(1'b0),
  .io_interrupt_30(1'b0),
  .io_dm_hartIsInReset(hartIsInReset),
  .io_dm_hartResetReq(hartResetReq),
  .io_dm_hartHaltReq(hartHaltReq),
  .io_aclint_msi(msi),
  .io_aclint_mti(mti),
  .io_aclint_ssi(ssi),
  .io_aclint_sti(sti),
  .io_plic_mei(mei),
  .io_plic_sei(sei),
  .io_hspi_clk(hspi_clk),
  .io_hspi_reset(cpu_reset),
  .io_hspi_rx_enable(io_hspi_tx_enable),
  .io_hspi_rx_data(io_hspi_tx_data),
  .io_hspi_tx_enable(io_hspi_rx_enable),
  .io_hspi_tx_data(io_hspi_rx_data),
  .memory_0_aw_ready(memory_0_aw_ready),
  .memory_0_aw_valid(memory_0_aw_valid),
  .memory_0_aw_bits_id(memory_0_aw_bits_id),
  .memory_0_aw_bits_addr(memory_0_aw_bits_addr),
  .memory_0_aw_bits_len(memory_0_aw_bits_len),
  .memory_0_aw_bits_size(memory_0_aw_bits_size),
  .memory_0_aw_bits_burst(memory_0_aw_bits_burst),
  .memory_0_aw_bits_lock(memory_0_aw_bits_lock),
  .memory_0_aw_bits_cache(memory_0_aw_bits_cache),
  .memory_0_aw_bits_prot(memory_0_aw_bits_prot),
  .memory_0_aw_bits_qos(memory_0_aw_bits_qos),
  .memory_0_w_ready(memory_0_w_ready),
  .memory_0_w_valid(memory_0_w_valid),
  .memory_0_w_bits_data(memory_0_w_bits_data),
  .memory_0_w_bits_strb(memory_0_w_bits_strb),
  .memory_0_w_bits_last(memory_0_w_bits_last),
  .memory_0_b_ready(memory_0_b_ready),
  .memory_0_b_valid(memory_0_b_valid),
  .memory_0_b_bits_id(memory_0_b_bits_id),
  .memory_0_b_bits_resp(memory_0_b_bits_resp),
  .memory_0_ar_ready(memory_0_ar_ready),
  .memory_0_ar_valid(memory_0_ar_valid),
  .memory_0_ar_bits_id(memory_0_ar_bits_id),
  .memory_0_ar_bits_addr(memory_0_ar_bits_addr),
  .memory_0_ar_bits_len(memory_0_ar_bits_len),
  .memory_0_ar_bits_size(memory_0_ar_bits_size),
  .memory_0_ar_bits_burst(memory_0_ar_bits_burst),
  .memory_0_ar_bits_lock(memory_0_ar_bits_lock),
  .memory_0_ar_bits_cache(memory_0_ar_bits_cache),
  .memory_0_ar_bits_prot(memory_0_ar_bits_prot),
  .memory_0_ar_bits_qos(memory_0_ar_bits_qos),
  .memory_0_r_ready(memory_0_r_ready),
  .memory_0_r_valid(memory_0_r_valid),
  .memory_0_r_bits_id(memory_0_r_bits_id),
  .memory_0_r_bits_data(memory_0_r_bits_data),
  .memory_0_r_bits_resp(memory_0_r_bits_resp),
  .memory_0_r_bits_last(memory_0_r_bits_last),

  .system_0_aw_ready(1'b1),
  .system_0_aw_valid(),
  .system_0_aw_bits_id(),
  .system_0_aw_bits_addr(),
  .system_0_aw_bits_len(),
  .system_0_aw_bits_size(),
  .system_0_aw_bits_burst(),
  .system_0_aw_bits_lock(),
  .system_0_aw_bits_cache(),
  .system_0_aw_bits_prot(),
  .system_0_aw_bits_qos(),
  .system_0_w_ready(1'b1),
  .system_0_w_valid(),
  .system_0_w_bits_data(),
  .system_0_w_bits_strb(),
  .system_0_w_bits_last(),
  .system_0_b_ready(),
  .system_0_b_valid(1'b0),
  .system_0_b_bits_id(4'b0),
  .system_0_b_bits_resp(2'b0),
  .system_0_ar_ready(1'b1),
  .system_0_ar_valid(),
  .system_0_ar_bits_id(),
  .system_0_ar_bits_addr(),
  .system_0_ar_bits_len(),
  .system_0_ar_bits_size(),
  .system_0_ar_bits_burst(),
  .system_0_ar_bits_lock(),
  .system_0_ar_bits_cache(),
  .system_0_ar_bits_prot(),
  .system_0_ar_bits_qos(),
  .system_0_r_ready(),
  .system_0_r_valid(1'b0),
  .system_0_r_bits_id(4'b0),
  .system_0_r_bits_data(64'b0),
  .system_0_r_bits_resp(2'b0),
  .system_0_r_bits_last(1'b0)
);


axi_full_slv_sram # ( .DW(128), .AW(18) ) s_axi_full_slv_sram 
(
	.MEM_AWID   (memory_0_aw_bits_id),
	.MEM_BID    (memory_0_b_bits_id),
	.MEM_ARID   (memory_0_ar_bits_id),
	.MEM_RID    (memory_0_r_bits_id),

	.MEM_AWADDR (memory_0_aw_bits_addr),
	.MEM_AWLEN  (memory_0_aw_bits_len),
	.MEM_AWSIZE (memory_0_aw_bits_size),
	.MEM_AWBURST(memory_0_aw_bits_burst),
	.MEM_AWVALID(memory_0_aw_valid),
	.MEM_AWREADY(memory_0_aw_ready),

	.MEM_WDATA (memory_0_w_bits_data),
	.MEM_WSTRB (memory_0_w_bits_strb),
	.MEM_WLAST (memory_0_w_bits_last),
	.MEM_WVALID(memory_0_w_valid),
	.MEM_WREADY(memory_0_w_ready),

	.MEM_BRESP (memory_0_b_bits_resp),
	.MEM_BVALID(memory_0_b_valid),
	.MEM_BREADY(memory_0_b_ready),

	.MEM_ARADDR (memory_0_ar_bits_addr),
	.MEM_ARLEN  (memory_0_ar_bits_len),
	.MEM_ARSIZE (memory_0_ar_bits_size),
	.MEM_ARBURST(memory_0_ar_bits_burst),
	.MEM_ARVALID(memory_0_ar_valid),
	.MEM_ARREADY(memory_0_ar_ready),

	.MEM_RDATA (memory_0_r_bits_data),
	.MEM_RRESP (memory_0_r_bits_resp),
	.MEM_RLAST (memory_0_r_bits_last),
	.MEM_RVALID(memory_0_r_valid),
	.MEM_RREADY(memory_0_r_ready),

	.CLK        (hspi_clk),
	.RSTn       (~cpu_reset)
);




`define MEM s_axi_full_slv_sram.i_sram.ram
reg [7:0] mem [0:200000];

localparam DP = 2**18;
integer i, by;
initial begin
	$readmemh("./ci/rv64ui-p-simple.verilog", mem);

	for ( i = 0; i < DP; i = i + 1 ) begin
		for ( by = 0; by < 16; by = by + 1 ) begin
			if ( | mem[i*16+by] ) begin
				`MEM[i][8*by +: 8] = mem[i*16+by];
			end
			else begin
				`MEM[i][8*by +: 8] = 8'h0;
			end
		end
	end
end 




wire is_ecall_U = uut.mprj.i_Rift2Wrap.i_Rift2LinkA.i_rift2Core.diff.io_commit_is_ecall_U;
wire is_ecall_M = uut.mprj.i_Rift2Wrap.i_Rift2LinkA.i_rift2Core.diff.io_commit_is_ecall_M;
wire is_ecall_S = uut.mprj.i_Rift2Wrap.i_Rift2LinkA.i_rift2Core.diff.io_commit_is_ecall_S;
wire [63:0] gp  = uut.mprj.i_Rift2Wrap.i_Rift2LinkA.i_rift2Core.diff.XReg_gp;


reg is_ecall_U_reg;
reg is_ecall_M_reg;
reg is_ecall_S_reg;

always @(posedge clock or negedge RSTB) begin 
  if ( !RSTB ) begin
    is_ecall_U_reg <= 1'b0;
    is_ecall_M_reg <= 1'b0;
    is_ecall_S_reg <= 1'b0;
  end else begin
    is_ecall_U_reg <= is_ecall_U;
    is_ecall_M_reg <= is_ecall_M;
    is_ecall_S_reg <= is_ecall_S;
  end
end


always @(negedge clock or negedge RSTB) begin

	if ( is_ecall_U_reg | is_ecall_M_reg | is_ecall_S_reg ) begin
		if ( gp == 64'd1 ) begin
			$display("PASS");
			$finish;
		end
		else begin
			$display("Fail");
			$stop;
		end
	end
end






generate
	for( genvar i = 0 ; i < 16; i = i + 1 ) begin
		assign mprj_io[8+i] = uut.mprj.io_oeb[8+i] == 1'b0 ? 1'bz : io_hspi_rx_data[i];
		assign io_hspi_tx_data[i] = mprj_io[8+i];
	end
endgenerate



assign mprj_io[24] = io_hspi_rx_enable;
assign io_hspi_tx_enable = mprj_io[25];


assign hspi_clk = mprj_io[26];


assign mprj_io[27] = cpu_reset;
assign mprj_io[28] = rtc;
assign hartIsInReset = mprj_io[29];

assign mprj_io[30] = hartResetReq;
assign mprj_io[31] = hartHaltReq;
assign mprj_io[32] = msi;
assign mprj_io[33] = mti;
assign mprj_io[34] = ssi;
assign mprj_io[35] = sti;
assign mprj_io[36] = mei;
assign mprj_io[37] = sei;





endmodule
`default_nettype wire
