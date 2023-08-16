//----------------------------------------------------------------------------------------------------------
//	FILE: 		ctrl_unit.v
// 	AUTHOR:		Biggest_apple
// 	
//	ABSTRACT:	Single-Cycle Processor Unit
// 	KEYWORDS:	fpga, basic module，signal process
// 
// 	MODIFICATION HISTORY:
//	$Log$
//			Biggest_apple 		2023.8.12			create
//								2023.8.14			Adding several instructions
//-----------------------------------------------------------------------------------------------------------
module ctrl(
	input	[31:0]		instr,
	input	zero,				//For jp--
	output	pcSrc,
	output	reg	[1:0]	resultSrc,
	output	reg		mem_w,
	output	reg	[2:0]	aluCtr,
	output	reg	[1:0]	comCtr,
	output	reg		aluSrc,
	output	reg	[2:0]	immSrc,
	output	reg	reg_w

);								//Totally combine-logic that means it cannot run fast --5mhz
wire	[6:0]	op;
wire	[2:0]	funct3;
wire	[6:0]	funct7;

assign op =instr[6:0];
assign funct3 =instr[14:12];
assign funct7 =instr[31:25];

localparam	LW	=7'b000_0011;
localparam	SW	=7'b010_0011;
localparam	RTYPE	=7'b011_0011;
localparam	BTYPE	=7'b110_0011;
localparam	ITYPE 	=7'b001_0011;
localparam	UTYPE	=7'b011_0111;
localparam	JAL	=7'b110_1111;
localparam	JALR =7'b110_0111;
	
reg	jump;
reg	branch;					//Avoid logic error
reg	[1:0]	aluOp;			//Used for R-type instruction

always @(*) begin
	case(op)
		LW: begin			//Load data to the register_file
			reg_w =1'b1;
			immSrc =3'b000;
			aluSrc =1'b1;
			mem_w =1'b0;
			resultSrc =2'b01;
			branch =1'b0;
			jump =1'b0;
			aluOp =2'b00;	//Fixed formula FOR "lw" and "sw" 
			comCtr =2'b00;
		end
		SW: begin
			reg_w =1'b0;
			immSrc =3'b001;
			aluSrc =1'b1;
			mem_w =1'b1;
			resultSrc =2'b00;
			branch =1'b0;
			jump =1'b0;
			aluOp =2'b00;
			comCtr =2'b00;
		end
		RTYPE: begin
			reg_w =1'b1;
			immSrc =3'b000;
			aluSrc =1'b0;
			mem_w =1'b0;
			resultSrc =2'b00;
			branch =1'b0;
			jump =1'b0;
			aluOp =2'b10;	//Alu enables eg:Add,Sub...
			comCtr =2'b00;
		end
		BTYPE: begin
			reg_w =1'b0;
			immSrc =3'b010;
			aluSrc =1'b0;
			mem_w =1'b0;
			resultSrc =2'b00;
			branch =1'b1;
			jump =1'b0;
			aluOp =2'b01;						//Decide by beq, bne ...
			comCtr =(funct3 ==3'b000)? 2'b00:	//beq
					(funct3 ==3'b001)? 2'b01:	//bne
					(funct3 ==3'b100)? 2'b10:	//blt
					(funct3 ==3'b101)? 2'b11:	//bge
											2'b00;
		end
		ITYPE: begin
			reg_w =1'b1;
			immSrc =3'b000;
			aluSrc =1'b1;
			mem_w =1'b0;
			resultSrc =2'b00;
			branch =1'b0;
			jump =1'b0;
			aluOp =2'b10;	//Alu enables eg:Addi,Subi...
			comCtr =2'b00;
		end
		JAL: begin
			reg_w =1'b1;
			immSrc =3'b011;
			aluSrc =1'b0;
			mem_w =1'b0;
			resultSrc =2'b10;
			branch =1'b0;
			jump =1'b1;
			aluOp =2'b00;
			comCtr =2'b00;
		end
		JALR:begin
			reg_w =1'b1;
			immSrc =3'b000;
			aluSrc =1'b1;
			mem_w =1'b0;
			resultSrc =2'b10;
			branch =1'b0;
			jump =1'b1;
			aluOp =2'b00;	//Default:Add
			comCtr =2'b00;
		end
		UTYPE: begin
			reg_w =1'b1;		//Note here...
			immSrc =3'b100;		
			aluSrc =1'b0;
			mem_w =1'b0;
			resultSrc =2'b11;
			branch =1'b0;
			jump =1'b0;
			aluOp =2'b00;
			comCtr =2'b00;
		end
		default:begin			//Error--
			reg_w =1'b0;
			immSrc =3'b000;
			aluSrc =1'b0;
			mem_w =1'b0;
			resultSrc =2'b00;
			branch =1'b0;
			jump =1'b0;
			aluOp =2'b00;
			comCtr =2'b00;
		end
	endcase
end
							//Alu decoder

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

//Jump instruction logic
assign pcSrc =(zero &&branch) ^jump;
/*Support instruction as followed*/
/*
	lw
	sw
	add
	sub
	and
	or
	slt
	beq
	jal
	addi
	subi
	andi
	ori
	slti
	li (load imm_32) :fake..
	
	lui,j,jr,shift instrictions... not support now
	The instruction that must be added:
	bne 
	bge 
	jalr
	blt
	lui
	
*/
endmodule