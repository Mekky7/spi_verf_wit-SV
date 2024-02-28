import RAM_package::*;

module MONITOR_if(RAM_if.MONITOR ramif);

	RAM_transcation trans=new();
	RAM_reference checker_inst=new();

		always @(negedge ramif.clk) begin
			
			trans.rx_valid=ramif.rx_valid;
			trans.rst_n=ramif.rst_n;
			trans.din=ramif.din;
			trans.dout=ramif.dout;
			trans.tx_valid=ramif.tx_valid;
			trans.Sample_fun();

			fork
				begin
					checker_inst.Checker(trans);
				end
			join

			if(test_finished)begin
				$display("========TEST COMPLETED ========\n WITH ERRORS=%d & WITH CORRECT=%d ",error_count,correct_count);
				$stop;
			end	

		end
endmodule	