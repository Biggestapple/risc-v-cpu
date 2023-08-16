//----------------------------------------------------------------------------------------------------------
//	FILE: 		RefFile.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Multi-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.12			create
//-----------------------------------------------------------------------------------------------------------
module RegFile(
	input			clk,
	input			sys_rst_n,
	
	input	[4:0]	a1,						//Address read 	Port 1
	input	[4:0]	a2,						//Address read 	Port 2
	input	[4:0]	a3,						//Address write	Port 3
	
	input	[31:0]	wd,						//Write data port
	input	we,								//Write data enable 1:enable 0:disable
	
	output	[31:0]	rd1,					//Read port 1 the same as below
	output	[31:0]	rd2
);
											//In RV32I architecture the register file unit holds 
											// x0 to x31 which x0 is hardwired to 0
reg	[31:0]	gRegi[31:0];
integer	index;
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n)
		for(index =0;index <32;index =index +1)
			gRegi[index] <='d0;
	else if(we)
		gRegi[a3] <=wd;

											//Assign the register value
assign rd1 =(a1 ==5'b0000_0)? 'd0:gRegi[a1];//Shadow register x0_re
assign rd2 =(a2 ==5'b0000_0)? 'd0:gRegi[a2];

											
endmodule