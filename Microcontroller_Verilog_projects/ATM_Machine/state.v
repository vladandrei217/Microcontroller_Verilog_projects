module state(
	card,
	a,
	b,
	nrst,
	clk,
	msg
);

input card;
input a;
input b;
input nrst;
input clk;
output reg[2:0] msg;

localparam STATE_Fara = 3'd0;
localparam STATE_Nul = 3'd1;
localparam STATE_Prima = 3'd2;
localparam STATE_Doua = 3'd3;
localparam STATE_Treia = 3'd4;
localparam STATE_Gresit = 3'd5;

localparam MESAJ_inceput = 3'd0;
localparam MESAJ_introducere = 3'd1;
localparam MESAJ_corect = 3'd2;
localparam MESAJ_gresit = 3'd3;

reg [2:0]state;


always @(posedge clk) begin		
	
	if(~nrst)begin
		if(card)
		state <= STATE_Nul;
		else
		state <= STATE_Fara;
	end
    else begin
        case(state)
        STATE_Nul: begin
            if(a)
                state <= STATE_Prima;
            else if(b)
                state <= STATE_Gresit;
            else
                state <= state; // stays in the same state
        end
        STATE_Prima: begin
            if(b)
                state <= STATE_Doua;
            else if(a)
                state <= STATE_Gresit;
			else
				state <= state;
        end
		STATE_Doua: begin
            if(a)
                state <= STATE_Treia;
            else if(b)
                state <= STATE_Gresit;
			else
				state <= state;
			end
		STATE_Treia: begin
                state <= state;
			end
		STATE_Gresit: begin
                state <= state;	
			end
        // other states with their transitions
        default: begin
                if(card)
			state <= STATE_Nul;
		else
			state <= STATE_Fara;
				
				end
					// from undefined states jump to the initial state
        endcase
    end
end

always @(*) begin
    case(state)
	STATE_Fara: msg = MESAJ_inceput;
    STATE_Nul: msg = MESAJ_introducere;
    STATE_Prima: msg = MESAJ_introducere;
    STATE_Doua: msg = MESAJ_introducere;
	STATE_Treia: msg = MESAJ_corect;
    STATE_Gresit: msg = MESAJ_gresit;
    // other states with their outputs
    default: msg = MESAJ_inceput;
    endcase
end

endmodule