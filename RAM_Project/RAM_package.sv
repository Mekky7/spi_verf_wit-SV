package RAM_package;

	bit test_finished ;
	integer error_count ;
	integer correct_count ;

class RAM_transcation;

	rand logic rx_valid, rst_n;
	rand logic [9:0] din;
	logic tx_valid;
	logic [7:0] dout;

		constraint rst_c 
		{
			rst_n dist {0:=3, 1:=97};
		}

		constraint rx_valid_c 
		{
			rx_valid dist {0:=10, 1:=90};
		}

		covergroup CovCode ;
			din_cp: coverpoint din;
			endgroup

		function new();
			CovCode = new();
		endfunction	

		function void Sample_fun();
			CovCode.sample();
		endfunction

endclass

class RAM_reference;

	logic tx_valid_expected;
	logic [7:0] dout_expected;

	logic [7:0] mem_expected [255:0] ;

	logic [7:0] addr_rd_expected,addr_wr_expected;

	function void Checker(RAM_transcation obj);
			
			Checker_reference_model(obj);

				if(dout_expected !== obj.dout ) begin
					$display("ERROR IN dout AT TIME:%t ---EXPECTED: %h ---ACTUAL:%h",$time,dout_expected,obj.dout);
					error_count=error_count+1;
				end 
				else if(tx_valid_expected !== obj.tx_valid ) begin
					$display("ERROR IN tx_valid AT TIME:%t ---EXPECTED: %h ---ACTUAL:%h",$time,tx_valid_expected,obj.tx_valid);
					error_count=error_count+1;
				end 
				else begin
					correct_count=correct_count+1;
				end
		endfunction

function void Checker_reference_model(RAM_transcation obj);

	if (~obj.rst_n) begin
		for (int i = 0; i < 256; i=i+1) begin
			mem_expected[i] = 1'b0;
			dout_expected = 8'b0;
			tx_valid_expected = 1'b0;
		end
	end

	else if (obj.rx_valid) begin
		if (obj.din[9:8] == 2'b00) begin
			addr_wr_expected = obj.din[7:0];
			tx_valid_expected = 0;
		end
		else if (obj.din[9:8] == 2'b01) begin
			mem_expected [addr_wr_expected] = obj.din[7:0];
			tx_valid_expected = 0;
		end
		else if (obj.din[9:8] == 2'b10) begin
			addr_rd_expected = obj.din[7:0];
			tx_valid_expected = 0;
		end
		else if (obj.din[9:8] == 2'b11) begin
			dout_expected = mem_expected[addr_rd_expected];
			tx_valid_expected = 1;
		end
	end 

endfunction

		function new() ;
			error_count =0;
			correct_count =0 ;
		endfunction


endclass
	
endpackage