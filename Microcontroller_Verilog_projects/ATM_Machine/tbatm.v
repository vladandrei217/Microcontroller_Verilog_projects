`timescale 1ns/1ps

module tbatm();

reg card;
reg a;
reg b;
reg nrst;
reg clk;
wire[2:0] msg;

state DUT(
	.card(card),
	.a(a),
	.b(b),
	.nrst(nrst),
	.clk(clk),
	.msg(msg)
);

initial begin
    clk = 0;                 // initialization at time 0
    forever #10 clk = ~clk;  // toggle the clock at each 10 simulation steps
end

initial begin
	
	a=0;
	b=0;
	nrst=0;
	card=0;
	#20;
	nrst=1;
	#20;
	card=1;
	#20;
	a=1;
	#20;
	a=0;
	#20;
	b=1;
	#20;
	b=0;
	#20;
	a=1;
	b=0;
	#20;
	a=0;
	#20;
	nrst=0;
	#20;
	nrst=1;
	#20;
	
	$stop;
end

endmodule
