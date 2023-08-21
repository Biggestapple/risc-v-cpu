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
//								2023.8.17			continue
//								2023.8.21			continue
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
	output	reg	[2:0]	aluCtr,
	output	reg	[1:0]	comCtr,
	output	reg	[1:0]	aluSrcA,
	output	reg	[1:0]	aluSrcB,
	
	output	reg	[2:0]	immSrc,
	output	reg			reg_w,
	
	input	mem_rdy,
	output	reg		valid,
	output	reg		halt,
	output	reg	[3:0]	debug_port

);	
wire	[6:0]	op;
wire	[2:0]	funct3;
wire	[6:0]	funct7;
wire	pcWrite_w;
reg		pcWrite_a,pcWrite_f;

reg		[4:0]		state;
reg		[1:0]		aluOp;
reg		pcUpdate;
reg		branch;

assign op =instr[6:0];
assign funct3 =instr[14:12];
assign funct7 =instr[31:25];

localparam	LW	=7'b000_0011;
localparam	SW	=7'b010_0011;
localparam	RTYPE	=7'b011_0011;
localparam	BTYPE	=7'b110_0011;
localparam	ITYPE 	=7'b001_0011;
localparam	UTYPE	=7'b011_0111;
localparam	AUIPC	=7'b001_0111;
localparam	JAL	=7'b110_1111;
localparam	JALR =7'b110_0111;

//FSM (MOORE TYPE) state define
localparam	IDLE 		=5'd1;
localparam	FETCH 		=5'd2;
localparam	DECODE		=5'd3;
localparam	MEM_ADR		=5'd4;
localparam	MEM_RD		=5'd5;
localparam	MEM_WB		=5'd6;
localparam	MEM_WRITE 	=5'd7;
localparam	EXECUTE_R 	=5'd8;
localparam	EXECUTE_B 	=5'd9;
localparam	EXECUTE_I 	=5'd10;
localparam	EXECUTE_JAL =5'd11;
localparam	ALU_WB 		=5'd12;
localparam	EXECUTE_U	=5'd13;
localparam	EXECUTE_AUIP=5'd14;
localparam	MEM_RRDY	=5'd15;
localparam	MEM_DY		=5'd16;

//FSM Main body
always @(posedge clk or negedge sys_rst_n)
	if(!sys_rst_n) begin
		//Lots of registers wait to be inited :)
		state <=IDLE;
		pcUpdate <=1'b0;
		branch <=1'b0;
		adrSrc <=1'b0;
		mem_we <=1'b0;
		irWrite <=1'b0;
		resultSrc <=2'b00;
		comCtr <=2'b00;
		aluSrcA <=2'b00;
		aluSrcB <=2'b00;
		reg_w <=1'b0;
		valid <=1'b0;
		debug_port <=4'h0;
		halt <=1'b0;
		//1'b1 means the cpu has halted
	end
	else begin
		reg_w <=1'b0;
		pcUpdate <=1'b0;
		mem_we <=1'b0;
		branch <=1'b0;
		irWrite <=1'b0;
		case(state)
			IDLE:
				if(!halt)
					state <=FETCH;
				else
					state <=state;
					//Avoid latch 
			FETCH:begin
				//Fetch the data from memory at the address hold on pc
				valid <=1'b1;
				//CPU is stable
				adrSrc 	<=1'b0;
				aluSrcA <=2'b00;
				aluSrcB <=2'b10;
				// +'d4
				aluOp <=2'b00;
				resultSrc <=2'b10;
				// Not delay one cycle
				pcUpdate <=1'b1;
				state <=MEM_RRDY;
			end
			MEM_RRDY:begin
				branch <=1'b0;
				//No more why :) 
				if(mem_rdy) begin
					valid <=1'b0;
					state <=MEM_DY;
					irWrite <=1'b1;
				end
				else
					state <=state;
			end
			MEM_DY:
				state <=DECODE;
			DECODE:begin
				//Caculate the target address
				aluSrcA <=2'b01;
				aluSrcB <=2'b01;
				aluOp <=2'b00;
				case(funct3)
					3'b000:
						comCtr <=2'b00;		//beq
					3'b001:
						comCtr <=2'b01;		//bne
					3'b100:
						comCtr <=2'b10;		//blt
					3'b101:
						comCtr <=2'b11;		//bge
					default:
						comCtr <=2'b00;
				endcase
				case(op)
					LW,SW:
						state <=MEM_ADR;
					RTYPE:
						state <=EXECUTE_R;
					BTYPE:
						state <=EXECUTE_B;
					JAL:
						state <=EXECUTE_JAL;
					ITYPE:
						state <=EXECUTE_I;
					UTYPE:
						state <=EXECUTE_U;
					AUIPC:
						state <=EXECUTE_AUIP;
					default:begin
						halt <=1'b1;
						state <=IDLE;
						debug_port <=4'h1;
						//OP decodes Error--
					end
				endcase
			end
			EXECUTE_U:begin
			
				aluSrcA <=2'b11;
				//srcA =32'd0
				aluSrcB <=2'b01;
				aluOp <=2'b00;
				state <=ALU_WB;
				resultSrc <=2'b00;
			end
			EXECUTE_JAL:begin
				aluSrcA <=2'b01;
				aluSrcB <=2'b10;
				resultSrc <=2'b00;
				aluOp <=2'b00;
				
				//Load the target address
				pcUpdate <=1'b1;
				state <=ALU_WB;
			end
			EXECUTE_AUIP:begin
				aluSrcA <=2'b01;
				//From PC
				//srcA =32'd0
				aluSrcB <=2'b01;
				aluOp <=2'b00;
				resultSrc <=2'b00;
				state <=ALU_WB;
			end
			EXECUTE_I:begin
				aluSrcA <=2'b10;
				aluSrcB <=2'b01;
				aluOp <=2'b10;
				state <=ALU_WB;
			end
			EXECUTE_R:begin
				aluSrcA <=2'b10;
				aluSrcB <=2'b00;
				aluOp <=2'b10;
				state <=ALU_WB;
			end
			EXECUTE_B:begin
				aluSrcA <=2'b10;
				aluSrcB <=2'b00;
				branch <=1'b1;
				resultSrc <=2'b00;
				state <=FETCH;
			end
			ALU_WB:begin
				resultSrc <=2'b00;
				reg_w <=1'b1;
				state <=FETCH;
			end
			MEM_WRITE:begin
				resultSrc <=2'b00;
				//From aluOut
				adrSrc <=1'b1;
				mem_we <=1'b1;
				if(mem_rdy)
					state <=FETCH;
				else 
					state <=state;
			end
			MEM_ADR:begin
				aluSrcA <=2'b10;
				aluSrcB <=2'b01;
				//From immExt
				aluOp <=2'b00;
				if(op ==LW)
					state <=MEM_RD;
				else 
					state <=MEM_WRITE;
			end
			MEM_RD: begin
				resultSrc <=2'b00;
				//From aluOut
				adrSrc <=1'b1;
				if(mem_rdy)
					state <=MEM_WB;
				else 
					state <=state;
			end
			MEM_WB:begin
				resultSrc <=2'b01;
				reg_w <=1'b1;
				state <=FETCH;
				//Done lw instruction
			end
		endcase
	end

always @(*) begin
	case(aluOp)
		2'b00:
			aluCtr =3'b000;
		2'b01:
			aluCtr =3'b001;
		2'b10:begin
			if(funct3 ==3'b000 &&(({op[5],funct7[5]} ==2'b00)
								||({op[5],funct7[5]} ==2'b01)
								||({op[5],funct7[5]} ==2'b10)))
				aluCtr=3'b000;	//Add
			else if(funct3 ==3'b000 &&(({op[5],funct7[5]} ==2'b11)))
				aluCtr=3'b001;	//Sub
			else if(funct3 ==3'b010)
				aluCtr=3'b101;	//Slt
			else if(funct3 ==3'b110)
				aluCtr=3'b011;	//Or
			else if(funct3 ==3'b111)
				aluCtr=3'b010;	//And
			else
				aluCtr=3'b111;	//Error--
		end
		default:
			aluCtr =3'b111;		//Error--
	endcase
end
//immSrc Decoder...
always @(*) begin
	case(op)
		LW: 
			immSrc =3'b000;
		SW:
			immSrc =3'b001;
		RTYPE:
			immSrc =3'b000;
		BTYPE: 
			immSrc =3'b010;
		ITYPE:
			immSrc =3'b000;
		JAL:
			immSrc =3'b011;
		JALR:
			immSrc =3'b000;
		UTYPE,AUIPC:			//Note here...
			immSrc =3'b100;		
		default:
			immSrc =3'b000;
	endcase
end

//Jump instruction logic
assign pcWrite =(zero && branch)^pcUpdate;
//May be posedge ?
/*
always @(posedge clk or sys_rst_n)
	if(!sys_rst_n) begin
		pcWrite_f <=1'b0;
		pcWrite_a <=1'b0;
	end
	else begin
		pcWrite_f <=pcWrite_w;
		pcWrite_a <=pcWrite_f;
	end
assign pcWrite =(~pcWrite_a && pcWrite_f);
*/
endmodule