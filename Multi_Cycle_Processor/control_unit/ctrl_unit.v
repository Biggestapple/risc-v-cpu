//----------------------------------------------------------------------------------------------------------
//	FILE: 		ctrl_unit.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Multi-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.16			create
//-----------------------------------------------------------------------------------------------------------
module ctrl(
	input		clk,
	input		sys_rst_n,

	input	[31:0]		instr,
	input		zero,
	output		pcWrite,
	output	reg	adrSrc,
	output	reg	mem_we,
	output	reg	irWrite,
	
	output	reg	[1:0]	resultSrc,
	output	[2:0]		aluCtr,
	output	[1:0]		comCtr,
	output	reg	[1:0]	aluSrcA,
	output	reg	[1:0]	aluSrcB,
	
	output	[2:0]		immSrc,
	output	reg			reg_w,
	
	input	mem_rdy,
	output	reg		valid,
	output	halt,
	output	reg	[2:0]	debug_port

);	
wire	[6:0]	op;
wire	[2:0]	funct3;
wire	[6:0]	funct7;

assign op =instr[6:0];
assign funct3 =instr[14:12];
assign funct7 =instr[31:25];

localparam	LW	=7'b000_0011;
localparam	SW	=7'b010_0011;
localparam	RTYPE	=7'b011_0011;
localparam	BTYPE	=7'b110_0011;
localparam	ITYPE 	=7'b001_0011;
localparam	UTYPE	=7'b011_0111;
localparam	JAL	=7'b110_1111;
localparam	JALR =7'b110_0111;



endmodule