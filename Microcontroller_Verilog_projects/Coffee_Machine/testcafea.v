module testcafea();

reg clk;
reg y;
reg n;
reg [4:0]fond;
reg rst_n;
wire cafea;
wire cioco;
wire zahar;
wire lapte;
wire[3:0]msg;

cafea dut(
	.clk(clk),
	.y(y),
	.n(n),
	.fond(fond),
	.rst_n(rst_n),
	.cafea(cafea),
	.cioco(cioco),
	.zahar(zahar),
	.lapte(lapte),
	.msg(msg)
);

initial begin
    clk = 0;                 
    forever #25 clk = ~clk;  
end

always @(*) begin
    case(msg)
	4'd0: $display("Welcome");
    4'd1: $display("Choose");
    4'd2: $display("COFEE");
    4'd3: $display("CIOCO");
	4'd4: $display("EXTRA MILK?");
    4'd5: $display("EXTRA SUGAR?");
	4'd6: $display("INSERT COIN");
    4'd7: $display("INSUFICIENT FUNDS");
	4'd8: $display("READY");
	4'd9: $display("EXTRA MILK SELECTED");
	4'd10: $display("EXTRA SUGAR SELECTED");
    default: 
	$display("Welcome");
    endcase
end

initial begin
	
	rst_n=0;
	y=0;
	n=0;
	fond=12;
	#50;
	
	rst_n=1;
	#50;
	
	y=1;
	#50;
	
	y=0;
	#50;
	
	y=1;
	#50;
	
	y=0;
	#50;
	
	y=1;
	#50;
	
	y=0;
	#50;
	
	n=1;
	#50;
	
	n=0;
	#50;
	
	y=1;
	#50;
	
	y=0;
	#50;
	
	#200;
	rst_n=0;
	
	#50;
	
	$stop;
end

endmodule