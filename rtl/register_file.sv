module register_file (
    input [31:0] Data_D ,
    input [4:0] Addr_A , Addr_B ,Addr_D,
    input Reg_write_enable ,clk,
    output logic [31:0] Data_A , Data_B 
    );
logic  [31:0] Register [32];  
assign Register[0] = 32'b0 ;



always_ff @(posedge clk) begin 
if(Reg_write_enable && Addr_D != 0) begin
        Register[Addr_D] <= Data_D ;
    end
end
assign Data_A = Register[Addr_A] ;
assign Data_B = Register[Addr_B] ;

endmodule