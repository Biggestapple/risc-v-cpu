//----------------------------------------------------------------------------------------------------------
//	FILE: 		soc_ez_tb.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	multi-Cycle Processor testbench Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.21		modified
//-----------------------------------------------------------------------------------------------------------
module soc_ez_tb();
reg	sys_clk;
reg	sys_rst_n;

wire	[7:0]	led;

wire	[31:0]	mem_wdata;
wire	[31:0]	mem_addr;
wire	mem_we;
reg		[31:0]	mem_rdata;
reg		mem_rdy;
wire	valid,halt;
wire	[3:0]	debug_port;
reg		[31:0]	mem_regi[63:0];

//Soc instance
mc_cpu	mc_cpu_inst(
	.clk		(sys_clk),
	.sys_rst_n	(sys_rst_n),
	.mem_addr	(mem_addr),			
	//In multicycle_processor rom and ram are in one unit
	.mem_wdata	(mem_wdata),
	.mem_we		(mem_we),
	.mem_rdy	(mem_rdy),
	.mem_rdata	(mem_rdata),
	
	
	.valid		(valid),
	.halt		(halt),
	//This signal will indicate that the CPU has occurred with fatal ERROR
	.debug_port	(debug_port)
	//This port will indicate the CPU's condition
);
//Clock generate
always #1        sys_clk <=	~sys_clk;
initial begin
	#0	sys_clk <=1'b0;sys_rst_n <=1'b1;
	#10	sys_rst_n <=1'b0;
	#2	sys_rst_n <=1'b1;
//Just wait to see what will happen
	
	
	#200 $finish;
end
/*
0x00400000  0xf0000293  addi x5,x0,0xffffff00        1    	li	t0,0xffffff00	#IO interface map
0x00400004  0x00000313  addi x6,x0,0                 2    	li	t1,0x00000000
0x00400008  0x40000393  addi x7,x0,0x00000400        3    	li	t2,1024
0x0040000c  0x00000e13  addi x28,x0,0                4    	li	t3,0x00000000
0x00400010  0x00f00e93  addi x29,x0,15               5    	li	t4,0x0000000f
0x00400014  0x00000313  addi x6,x0,0                 7    	li	t1,0x00000000
0x00400018  0x00230313  addi x6,x6,2                 9    	addi	t1,t1,2
0x0040001c  0xfe731ee3  bne x6,x7,0xfffffffc         10   	bne	t1,t2,WAIT
0x00400020  0x01c2a023  sw x28,0(x5)                 11   	sw	t3,0(t0)
0x00400024  0x001e0e13  addi x28,x28,1               12   	addi	t3,t3,1		#Stream Led
0x00400028  0x01de0463  beq x28,x29,0x00000008       14   	beq	t3,t4,Q
0x0040002c  0xfe9ff06f  jal x0,0xffffffe8            17   	j	LOOP
0x00400030  0x00000e13  addi x28,x0,0                19   	li	t3,0x00000000	
0x00400034  0xfe1ff06f  jal x0,0xffffffe0            20   	j	LOOP
*/
initial begin
	mem_regi[0] <= 32'h 00100293; //
	mem_regi[1] <= 32'h 00000313; //
	mem_regi[2] <= 32'h 01000393; //
	mem_regi[3] <= 32'h 00000e13; //
	mem_regi[4] <= 32'h 00f00e93; //
	mem_regi[5] <= 32'h 00000313; //
	mem_regi[6] <= 32'h 00230313; //
	mem_regi[7] <= 32'h fe731ee3; //
	mem_regi[8] <= 32'h 01c2a023; //
	mem_regi[9] <= 32'h 001e0e13; //
	mem_regi[10] <= 32'h 01de0463; //
	mem_regi[11] <= 32'h fe9ff06f; //
	mem_regi[12] <= 32'h 00000e13; //
	mem_regi[13] <= 32'h fe1ff06f; //
end
/*
always @(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n) begin
			rom_rdata <='d0;
			rom_rdy <=1'b0;
		end
	else begin
		rom_rdy<=~rom_rdy;
		if(~rom_rdy)		//If not ready then changing
			rom_rdata <=rom[(rom_addr -32'h0040_0000) >>2];
	end
*/
always @(posedge sys_clk or negedge sys_rst_n)
	if(!sys_rst_n) begin
			mem_rdata <='d0;
			mem_rdy <=1'b0;
		end
	else begin
		mem_rdy <=1'b0;
		if(valid) begin
			mem_rdata <=mem_regi[(mem_addr -32'h0040_0000) >>2];
			mem_rdy <=1'b1;
		end
		if(mem_we) begin
			mem_regi[mem_addr] <=mem_wdata;
		end
	end
endmodule