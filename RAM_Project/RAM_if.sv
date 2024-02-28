interface RAM_if(input bit clk);

parameter ADDR_SIZE = 8;

logic rx_valid, rst_n;
logic [9:0] din;
logic tx_valid;
logic [7:0] dout;

modport DESIGN (input clk,rx_valid, rst_n, din,output tx_valid, dout);
modport TB (output rx_valid, rst_n, din,input clk);
modport MONITOR (input clk,rx_valid, rst_n, din, tx_valid, dout);

endinterface