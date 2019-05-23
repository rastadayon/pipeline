module cu(input [5:0] opcode, func, input equal, notEqual, output reg Rtype, lw, sw, j , beq, bne, memWrite, memRead, ALUsrc, regDest, regWrite, memToReg,  output reg [2:0] ALUop, output reg [1:0] PCsrc);
	
	parameter ADD = 6'b100000, SUB = 6'b100010, AND = 6'b100100, OR = 6'b100101, SLT = 6'b101010, LW = 6'b100011, SW = 6'b101011, J = 6'b000010, BEQ = 6'b000100, BNE = 6'b000101;
	always@(opcode, func) begin
		case(opcode)
			6'b000000: begin //Rtype
				Rtype <= 1'b1; lw <= 1'b0; sw <= 1'b0; j <= 1'b0; beq <= 1'b0; bne <= 1'b0; 
				memWrite <= 1'b0; memRead <= 1'b0; PCsrc <= 2'd0; ALUsrc <= 1'b0; regDest <= 1'b1; regWrite <= 1'b1; memToReg <= 1'b0;
				case(func)
					ADD: ALUop <= 3'b000; //add
					SUB: ALUop <= 3'b001; //sub
					AND: ALUop <= 3'b010; //and
					OR: ALUop <= 3'b011; //or
					SLT: ALUop <= 3'b100; //slt
					default: ALUop <= 3'b111; //nop
				endcase
			end
			LW: begin
				ALUop <= 3'b000;
				Rtype <= 1'b0; lw <= 1'b1; sw <= 1'b0; j <= 1'b0; beq <= 1'b0; bne <= 1'b0; 
				memWrite <= 1'b0; memRead <= 1'b1; PCsrc <= 2'd0; ALUsrc <= 1'b1; regDest <= 1'b0; regWrite <= 1'b1; memToReg <= 1'b1;
			end
			SW: begin
				ALUop <= 3'b000;
				Rtype <= 1'b0; lw <= 1'b0; sw <= 1'b1; j <= 1'b0; beq <= 1'b0; bne <= 1'b0; 
				memWrite <= 1'b1; memRead <= 1'b0; PCsrc <= 2'd0; ALUsrc <= 1'b1; /*dc*/regDest <= 1'b0; regWrite <= 1'b0; /*dc*/memToReg <= 1'b0;
			end
			J: begin
				ALUop <= 3'b111;
				Rtype <= 1'b0; lw <= 1'b0; sw <= 1'b0; j <= 1'b1; beq <= 1'b0; bne <= 1'b0; 
				memWrite <= 1'b0; memRead <= 1'b0; PCsrc <= 2'd2; ALUsrc <= 1'b0; /*dc*/regDest <= 1'b0; regWrite <= 1'b0; /*dc*/memToReg <= 1'b0;
			end
			BEQ: begin
				ALUop <= 3'b111;
				Rtype <= 1'b0; lw <= 1'b0; sw <= 1'b0; j <= 1'b0; beq <= 1'b1; bne <= 1'b0; 
				memWrite <= 1'b0; memRead <= 1'b0; ALUsrc <= 1'b0; /*dc*/regDest <= 1'b0; regWrite <= 1'b0; /*dc*/memToReg <= 1'b0;
				PCsrc <= (equal)? 2'd1 : 2'd0;
			end
			BNE: begin
				ALUop <= 3'b111;
				Rtype <= 1'b0; lw <= 1'b0; sw <= 1'b0; j <= 1'b0; beq <= 1'b0; bne <= 1'b1; 
				memWrite <= 1'b0; memRead <= 1'b0; ALUsrc <= 1'b0; /*dc*/regDest <= 1'b0; regWrite <= 1'b0; /*dc*/memToReg <= 1'b0;
				PCsrc <= (notEqual)? 2'd1 : 2'd0;
			end
			default: begin
				ALUop <= 3'b111;
				Rtype <= 1'b0; lw <= 1'b0; sw <= 1'b0; j <= 1'b0; beq <= 1'b0; bne <= 1'b0; 
				memWrite <= 1'b0; memRead <= 1'b0; ALUsrc <= 1'b0; regDest <= 1'b0; regWrite <= 1'b0; memToReg <= 1'b0; PCsrc <= 2'd0; /*kolan dc*/
			end
		endcase
	end
	
endmodule
