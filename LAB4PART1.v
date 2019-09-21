module LAB4PART1(SW,HEX1,HEX0);
	input [7:0]SW;
	output[6:0]HEX1;
	output[6:0]HEX0;
	wire x0,x1;
	assign x0 = SW[3:0];
	assign x1 = SW[7:4];
	display HEX0(x0,HEX0);
	display HEX1(x1,HEX1);
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