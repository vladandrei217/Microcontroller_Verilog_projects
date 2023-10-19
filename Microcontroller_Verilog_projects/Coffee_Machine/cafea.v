module cafea(
	clk,
	y,
	n,
	fond,
	rst_n,
	cafea,
	cioco,
	zahar,
	lapte,
	msg
);

input clk;
input y;
input n;
input [4:0]fond;
input rst_n;
output reg cafea;
output reg cioco;
output reg zahar;
output reg lapte;
output reg[3:0]msg;

localparam Idle = 4'd0;
localparam Meniu = 4'd1;
localparam Cafea = 4'd2;
localparam Ciocolata = 4'd3;
localparam Lapte_extra = 4'd4;
localparam Zahar_extra = 4'd5;
localparam Bani = 4'd6;
localparam Fond = 4'd7;
localparam Activ = 4'd8;

//stari suplimentare intermediare
localparam Lapte = 4'd9;
localparam Zahar = 4'd10;

reg [3:0]state;

always @(posedge clk,negedge rst_n) begin		
	
	if(~rst_n)
		state<=Idle;
    else begin
        case(state)
        Idle: begin
            if(y)
				state<=Meniu;
				else
				state<=state;
        end
        Meniu: begin
            if(y)
                state <= Cafea;
            else if(n)
                state <= Ciocolata;
			else
				state <= state;
        end
		Ciocolata: begin
            state<=Lapte_extra;
			end
		Cafea: begin
                state<=Lapte_extra;
			end
		Lapte_extra: begin
                if(y)
				state<=Lapte;
				else if(n)
				state<=Zahar_extra;
				else
				state <= state;
			end
		Zahar_extra: begin
                if(y)
				state<=Zahar;
				else if(n)
				state<=Bani;
				else
				state <= state;				
			end
		Lapte: begin
            state<=Zahar_extra;
			end
		Zahar: begin
                state <= Bani;
			end
		Bani: begin
                if(y && fond>=5)
				state<=Activ;
				else if(y && fond<5)
				state<=Fond;
				else
				state <= state;				
			end	
		Fond: begin
                state <= Bani;		
			end
        default: state<=Idle;
        endcase
    end
end

always @(*) begin
    case(state)
	Idle: msg = 4'd0;
	Meniu: msg = 4'd1;
	Cafea: begin 
		msg = 4'd2;
		cafea=1;
	end
	Ciocolata: begin 
		msg = 4'd3;
		cioco=1;
	end
	Lapte_extra: msg = 4'd4;
	Zahar_extra: msg = 4'd5;
	Bani: msg = 4'd6;
	Fond: msg = 4'd7;
	Activ: msg = 4'd8;

//stari suplimentare intermediare
	Lapte: begin 
		msg = 4'd9;
		lapte=1;
	end
	Zahar: begin 
		msg = 4'd10;
		zahar=1;
	end
    default: msg = 4'd0;
    endcase
end

endmodule