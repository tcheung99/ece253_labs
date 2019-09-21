module lab3(SW, HEX0, HEX1);
	input [9:0]SW;
	output [0:9]HEX0;
	output [0:9]HEX1;
	wire x0,x1,x2,x3;
	wire y0,y1,y2,y3;
	assign x0 = SW[0];
	assign x1 = SW[1];
	assign x2 = SW[2];
	assign x3 = SW[3];
	assign y0 = SW[4];
	assign y1 = SW[5];
	assign y2 = SW[6];
	assign y3 = SW[7];	
	assign HEX0[0] = (x2 & ~x1 & ~x0) | (~x3 & ~x2 & ~x1 & x0) ;
	assign HEX0[1] = (x2 & ~x1 & x0) | (x2 & x1 & ~x0);
	assign HEX0[2] = (~x2 & x1 & ~x0);
	assign HEX0[3] = (~x3 & ~x2 & ~x1 & x0) | (x2 & ~x1 & ~x0) | (x2 & x1 & x0);
	assign HEX0[4] = (x0) | (x2 & ~x1);
	assign HEX0[5] = (~x2 & x1) | (~x3 & ~x2 & x0)| (x1 & x0);
	assign HEX0[6] = (~x3 & ~x2 & ~x1) | ( x2 & x1 & x0);
	assign HEX1[0] = (y2 & ~y1 & ~y0) | (~y3 & ~y2 & ~y1 & y0) ;
	assign HEX1[1] = (y2 & ~y1 & y0) | (y2 & y1 & ~y0);
	assign HEX1[2] = (~y2 & y1 & ~y0);
	assign HEX1[3] = (~y3 & ~y2 & ~y1 & y0) | (y2 & ~y1 & ~y0) | (y2 & y1 & y0);
	assign HEX1[4] = (y0) | (y2 & ~y1);
	assign HEX1[5] = (~y2 & y1) | (~y3 & ~y2 & y0)| (y1 & y0);
	assign HEX1[6] = (~y3 & ~y2 & ~y1) | ( y2 & y1 & y0);
endmodule 
