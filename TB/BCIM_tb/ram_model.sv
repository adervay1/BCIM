//AFD: Model Intel Dual Port RAM Instantiation for Simulation
//https://github.com/stepfpga/STEP-MAX10

module ram_model #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter bit VERBOSE = 0
) (
    input   [ADDR_WIDTH-1:0]    address_a,
    input   [ADDR_WIDTH-1:0]    address_b,
    input                       clock,
    input   [DATA_WIDTH-1:0]    data_a,
    input   [DATA_WIDTH-1:0]    data_b,
    input                       wren_a,
    input                       wren_b,
    output  [DATA_WIDTH-1:0]    q_a,
    output  [DATA_WIDTH-1:0]    q_b
);

logic [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];
logic [DATA_WIDTH-1:0] q_a_reg;
logic [DATA_WIDTH-1:0] q_b_reg;


always_ff @ (posedge clock) begin
    if (wren_a) begin
        mem[address_a]  <= data_a;
        if (VERBOSE) $display("Writing %h to Bitline %h",data_a,address_a);
    end else begin
        q_a_reg         <= mem[address_a];
    end
end

always_ff @ (posedge clock) begin
    if (wren_b) begin
        mem[address_b]  <= data_b;
        if (VERBOSE) $display("Writing %h to Bitline %h",data_b,address_b);
    end else begin
        q_b_reg         <= mem[address_b];
    end
end

assign q_a = q_a_reg;
assign q_b = q_b_reg;

endmodule