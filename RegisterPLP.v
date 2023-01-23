module RegisterPLP#(parameter DW = 5) (
    input Clk, Rst, En, // Clk is the clock input, Rst is the reset input, En is the enable input
    input [DW-1:0] Din, // Din is the input data to be stored in the register
    output reg [DW-1:0] Dout // Dout is the output data stored in the register
);

// Always block to be triggered on the rising edge of the clock
always @(posedge Clk) begin 
    // If the reset input is high, clear the register
    if (Rst) Dout <= 0;
    else begin
        // If the enable input is low, keep the current value in the register
        if (!En) Dout <= Dout;
        // Else, store the input data in the register
        else Dout <= Din;
    end       
end

endmodule