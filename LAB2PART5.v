module LAB2PART5(SW,LEDR,HEX0,HEX1,HEX2);
	input [9:0]SW;
	output [9:0]LEDR;
	output [0:6]HEX0;
	output [0:6]HEX1;
	output [0:6]HEX2;
	wire [1:0]M0;
	wire [1:0]M1;
	wire [1:0]M2;
	mux_2bit_3to1 U0(SW, M0); //"computes" 2-bit output M0 of the input switches (SW)
	char7_seg H0(M0,HEX2);		//Set HEX display based on the computed M0
	assign M1[1] = (~M0[1] & M0[0]); //"rotate" M1 by performing logic function to assign both bits of M1 
	assign M1[0] = (~M0[1] & ~M0[0]);
	char7_seg H1(M1,HEX1);
	assign M2[1] = (|(~M1[1] & M1[0]));
	assign M2[0] = (~M1[1] & ~M1[0]);
	char7_seg H2(M2,HEX0);
endmodule 

module mux_2bit_3to1(SW, M);
	input [9:0]SW;
	output [1:0]M;
	wire [1:0]u;
	wire [1:0]v;
	wire [1:0]w;
	wire [1:0]s;
	wire [1:0]M;
	assign w = SW[1:0];
	assign v = SW[3:2];
	assign u = SW[5:4];
	assign s[0] = SW[8];
	assign s[1] = SW[9];
	assign M[0] = (s[1] & w[0])|(~s[1]&~s[0]&u[0]) |(~s[1]&s[0]&v[0]); //based on first bit of inputs u,v,w
	assign M[1] = (s[1] & w[1])|(~s[1]&~s[0]&u[1]) |(~s[1]&s[0]&v[1]); //based on second bit of inputs u,v,w
endmodule 

module char7_seg(C,Display);
	input [1:0]C;
	output [6:0]Display;
	wire c0;
	wire c1;
	assign c1 = C[1];
	assign c0 = C[0];
	assign Display[2] = c0;
	assign Display[1] = c0;
	assign Display[4] = c1;
	assign Display[3] = c1;
	assign Display[5] = ~(~c1 & c0);
	assign Display[0] = ~(~c1 & c0);
	assign Display[6] = c1;
endmodule
