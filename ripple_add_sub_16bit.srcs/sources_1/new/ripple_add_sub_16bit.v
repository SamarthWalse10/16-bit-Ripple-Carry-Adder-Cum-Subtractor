`timescale 1ns / 1ps


module ripple_add_sub_16bit(ckr,A,Bi,Co,S);

input [15:0]A,Bi;
input ckr;
output [15:0]S;
output Co;
wire [15:0]B;
wire C0,C1,C2,C3,Ci;
wire [3:0]S0,S1,S2,S3;

function adder_4bit_c(ci,[3:0]a,[3:0]b);
    reg c0,c1,c2,c3;
    begin
    c0 = (a[0]&b[0])+(ci&(a[0]^b[0]));
    c1 = (a[1]&b[1])+(c0&(a[1]^b[1]));
    c2 = (a[2]&b[2])+(c1&(a[2]^b[2]));
    c3 = (a[3]&b[3])+(c2&(a[3]^b[3]));
    adder_4bit_c = c3;
    end
endfunction

function [3:0] adder_4bit_s(ci,[3:0]a,[3:0]b);
    reg c0,s0,c1,s1,c2,s2,c3,s3;
    begin
    c0 = (a[0]&b[0])+(ci&(a[0]^b[0]));
    s0 = a[0]^b[0]^ci;
    c1 = (a[1]&b[1])+(c0&(a[1]^b[1]));
    s1 = a[1]^b[1]^c0;
    c2 = (a[2]&b[2])+(c1&(a[2]^b[2]));
    s2 = a[2]^b[2]^c1;
    c3 = (a[3]&b[3])+(c2&(a[3]^b[3]));
    s3 = a[3]^b[3]^c2;
    adder_4bit_s[0]=s0;
    adder_4bit_s[1]=s1;
    adder_4bit_s[2]=s2;
    adder_4bit_s[3]=s3;
    end
endfunction

assign B = ckr ? ~Bi : Bi;   // (ckr=0 => adder) , (ckr=1 => subtrator)
assign Ci = ckr ? 1'b1 : 1'b0;

assign C0 = adder_4bit_c(Ci,A[3:0],B[3:0]);
assign S0 = adder_4bit_s(Ci,A[3:0],B[3:0]);
assign C1 = adder_4bit_c(C0,A[7:4],B[7:4]);
assign S1 = adder_4bit_s(C0,A[7:4],B[7:4]);
assign C2 = adder_4bit_c(C1,A[11:8],B[11:8]);
assign S2 = adder_4bit_s(C1,A[11:8],B[11:8]);
assign C3 = adder_4bit_c(C2,A[15:12],B[15:12]);
assign S3 = adder_4bit_s(C2,A[15:12],B[15:12]);

assign Co = C3;
assign S[3:0] = S0;
assign S[7:4] = S1;
assign S[11:8] = S2;
assign S[15:12] = S3;

endmodule

