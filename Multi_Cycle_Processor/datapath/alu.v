//----------------------------------------------------------------------------------------------------------
//	FILE: 		alu.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Multi-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.12			create
//-----------------------------------------------------------------------------------------------------------
module alu(
	input	[31:0]			srcA,
	input	[31:0]			srcB,
	
	input	[2:0]			aluCtr,
	
	output	reg	[31:0]		aluRes
);

always @(*) begin
	case(aluCtr)
			3'b000:aluRes =srcA +srcB;			//Add
			3'b001:aluRes =srcA -srcB;			//Sub
			3'b010:aluRes =srcA&srcB;			//AND
			3'b011:aluRes =srcA|srcB;
			3'b101:aluRes ={32{(srcB >srcA)}};	//SLT:if less than instruction(Signed...)
		default:aluRes ='d0;
	endcase
end

endmodule