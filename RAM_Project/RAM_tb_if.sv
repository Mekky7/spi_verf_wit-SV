import RAM_package::*;

module RAM_tb_if(RAM_if.TB ramif);

bit clk;
logic rx_valid, rst_n;
logic [9:0] din;

RAM_transcation RAM_inst=new();

assign ramif.rx_valid = rx_valid;
assign clk = ramif.clk;
assign ramif.rst_n = rst_n;
assign ramif.din = din;

initial begin

rst_n=0;
@(negedge clk);
rst_n=1;
repeat(20000) begin
	assert(RAM_inst.randomize());
	din[9:8]=00;
	rx_valid <= RAM_inst.rx_valid;
	din[7:0] <= RAM_inst.din[7:0];
	@(negedge clk);
	assert(RAM_inst.randomize());
	din[9:8]=01;
	rx_valid <= RAM_inst.rx_valid;
	din[7:0] <= RAM_inst.din[7:0];
	@(negedge clk);
end	

repeat(20000) begin
	assert(RAM_inst.randomize());
	din[9:8]=10;
	rx_valid <= RAM_inst.rx_valid;
	din[7:0] <= RAM_inst.din[7:0];
	@(negedge clk);
	assert(RAM_inst.randomize());
	din[9:8]=11;
	rx_valid <= RAM_inst.rx_valid;
	din[7:0] <= RAM_inst.din[7:0];
	@(negedge clk);
end	

repeat(20000) begin
	assert(RAM_inst.randomize());
	rst_n <= RAM_inst.rst_n;
	rx_valid <= RAM_inst.rx_valid;
	din <= RAM_inst.din;
	@(negedge clk);
end	

test_finished=1;
end

endmodule