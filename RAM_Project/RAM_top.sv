import RAM_package::*;
module RAM_top();

bit clk;

always #10 clk=~clk;

RAM_if RAMif(clk);

project_ram dut(RAMif);
RAM_tb_if dut1(RAMif);
//bind project_ram RAM_assertions dut2(RAMif);
MONITOR_if dut3(RAMif);

endmodule