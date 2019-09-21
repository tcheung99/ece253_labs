module lab3part2(SW,HEX0,HEX1, LEDR);
	input [9:0]SW;
	output [6:0]HEX0;
	output [6:0]HEX1;
	output [9:0]LEDR;
	wire z;
	wire [3:0]A;
	wire [3:0]d1;
	wire [3:0]d0;
	wire [3:0]v;
	
	assign v[0] = SW[0];
	assign v[1] = SW[1];
	assign v[2] = SW[2];
	assign v[3] = SW[3];
	
	assign z = (v[3] & v[1]) | (v[3] & v[2]);
	assign A[0] = v[0];
	assign A[1] = ~v[1];
	assign A[2] = (v[2] & v[1]);
	assign A[3] = 1'b0;
	
	assign LEDR[0] = A[0];
	assign LEDR[1] = A[1];
	assign LEDR[2] = A[2];
	assign LEDR[3] = A[3];
	
	max2to1_4bit f1(v, A, z, d0);
	
	
	assign d1[0] = z;
	
	hex_disp f2(d1, HEX1);
	hex_disp f3(d0, HEX0);
endmodule
	
	
module max2to1_4bit(V,A,z,d);
		input [3:0]V;
		input [3:0]A;
		input z;
		output [3:0]d;
		
		assign d[0] = (~z & V[0]) | (z & A[0]);
		assign d[1] = (~z & V[1]) | (z & A[1]);
		assign d[2] = (~z & V[2]) | (z & A[2]);
		assign d[3] = (~z & V[3]) | (z & A[3]);
endmodule 
	
	
module hex_disp(A, HEX);
	input [3:0]A;
	output [6:0]HEX;
	wire x0,x1,x2,x3;
	assign x0 = A[0];
	assign x1 = A[1];
	assign x2 = A[2];
	assign x3 = A[3];	
	assign HEX[0] = (x2 & ~x1 & ~x0) | (~x3 & ~x2 & ~x1 & x0) ;
	assign HEX[1] = (x2 & ~x1 & x0) | (x2 & x1 & ~x0);
	assign HEX[2] = (~x2 & x1 & ~x0);
	assign HEX[3] = (~x3 & ~x2 & ~x1 & x0) | (x2 & ~x1 & ~x0) | (x2 & x1 & x0);
	assign HEX[4] = (x0) | (x2 & ~x1);
	assign HEX[5] = (~x2 & x1) | (~x3 & ~x2 & x0)| (x1 & x0);
	assign HEX[6] = (~x3 & ~x2 & ~x1) | ( x2 & x1 & x0);
endmodule 