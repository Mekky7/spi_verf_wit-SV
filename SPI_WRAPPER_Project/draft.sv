class wrapper_testing;
 rand logic MOSI;
 rand logic [10:0]data_holder ;
 rand logic SS_n;
 rand logic rst_n;
 constraint rst_n_c{
    rst_n dist{1:=98,0:=2};
 }
 constraint data_holder_c_write{
if(const'(data_holder[10:8])==3'b000)
{
 data_holder[10:8]==3'b001;   
}
if(const'(data_holder[10:8])==3'b110)
{
 data_holder[10:8]==3'b111;   
}
data_holder[10]==data_holder[9];
if(SS_n) data_holder==const'(data_holder);
 }
 

    function new();
        
    endfunction //new()
 endclass //className   
module top;
 
wrapper_testing a=new;
  initial
  begin 
     a.data_holder=0;
    repeat(100) begin
    assert(a.randomize());
    $displayb(a.data_holder);
  end
  $stop;
  end

endmodule