module testatm(
	card,
	enter,
	code,
	exp_pin,
	funds,
	clk,
	rst_n,
	msg,
	cash_trap,
	eject_card
);

input card;
input enter;
input [13:0]code;
input [13:0]exp_pin;
input [31:0]funds;
input clk;
input rst_n;
output reg[3:0]msg;
output reg cash_trap;
output reg eject_card;

localparam STATE_Idle = 4'd0;
localparam STATE_Check_pin = 4'd1;
localparam STATE_Menu = 4'd2;
localparam STATE_Invalid = 4'd3;
localparam STATE_Extract = 4'd4;
localparam STATE_Query = 4'd5;
localparam STATE_Funds = 4'd6;
localparam STATE_Cash_out = 4'd7;
localparam STATE_Exit = 4'd8;

reg [3:0]state;
reg [1:0]incercari_pin;

always @(posedge clk,negedge rst_n) begin		
	
	if(~rst_n) begin
		cash_trap=0;
		eject_card =0;
		state<=STATE_Idle;
		end
	if(~card)
		state <= STATE_Idle;
    else begin
        case(state)
        STATE_Check_pin: begin
            if(code==exp_pin && enter)
                state <= STATE_Menu;
            else begin
				incercari_pin <= incercari_pin-1;
				if(incercari_pin)
					state <= STATE_Check_pin;
				else
					state <= STATE_Exit;
				end
        end
        STATE_Menu: begin
            if(code==1 && enter)
                state <= STATE_Extract;
            else if(code==2 && enter)
                state <= STATE_Query;
			else
				state <= state;
        end
		STATE_Extract: begin
            if(code>funds && enter)
                state <= STATE_Funds;
			else
				state <= STATE_Cash_out;
			if(~enter)
				state<=state;
			end
		STATE_Funds: begin
                state <= STATE_Menu;
			end
		STATE_Cash_out: begin
                state <= STATE_Exit;
			end
		STATE_Query: begin
                state <= STATE_Exit;	
			end
		STATE_Exit: begin
                state <= state;	
			end
        default: begin
				state<=STATE_Check_pin;
				incercari_pin <= 3;
				end
        endcase
    end
end


always @(*) begin
    case(state)
	STATE_Idle: msg = 4'd0;
    STATE_Check_pin: msg = 4'd1;
    STATE_Invalid: msg = 4'd2;
    STATE_Menu: msg = 4'd3;
	STATE_Extract: msg = 4'd4;
    STATE_Query: msg = 4'd5;
	STATE_Funds: msg = 4'd6;
    STATE_Cash_out: begin
	msg = 4'd7;
	cash_trap=1;
	end
	STATE_Exit:begin
	msg = 4'd8;
	eject_card =1;
	end
    default: msg = 4'd0;
    endcase
end

endmodule
