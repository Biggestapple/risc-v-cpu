//----------------------------------------------------------------------------------------------------------
//	FILE: 		ext.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Multi-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.12			create
//													Add:U-tpye
//-----------------------------------------------------------------------------------------------------------
module ext(
	input	[31:0]		instr,
	
	input	[2:0]		immSrc,
	
	output	[31:0]		immExt
);

											//The following combine-logic just copy from Table 7.5
assign immExt =	(immSrc ==3'b000) ?{{20{instr[31]}},instr[31:20]}:									//I-tpye
				(immSrc ==3'b001) ?{{20{instr[31]}},instr[31:25],instr[11:7]}:						//S-type
				(immSrc ==3'b010) ?{{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0} -'d4:	//B-type
				(immSrc ==3'b011) ?{{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0}:		//J-type
				(immSrc ==3'b100) ?{instr[31:12],12'b0}:'d0;										//U-type


endmodule