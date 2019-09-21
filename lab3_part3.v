module lab3_part3(SW, LEDR);
	input [9:0]SW;
	output [9:0]LEDR;
	wire [3:0]a;
	wire [3:0]b;
	wire cin, cout, s1, s2, s3, c1, c2, c3;
	assign a = SW[7:4] ;
	assign b = SW[3:0];
	assign cin = SW[8];

	subadder f1(a[0], b[0], cin, s0, c1);
	subadder f2(a[1], b[1], c1, s1, c2);
	subadder f3(a[2], b[2], c2, s2, c3);
	subadder f4(a[3], b[3], c3, s3, cout);
	assign LEDR[0] = s0;
	assign LEDR[1] = s1;
	assign LEDR[2] = s2;
	assign LEDR[3] = s3;
	assign LEDR[4] = cout;

endmodule



module subadder(a, b, ci, s, co );
	input a, b, ci;
	output s, co;
	
	assign s = ci ^ (a^b);
	assign co = ((a^b)&ci) | (~(a^b) & b);
endmodule
