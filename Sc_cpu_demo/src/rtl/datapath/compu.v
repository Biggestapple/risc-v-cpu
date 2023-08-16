//----------------------------------------------------------------------------------------------------------
//	FILE: 		compu.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Single-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.14			create
//-----------------------------------------------------------------------------------------------------------
module compu(
	input	[31:0]			srcA,
	input	[31:0]			srcB,
	
	input	[1:0]			comCtr,
	output	zero
);

assign zero	=	(comCtr ==2'b00)? (srcA ==srcB):
				(comCtr ==2'b01)? (srcA !=srcB):
				(comCtr ==2'b10)? (srcA <srcB):(srcA >=srcB);
endmodule