`timescale 1ns / 1ps


module ripple_add_sub_16bit_tb();
reg tckr;
reg [15:0]tA,tBi;
wire [15:0]tS;
wire tCo;

ripple_add_sub_16bit dut(.A(tA), .Bi(tBi), .ckr(tckr), .Co(tCo), .S(tS));

initial begin
tA=16'b1010001010100111; tBi=16'b1111010100101101; tckr=0;
#10
tA=16'b0000000000000000; tBi=16'b0000000000000000; tckr=0;
#10 
tA=16'b1111010110110000; tBi=16'b1111000000000001; tckr=0;
#10
tA=16'b1111111111111111; tBi=16'b1111111111111111; tckr=0;
#10
tA=16'b1010001010100111; tBi=16'b1111010100101101; tckr=1;
#10
tA=16'b0000000000000000; tBi=16'b0000000000000000; tckr=1;
#10 
tA=16'b1111010110110000; tBi=16'b1111000000000001; tckr=1;
#10
tA=16'b1101010101101010; tBi=16'b1110111010111111; tckr=1;
#10
$stop;
end

endmodule

