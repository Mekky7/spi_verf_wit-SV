module RAM_assertions(RAM_if.DESIGN ramif);


	property property1;
		@(posedge ramif.clk) (~ramif.rst_n) |-> ( (~ramif.tx_valid) && (~ramif.dout) ) ;
	endproperty	

	property property2;
		@(posedge ramif.clk) disable iff(!ramif.rst_n) (~ramif.rx_valid) |-> $stable(ramif.din)  ;
	endproperty
	
lb1:	assert property (property1);
lb2:	assert property (property2);

lb4:	cover property(property1);
lb5:	cover property(property2);

endmodule