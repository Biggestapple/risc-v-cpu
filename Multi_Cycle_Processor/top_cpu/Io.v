//----------------------------------------------------------------------------------------------------------
//	FILE: 		Io.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	The IO interface unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.13			create
//-----------------------------------------------------------------------------------------------------------
module IO(
	input		clk,
	input		sys_rst_n,
	
	output		[7:0]	led,		//This IO interface is just for test
	input		[31:0]	mem_addr,
	output	reg	[31:0]	mem_rdata,
	input		[31:0]	mem_wdata,
	input		mem_we
);
reg		[7:0]	ram[0:127];
//--------IO MAPPING---------//
									//From 0xffff_ff00 to oxffff_ffff
reg		[7:0]	io_reg[0:31];		//Output port
integer	index;						//Actually just 0xffff_ff00 to 0xffff_ff1f is valid
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n)
		for(index =0;index <32;index =index+1)
			io_reg[index]	<='d0;
	else if(mem_addr[31:8] == 24'hffff_ff && mem_we) begin
		io_reg[mem_addr[4:0]] <= mem_wdata[31:24];
		io_reg[mem_addr[4:0] +1] <= mem_wdata[23:16];
		io_reg[mem_addr[4:0] +2] <= mem_wdata[15:8];
		io_reg[mem_addr[4:0] +3] <= mem_wdata[7:0];
	end

assign led =io_reg[3];				//0xffff_ff00 --> 8bits led
//---------------------------//
//----------Ram--------------//
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n) begin
		mem_rdata <='d0;
			for(index =0;index <128;index =index+1)
				ram[index] <='d0;
		end
	else if(mem_we && mem_addr <'d128) begin
		ram[mem_addr] 	<=mem_wdata[31:24];
		ram[mem_addr+1] <=mem_wdata[23:16];
		ram[mem_addr+2] <=mem_wdata[15:8];
		ram[mem_addr+3] <=mem_wdata[7:0];
	end
	else if (mem_addr <'d128)begin
		mem_rdata[31:24]<=ram[mem_addr];
		mem_rdata[23:16]<=ram[mem_addr+1];
		mem_rdata[15:8]<=ram[mem_addr+2];
		mem_rdata[7:0]<=ram[mem_addr+3];
	end
endmodule