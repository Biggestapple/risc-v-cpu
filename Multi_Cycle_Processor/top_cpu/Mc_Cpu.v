//----------------------------------------------------------------------------------------------------------
//	FILE: 		Mc_cpu.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Top wire connection
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.16			create
//-----------------------------------------------------------------------------------------------------------
module mc_cpu(
	input		clk,
	input		sys_rst_n,
	
	output		[31:0]		mem_addr,			
	//In multicycle_processor rom and ram are in one unit
	output		[31:0]		mem_wdata,
	output		mem_we,
	input		mem_rdy,
	input		[31:0]		mem_rdata,
	
	
	output		valid,
	output		halt,
	//This signal will indicate that the CPU has occurred with fatal ERROR
	output		[3:0]		debug_port
	//This port will indicate the CPU's condition
);
//The Soc internal nonarchitectural register declare//
reg		[31:0]		Oldpc;
reg		[31:0]		instr;
reg		[31:0]		pc;
reg		[31:0]		srcA_reg,srcB_reg;
reg		[31:0]		aluOut;
reg		[31:0]		mem_data;
reg		zero_regi;
//The Soc internal connection						//
wire	irWrite,adrSrc;

wire	zero;
wire	[1:0]		resultSrc;
wire	[2:0]		aluCtr;
wire	[1:0]		comCtr;
wire	[1:0]		aluSrcA,aluSrcB;
wire	[2:0]		immSrc;
wire	reg_w;

wire	[31:0]		immExt;

wire	[31:0]		srcA,srcB;
wire	[31:0]		aluRes;

wire	[31:0]		pcNext;
wire	pcWrite;

wire	[31:0]		rd1;
wire	[31:0]		rd2;
wire	[31:0]		wd;
wire	[4:0]		a1,a2,a3;

wire	[31:0]		result;
//---------PRO_START_ADDR----//
localparam	PC_START =32'h0040_0000;
//---------------------------//

assign a1 =instr[19:15];
assign a2 =instr[24:20];
assign a3 =instr[11:7];

assign pcNext =result;
assign wd =result;
assign mem_wdata =srcB_reg;
//---------PART A-----------//
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n) begin
		instr <='d0;
		Oldpc <='d0;
		srcA_reg <='d0;
		srcB_reg <='d0;
		aluOut <='d0;
		mem_data <='d0;
		zero_regi <=1'b0;
	end
	else begin
		srcA_reg <=rd1;
		srcB_reg <=rd2;
		aluOut <=aluRes;
		mem_data <=mem_rdata;
		zero_regi <=zero;
		if(irWrite) begin
			instr <=mem_rdata;
			Oldpc <=pc;
		end
	end
//---------------------------//
//---------PART B-----------//
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n)
		pc <=PC_START;
		//The pc_offset 0x0000_0000
	else if(pcWrite)
		pc <=pcNext;
	else
		pc <=pc;
//---------------------------//
RegFile	RegFile_dut(
	.clk		(clk),
	.sys_rst_n	(sys_rst_n),
	
	.a1			(a1),					//Address read 	Port 1
	.a2			(a2),					//Address read 	Port 2
	.a3			(a3),					//Address write	Port 3
	
	.wd			(wd),					//Write data port
	.we			(reg_w),				//Write data enable 1:enable 0:disable -->In order to ensure timing quite stupid
	
	.rd1		(rd1),					//Read port 1 the same as below
	.rd2		(rd2)
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
//Meanwhile this unit will become quite complex.
ctrl ctrl_dut(
	.clk		(clk),
	.sys_rst_n	(sys_rst_n),

	.instr		(instr),
	.zero		(zero_regi),
	.pcWrite	(pcWrite),
	.adrSrc		(adrSrc),
	.mem_we		(mem_we),
	.irWrite	(irWrite),
	
	.resultSrc	(resultSrc),
	.aluCtr		(aluCtr),
	.comCtr		(comCtr),
	.aluSrcA	(aluSrcA),
	.aluSrcB	(aluSrcB),
	
	.immSrc		(immSrc),
	.reg_w		(reg_w),
	
	.mem_rdy	(mem_rdy),
	.valid		(valid),
	.halt		(halt),
	.debug_port	(debug_port)

);	
ext	ext_dut(
	.instr		(instr),
	
	.immSrc		(immSrc),
	
	.immExt		(immExt)
);
//-------MUX connection------//
assign srcA =	(aluSrcA ==2'b10)?srcA_reg:
				(aluSrcA ==2'b01)?Oldpc:
				(aluSrcA ==2'b00)?pc:
										'd0;
assign srcB =	(aluSrcB ==2'b00)?srcB_reg:
				(aluSrcB ==2'b01)?immExt:
				(aluSrcB ==2'b10)?'d4:
				//Note: pcNext =pc+4
										'd0;
assign result =	(resultSrc ==2'b00)?aluOut:
				//Jsut one clock delay result...
				(resultSrc ==2'b01)?mem_data:
				(resultSrc ==2'b10)?aluRes:
										'd0;
assign mem_addr	=(adrSrc ==1'b0)?pc:result;
//---------------------------//
endmodule