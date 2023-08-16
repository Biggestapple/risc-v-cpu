//----------------------------------------------------------------------------------------------------------
//	FILE: 		alu.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Single-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.12			create
//													Add:Wait external rom ready
//-----------------------------------------------------------------------------------------------------------
module	pc(
	input	clk,
	input	sys_rst_n,
	
	input	pcSrc,
	output	[31:0]		pc,
	
	input	[31:0]		immExt,
	
	input	rom_rdy,
	
	output	[31:0]		pcPlus4
);
wire	[31:0]	pcNext;
reg		[31:0]	pcreg;
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n)
		pcreg <=32'h0040_0000;
	else  if(rom_rdy)
		pcreg <=pcNext;
	else	
		pcreg <=pcreg;

assign pc =pcreg;
assign pcPlus4 =pc +'d4;
assign pcNext =(pcSrc ==1'b0) ?pcPlus4:(pc +immExt);
endmodule