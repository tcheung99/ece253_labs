module LAB5PART6(input CLOCK_50,input [9:0]SW,output [6:0]HEX0,output [6:0]HEX1,output [6:0]HEX2);
		wire [24:0]C;
		wire [3:0]C2;
		wire E;
		register f1(CLOCK_50,C,C2,E);
		muxmux (SW,C2,HEX0,HEX1,HEX2);
endmodule 		

		
module register (input clk, output reg[24:0]Q, output reg[3:0]Q2, output reg E);
	always @(posedge clk)
		begin
		if (Q==25'b111111111111111111111111111)
			begin
			Q<=0;
			E=1;
			 
			if (Q2 == 3)
				Q2<=0;
			else
			Q2<=Q2+1;
			 
		end
		else
			Q <= Q+1;
			E=0;
	end
endmodule

module muxmux(SW,CC,HEX0,HEX1,HEX2);
	input [9:0]SW;
	input [1:0]CC;
	output [0:6]HEX0;
	output [0:6]HEX1;
	output [0:6]HEX2;
	wire [1:0]M0;
	wire [1:0]M1;
	wire [1:0]M2;
	mux_2bit_3to1 U0(SW[1:0],SW[3:2],SW[5:4], CC[1:0],M0); 
	char7_seg H0(M0,HEX2);	
	mux_2bit_3to1 U1(SW[3:2],SW[5:4],SW[1:0], CC[1:0],M1); 
	char7_seg H1(M1,HEX1);
	mux_2bit_3to1 U2(SW[5:4],SW[1:0],SW[3:2], CC[1:0],M2); 
	char7_seg H2(M2,HEX0);
endmodule 

module mux_2bit_3to1(u,v,w,s, M);
	output [1:0]M;
	input [1:0]u;
	input [1:0]v;
	input [1:0]w;
	input [1:0]s;
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
