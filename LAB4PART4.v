module LAB4PART4(X,Y,SW,LEDR, HEX0,HEX1);
	input [8:0]SW;
	output [9:0]LEDR;
	output [6:0]HEX0;
	output [6:0]HEX1;
	wire [3:0]s;
	wire ci,c1,c2,c3,co;
	wire [3:0]X;
	wire [3:0]Y;	
	assign ci = 1'b0;
	assign X = SW[7:4];
	assign Y = SW[3:0];
	assign ci = SW[8];
	assign s = LEDR[3:0];
	assign co = LEDR[4];
	display d5(X, HEX5);
	display d3(Y, HEX3);
	FAdd t0(X[0],Y[0], ci , s[0],c1);
	FAdd t1(X[1],Y[1], c1 , s[1],c2);
	FAdd t2(X[2],Y[2], c2 , s[2],c3);
	FAdd t3(X[3],Y[3], c3 , s[3],co);
	dec (s,co,HEX0,HEX1);
endmodule
	
module display(x,disp);
	input [3:0]x;
	output [6:0]disp;
	assign disp[0] = (~x[3]&~x[2]&~x[1]&x[0])|(x[2]&~x[1]&~x[0]);
	assign disp[1] = (x[2]&x[0]);
	assign disp[2] = (~x[3]&~x[2]&x[1]&x[0]);
	assign disp[3] = (~x[3]&~x[2]&~x[1]&x[0]);
	assign disp[4] = (x[0])|(x[2]&~x[1]);
	assign disp[5] = (~x[2]&x[1])|(x[1]&x[0])|(~x[3]&~x[2]&x[0]);
 	assign disp[6] = (~x[3]&~x[2]&~x[1])|(x[2]&x[1]&x[0]);
endmodule 
	
module dec(SW,co,HEX0,HEX1);
	input[3:0]SW;
	input co;
	output[6:0]HEX0;
	output[6:0]HEX1;
	//wire 4 bit-wide variables V,A (inputs) and x (output), and comparator function  
	wire [3:0]V; 
	wire [3:0]A; 
	wire [3:0]x; 
	wire z,w; 
	assign V=SW;
	assign z=~((V[3]&~V[2]&~V[1])|(~V[3])|~co);	
	assign w=co;

	assign A[3] = ~ (z&V[3]);
	assign A[2] = z&V[2]&V[1];
	assign A[1] = z&V[2]&~V[1];
	assign A[0] = z&V[0];


	//assign each space in output array based on logic statement for 2-to-1 multiplexer
	assign x[0]=(~z&V[0])|(z&A[0]);  
	assign x[1]=(~z&V[1])|(z&A[1]);
	assign x[2]=(~z&V[2])|(z&A[2]);
	assign x[3]=(~z&V[3])|(z&A[3]);
	
	//d0
	assign HEX0[0] = (~z&((~x[3]&~x[2]&~x[1]&x[0])|(x[2]&~x[1]&~x[0]))) | (z&((x[2]&~x[0])|(~x[2]&~x[1]&x[0])))|(~w) ;
	assign HEX0[1] = (~z&(x[2]&x[0]))|(z&(x[2]&x[0]))|(w&~x[0]&~x[1]&~x[3]&~x[2]);
	assign HEX0[2] = (~z&(~x[3]&~x[2]&x[1]&x[0]))|(z&(x[1]&~x[0]))|(~w);
	assign HEX0[3] = (~z&(~x[3]&~x[2]&~x[1]&x[0]))|(z&((x[2]&~x[0])|(~x[2]&~x[1]&x[0])))|(w&x[0]);
	assign HEX0[4] = (~z&((x[0])|(x[2]&~x[1])))|(z&(x[0]|x[2]))|(w&x[0]);
	assign HEX0[5] = (~z&((~x[2]&x[1])|(x[1]&x[0]))|(~x[3]&~x[2]&x[0]))|(z&(x[1]|(~x[2]&x[0])))|(w&x[0]&~x[1]);
 	assign HEX0[6] = (~z&((~x[3]&~x[2]&~x[1])|(x[2]&x[1]&x[0])))|(z&(~x[2]&~x[1]));
	//d1	
	assign HEX1[0] = z & V[3];
	assign HEX1[1] = 1'b0;
	assign HEX1[2] = 1'b0;
	assign HEX1[3] = z & V[3];
	assign HEX1[4] = z & V[3];
	assign HEX1[5] = z & V[3];
	assign HEX1[6] = 1'b1;
endmodule 	
	
module FAdd(a,b,ci,s,co);
	input a,b,ci;
	output s, co;
	assign s = a^b^ci;
	assign co = (a&b) | (a&ci) | (b&ci); 
endmodule 