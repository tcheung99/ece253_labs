module LAB4PART2(SW,HEX0,HEX1);
	input[3:0]SW;
	output[6:0]HEX0;
	output[6:0]HEX1;
	//wire 4 bit-wide variables V,A (inputs) and x (output), and comparator function  
	wire [3:0]V; 
	wire [3:0]A; 
	wire [3:0]x; 
	wire z; 
	assign V=SW;
	assign z=~((V[3]&~V[2]&~V[1])|(~V[3]));	


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
	assign HEX0[0] = (~z&((~x[3]&~x[2]&~x[1]&x[0])|(x[2]&~x[1]&~x[0]))) | (z&((x[2]&~x[0])|(~x[2]&~x[1]&x[0])));
	assign HEX0[1] = (~z&(x[2]&x[0]))|(z&(x[2]&x[0]));
	assign HEX0[2] = (~z&(~x[3]&~x[2]&x[1]&x[0]))|(z&(x[1]&~x[0]));
	assign HEX0[3] = (~z&(~x[3]&~x[2]&~x[1]&x[0]))|(z&((x[2]&~x[0])|(~x[2]&~x[1]&x[0])));
	assign HEX0[4] = (~z&((x[0])|(x[2]&~x[1])))|(z&(x[0]|x[2]));
	assign HEX0[5] = (~z&((~x[2]&x[1])|(x[1]&x[0]))|(~x[3]&~x[2]&x[0]))|(z&(x[1]|(~x[2]&x[0])));
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