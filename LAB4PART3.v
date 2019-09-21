module LAB4PART3(SW,LEDR);
	input [8:0]SW;
	output [9:0]LEDR; 
	wire [3:0]a;
	wire [3:0]b;
	wire co,ci,c1,c2,c3;
	wire [3:0]s;
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign ci = SW[8];
	assign LEDR[4]=co;
	assign LEDR[3:0]=s;
	FA t0(a[0],b[0], 1'b0 , s[0],c1);
	FA t1(a[1],b[1], c1 , s[1],c2);
	FA t2(a[2],b[2], c2 , s[2],c3);
	FA t3(a[3],b[3], c3 , s[3],co);
	
endmodule

module FA(a,b,ci,s,co);
	input a,b,ci;
	output s, co;
	assign s = a^b^ci;
	assign co = (a&b) | (a&ci) | (b&ci); 
endmodule 