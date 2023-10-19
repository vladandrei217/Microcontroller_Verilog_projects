`timescale 1ns/1ps

module tbtestatm();

reg card;
reg enter;
reg [13:0]code;
reg [13:0]exp_pin;
reg [31:0]funds;
reg clk;
reg rst_n;
wire[3:0]msg;
wire cash_trap;
wire eject_card;

testatm DUT(
	.card(card),
	.enter(enter),
	.code(code),
	.exp_pin(exp_pin),
	.funds(funds),
	.clk(clk),
	.rst_n(rst_n),
	.msg(msg),
	.cash_trap(cash_trap),
	.eject_card(eject_card)
);

initial begin
    clk = 0;                 // initialization at time 0
    forever #10 clk = ~clk;  // toggle the clock at each 10 simulation steps
end

initial begin
	
	card=0;
	enter=0;
	code=0;
	exp_pin=1234;
	funds=224;
	rst_n=1;
	#20;
	rst_n=0;
	#20;
	card=1;
	#20;
	enter=1;
	code=1234;
	#20;
	enter=0;
	#20;
	code=1;
	enter=1;
	#20;
	enter=0;
	#20;
	code=25;
	enter=1;
	#20;
	enter=0;
	#20;
	rst_n=1;
	
	$stop;
end

always @(*) begin
    case(msg)
	4'd0: $display("Please insert card");
    4'd1: $display("Enter PIN");
    4'd2: $display("Invalid PIN");
    4'd3: $display("Enter option");
	4'd4: $display("Enter amount");
    4'd5: $display("Insuficient founds");
	4'd6: $display("Jackpot! Cash out");
    4'd7: $display("Card back");
	4'd8: $display("Print the funds");
    default: 
	$display("Please insert card");
    endcase
end

endmodule
