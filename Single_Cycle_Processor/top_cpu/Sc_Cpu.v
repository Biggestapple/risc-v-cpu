//----------------------------------------------------------------------------------------------------------
//	FILE: 		Sc_cpu.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Top wire connection
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.12			create
//								2023.8.13			continue:Too many combine-logic :(
//								2023.8.14			more instruction
//-----------------------------------------------------------------------------------------------------------
module sc_cpu(
	input		clk,
	input		sys_rst_n,
	
	output	[31:0]	rom_addr,
	input	[31:0]	rom_rdata,
	input	rom_rdy,
	
	input	[31:0]	mem_rdata,
	output	[31:0]	mem_addr,
	output	[31:0]	mem_wdata,
	output	mem_we
);
//The Soc internal connection//
wire	[31:0]		instr;
wire	zero;
wire	pcSrc;
wire	[1:0]		resultSrc;
wire	mem_w;
wire	[2:0]		aluCtr;
wire	[1:0]		comCtr;
wire	aluSrc;
wire	[2:0]		immSrc;
wire	reg_w;

wire	[31:0]		immExt;

wire	[31:0]		srcA,srcB;
wire	[31:0]		aluRes;

wire	[31:0]		pc;
wire	[31:0]		pcPlus4;

wire	[31:0]		rd2;
wire	[31:0]		wd;
wire	[4:0]		a1,a2,a3;

wire	[31:0]		result;
//---------------------------//
assign instr =rom_rdata;
assign mem_addr =aluRes;
assign mem_wdata =rd2;
assign mem_we =mem_w;
assign rom_addr =pc;

assign a1 =instr[19:15];
assign a2 =instr[24:20];
assign a3 =instr[11:7];

assign wd =result;
//---------------------------//
RegFile	RegFile_dut(
	.clk		(clk),
	.sys_rst_n	(sys_rst_n),
	
	.a1			(a1),					//Address read 	Port 1
	.a2			(a2),					//Address read 	Port 2
	.a3			(a3),					//Address write	Port 3
	
	.wd			(wd),					//Write data port
	.we			(reg_w &&(~rom_rdy)),	//Write data enable 1:enable 0:disable -->In order to ensure timing quite stupid
	
	.rd1		(srcA),					//Read port 1 the same as below
	.rd2		(rd2)
);

pc	pc_dut(
	.clk		(clk),
	.sys_rst_n	(sys_rst_n),
	
	.pcSrc		(pcSrc),
	.pc			(pc),
	.pcPlus4	(pcPlus4),
	
	.immExt		(immExt),
	.rom_rdy	(rom_rdy)
);


alu alu_dut(
	.srcA		(srcA),
	.srcB		(srcB),
	
	.aluCtr		(aluCtr),
	
	.aluRes		(aluRes)
);

compu compu_dut(
	.srcA		(srcA),
	.srcB		(srcB),
	
	.comCtr		(comCtr),
	.zero		(zero)
);

ctrl ctrl_dut(
	.instr		(instr),
	.zero		(zero),				//For jp--
	.pcSrc		(pcSrc),
	.resultSrc	(resultSrc),
	.mem_w		(mem_w),
	.aluCtr		(aluCtr),
	.comCtr		(comCtr),
	.aluSrc		(aluSrc),
	.immSrc		(immSrc),
	.reg_w		(reg_w)

);	
ext	ext_dut(
	.instr		(instr),
	
	.immSrc		(immSrc),
	
	.immExt		(immExt)
);
//-------MUX connection------//
assign srcB =(aluSrc ==1'b0)? rd2:immExt;
assign result =	(resultSrc ==2'b00)? aluRes:
				(resultSrc ==2'b01)? mem_rdata:
				(resultSrc ==2'b10)? pcPlus4:immExt;	//Error ??
//---------------------------//
endmodule