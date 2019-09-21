module LAB5PART4(input CLOCK_50,output [6:0]HEX0);
		wire [25:0]C;
		wire [3:0]C2;
		wire E;
		register f1(CLOCK_50,C,C2,E);

		display f3(C2, HEX0);
endmodule 		

		
module register (input clk, output reg[25:0]Q, output reg[3:0]Q2, output reg E);
	always @(posedge clk)
		begin
		if (Q==26'b1111111111111111111111111111)
			begin
			Q<=0;
			E=1;
			 
			if (Q2 == 9)
				Q2<=0;
			else
			Q2<=Q2+1;
			 
		end
		else
			Q <= Q+1;
			E=0;
	end
endmodule

module display(X, HEX);
	input [3:0]X;
	output [6:0]HEX;
	wire x0,x1,x2,x3;
	assign x0 = X[0];
	assign x1 = X[1];
	assign x2 = X[2];
	assign x3 = X[3];	
	assign HEX[0] = (x2 & ~x1 & ~x0) | (~x3 & ~x2 & ~x1 & x0) ;
	assign HEX[1] = (x2 & ~x1 & x0) | (x2 & x1 & ~x0);
	assign HEX[2] = (~x2 & x1 & ~x0);
	assign HEX[3] = (~x3 & ~x2 & ~x1 & x0) | (x2 & ~x1 & ~x0) | (x2 & x1 & x0);
	assign HEX[4] = (x0) | (x2 & ~x1);
	assign HEX[5] = (~x2 & x1) | (~x3 & ~x2 & x0)| (x1 & x0);
	assign HEX[6] = (~x3 & ~x2 & ~x1) | ( x2 & x1 & x0);
endmodule 
			