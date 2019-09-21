module lab3_part4(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	input [9:0]SW;
	output[6:0]HEX0;
	output[6:0]HEX1;
	output[6:0]HEX3;
	output[6:0]HEX5;
	output[9:0]LEDR;
	wire [3:0]a;
	wire [3:0]b;
	wire cin, cout, s1, s2, s3, c1, c2, c3;
	assign a = SW[7:4] ;
	assign b = SW[3:0];
	assign cin = SW[8];

	assign LEDR[9] = (a[3] & a[2]) | (a[3] & a[1]) | (b[3] & b[2]) | (b[3] & b[1]);
	
	subadder f1(a[0], b[0], cin, s0, c1);
	subadder f2(a[1], b[1], c1, s1, c2);
	subadder f3(a[2], b[2], c2, s2, c3);
	subadder f4(a[3], b[3], c3, s3, cout);
	assign LEDR[0] = s0;
	assign LEDR[1] = s1;
	assign LEDR[2] = s2;
	assign LEDR[3] = s3;
	assign LEDR[4] = cout;
	
	wire [4:0]s;
	
	assign s[0] = s0;
	assign s[1] = s1;
	assign s[2] = s2;
	assign s[3] = s3;
	assign s[4] = cout;
	
	lab3part2 f5(s, HEX0, HEX1);
	
	hex_disp f6(a, HEX5);
	hex_disp f7(b, HEX3);

endmodule

module lab3part2(S,HEX0,HEX1);
	input [4:0]S;
	output [6:0]HEX0;
	output [6:0]HEX1;

	wire z;
	wire [3:0]A;
	wire [3:0]d1;
	wire [3:0]d0;
	wire [3:0]v;
	
	assign v[0] = S[0];
	assign v[1] = S[1];
	assign v[2] = S[2];
	assign v[3] = S[3];
	
	
	assign z = (S[4])|(S[3] & S[2]) | (S[3] & S[1]);
	assign A[0] = (S[4] & ~S[3] & ~S[2] & S[0]) | (~S[4] & S[3] & S[1] & S[0]) | (~S[4] & S[3] & S[2] & S[0]);
	assign A[1] = (S[4] & ~S[3] & ~S[2] & ~S[1]) | (~S[4] & S[3] & S[2] & ~S[1]);
	assign A[2] = (~S[4] & S[3] & S[2] & S[1]) | (S[4] & ~S[3] & ~S[2] & ~S[1]);  
	assign A[3] = (S[4] & ~S[3] & ~S[2] & S[1]);
	
	
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


module subadder(a, b, ci, s, co );
	input a, b, ci;
	output s, co;
	
	assign s = ci ^ (a^b);
	assign co = ((a^b)&ci) | (~(a^b) & b);
endmodule 