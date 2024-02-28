module project_ram(RAM_if.DESIGN ramif);

parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;

logic rx_valid, clk, rst_n;
logic [9:0] din;
logic tx_valid;
logic [7:0] dout;

assign rx_valid = ramif.rx_valid;
assign clk = ramif.clk;
assign rst_n = ramif.rst_n;
assign din = ramif.din;
assign ramif.tx_valid= tx_valid;
assign ramif.dout = dout;

reg [ADDR_SIZE-1:0] addr_rd, addr_wr;
reg [7:0] mem [MEM_DEPTH-1:0];
integer i = 0;

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		for (i = 0; i < MEM_DEPTH; i=i+1) begin
			mem [i] <= 1'b0;
			dout <= 8'b0;
			tx_valid <= 1'b0;
		end
	end

	else if (rx_valid) begin
		if (din[9:8] == 2'b00) begin
			addr_wr <= din[7:0];
			tx_valid <= 0;
		end
		else if (din[9:8] == 2'b01) begin
			mem [addr_wr] <= din[7:0];
			tx_valid <= 0;
		end
		else if (din[9:8] == 2'b10) begin
			addr_rd <= din[7:0];
			tx_valid <= 0;
		end
		else if (din[9:8] == 2'b11) begin
			dout <= mem[addr_rd];
			tx_valid <= 1;
		end
	end 
end
endmodule
