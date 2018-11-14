// Arithmetic logic unit
module ALU (a, b, alu_control, out);
  input [31:0] a, b;
  input [2:0] alu_control;
  output reg [31:0] out;
  always @ (alu_control or a or b)
		case(alu_control)
		  // ADD 3'b000
		  3'b000:  out = a + b;
		  // SUB 3'b001
		  3'b001: out = a-b;
		  // AND 3'b010
		  3'b010: out = a&b;
		  // OR  3'b011
		  3'b011: out = a|b;
		  // NOR 3'b100
		  3'b100: out = a~|b;
		  // XOR 3'b101
		  3'b101: out = a^b;

		  default: out = 32'bx;
		endcase
endmodule

// Parameterized mux
module mux3 #(parameter WIDTH=8) (a, b, c, select, out);
  // select | out
  input [WIDTH-1:0] a, b, c;
  input [1:0] select;
  output reg [WIDTH-1:0] out;
  
  always @ (a or b or c or select)
	case (select)
	// 00 | a
		2'd0: out = a;
	// 01 | b
		2'd1: out = b;
	// 02 | c
		2'd2: out = c;
		
		default: out = {(WIDTH){1'bx}};
	endcase
endmodule

// Simple FSM
module simon1
(
	input wire clock, reset,
	input wire [1:0] in,
	output reg [1:0] out
);

localparam [2:0] // 6 states
    S = 0,
    R = 1,
    G = 2,
    B = 3,
    Y = 4,
    F = 5;
    
reg[2:0] state_reg, state_next; 

initial begin
	//$monitor("state_reg: %d", state_reg);
    out = 0;
    state_reg = S;
	state_next = S;
end


always @ (posedge reset, posedge clock)
begin
    if (reset) begin
        out <= 0;
        state_reg <= S;
    end else begin
		state_reg <= state_next;
	end
end 


always @ (in, state_reg)
begin
	state_next = F; //default
    case (state_reg)
        S : begin
                out = 2;
                case (in)
                    0: state_next = R;
                    1: state_next = G;
                    2: state_next = B;
                    3: state_next = Y;
                endcase
            end
        R : begin
                if (in == 0) out = 2;
                else out = 1;
            end
        G : begin
                if (in == 1) out = 2;
                else out = 1;
            end
        B : begin
                if (in == 2) out = 2;
                else out = 1;
            end
        Y : begin
                if (in == 3) out = 2;
                else out = 1;
            end
    endcase
end
endmodule 
