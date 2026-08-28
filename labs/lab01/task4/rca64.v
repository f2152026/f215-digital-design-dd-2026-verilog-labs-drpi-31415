// rca64.v
// A plain 64-bit ripple-carry adder, chaining 64 FA_Gate instances (the
// delay-annotated version carried forward from Task 2).
//
// TODO: instantiate 64 FA_Gate modules, chained exactly like Task 2/3's
// 4-bit ripple adder, just 64 bits wide. This is very repetitive -- a
// generate-for loop is a reasonable way to write this one, since every
// stage is structurally identical, e.g.:
//
//   wire [64:0] c;
//   assign c[0] = cin;
//   genvar i;
//   generate
//     for (i = 0; i < 64; i = i + 1) begin : gen_fa
//       FA_Gate FA (.a(a[i]), .b(b[i]), .cin(c[i]), .sum(sum[i]), .cout(c[i+1]));
//     end
//   endgenerate
//   assign cout = c[64];

module rca64(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

  // TODO: your 64-bit ripple-carry structure goes here.
  wire [64:0] c;
  assign c[0] = cin;
  genvar i;
   generate
     for (i = 0; i < 60; i = i + 1) begin : gen_fa
       rca FA (.a(a[i+3:i]), .b(b[i+3:i]), .cin(c[i]), .sum(sum[i+3:i]), .cout(c[i+1]));
     end
   endgenerate
   assign cout = c[64];

endmodule
module rca(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire c1, c2, c3;

  // TODO: your four FA_Gate instances go here.
  FA_Gate FA0 (.a(a[0]) , .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1) );
  FA_Gate FA1 (.a(a[1]) , .b(b[1]), .cin(c1), .sum(sum[1]), .cout(c2) );
  FA_Gate FA2 (.a(a[2]) , .b(b[2]), .cin(c2), .sum(sum[2]), .cout(c3) );
  FA_Gate FA3 (.a(a[3]) , .b(b[3]), .cin(c3), .sum(sum[3]), .cout(cout) );

endmodule
