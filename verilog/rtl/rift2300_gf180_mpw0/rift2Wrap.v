module rift2Wrap(

`ifdef USE_POWER_PINS
    inout vdd,      // User area 5.0V supply
    inout vss,      // User area ground
`endif


    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    input  [63:0] la_data_in,
    output [63:0] la_data_out,
    input  [63:0] la_oenb,

    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,


    inout [`MPRJ_IO_PADS-10:0] analog_io,

    input   user_clock2,

    output [2:0] user_irq


);

assign wbs_ack_o = 1'b0;
assign wbs_dat_o = 32'b0;
assign user_irq  = 3'b0;
assign la_data_out = 64'b0;

wire clock;
wire reset;

wire hartIsInReset;
wire hartResetReq;
wire hartHaltReq;

wire msi;
wire mti;
wire ssi;
wire sti;
wire mei;
wire sei;

wire io_hspi_oen;
wire io_hspi_rx_enable;

wire [15:0] io_hspi_rx_data;
wire        io_hspi_tx_enable;
wire [15:0] io_hspi_tx_data;

assign clock = user_clock2;




Rift2LinkA i_Rift2LinkA(

  .clock(clock),
  .reset(reset),

  .io_rtc_clock(io_in[28]),

  .io_dm_hartIsInReset(hartIsInReset),
  .io_dm_hartResetReq(hartResetReq),
  .io_dm_hartHaltReq(hartHaltReq),

  .io_aclint_msi(msi),
  .io_aclint_mti(mti),
  .io_aclint_ssi(ssi),
  .io_aclint_sti(sti),

  .io_plic_mei(mei),
  .io_plic_sei(sei),

  .io_hspi_clk(io_out[26]),
  
  .io_hspi_rx_enable(io_hspi_rx_enable),
  .io_hspi_rx_data(io_hspi_rx_data),
  .io_hspi_tx_enable(io_hspi_tx_enable),
  .io_hspi_tx_data(io_hspi_tx_data),
  .io_hspi_oen(io_hspi_oen)
);



assign io_oeb[7:0] = 8'b0;
assign io_out[7:0] = 8'b0;


// 0 is output; set to 1 for input
assign io_oeb[23:8] = {16{io_hspi_oen}};
assign io_hspi_rx_data[15:0] = io_hspi_oen ? io_in[23:8] : 16'b0;
assign io_out[23:8] = io_hspi_tx_data[15:0];

//rx is input 
assign io_oeb[24] = 1'b1;
assign io_hspi_rx_enable = io_in[24];
assign io_out[24] = 1'b0;

//tx is output
assign io_oeb[25] = 1'b0;
assign io_out[25] = io_hspi_tx_enable;
//assign DontCare = io_in[25]

//hspi_clk is output now
assign io_oeb[26] = 1'b0;
// assign io_out[26] = 1'b0;

// cpu_reset
assign io_out[27] = 1'b0;
assign io_oeb[27] = 1'b1;
assign reset = io_in[27];

//rtc
assign io_out[28] = 1'b0;
assign io_oeb[28] = 1'b1;
// assign io_rtc_clock = io_in[28];


//hartIsInReset output
assign io_out[29] = hartIsInReset;
assign io_oeb[29] = 1'b0;
// assign Dontcare = io_in[29];

//hartResetReq input
assign io_out[30] = 1'b0;
assign io_oeb[30] = 1'b1;
assign hartResetReq = io_in[30];

//hartHaltReq input
assign io_out[31] = 1'b0;
assign io_oeb[31] = 1'b1;
assign hartHaltReq =io_in[31];

//msi input
assign io_out[32] = 1'b0;
assign io_oeb[32] = 1'b1;
assign msi = io_in[32];

//mti input 
assign io_out[33] = 1'b0;
assign io_oeb[33] = 1'b1;
assign mti = io_in[33];

//ssi input
assign io_out[34] = 1'b0;
assign io_oeb[34] = 1'b1;
assign ssi = io_in[34];

//sti input
assign io_out[35] = 1'b0;
assign io_oeb[35] = 1'b1;
assign sti = io_in[35];

//mei input
assign io_out[36] = 1'b0;
assign io_oeb[36] = 1'b1;
assign mei = io_in[36];

//sei input
assign io_out[37] = 1'b0;
assign io_oeb[37] = 1'b1;
assign sei = io_in[37];


endmodule