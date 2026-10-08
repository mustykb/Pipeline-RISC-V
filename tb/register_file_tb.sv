module register_file_tb ();
   logic [31:0] Data_D_t ;
    logic [4:0] Addr_A_t , Addr_B_t ,Addr_D_t;
    logic Reg_write_enable_t ;
    logic [31:0] Data_A_t , Data_B_t ;
    logic clk_t = 0;
    register_file dut (
        .Data_D(Data_D_t),
        .Addr_A(Addr_A_t),
        .Addr_B(Addr_B_t),
        .Addr_D(Addr_D_t),
        .Reg_write_enable(Reg_write_enable_t),
        .Data_A(Data_A_t),
        .Data_B(Data_B_t),
        .clk(clk_t)
    );
    logic  [31:0] Register_model [32] = '{default:32'b0} ;
    int error = 0;
    always #10 clk_t = ~clk_t;

       always_ff @(posedge clk_t) begin
        if(Reg_write_enable_t && Addr_D_t != 0) begin
            Register_model[Addr_D_t] <= Data_D_t;
        end
      end

    initial begin
        
     repeat (200) begin

         @(negedge clk_t);
      Data_D_t = $urandom;
      Addr_A_t = 5'($urandom_range(0, 31));
      Addr_B_t = 5'($urandom_range(0, 31));
      Addr_D_t = 5'($urandom_range(0, 31));
      Reg_write_enable_t = 1'($urandom_range(0, 1));
      #2;
    
   
      if(Register_model[Addr_A_t] !== Data_A_t) begin
        $display("Test failed: Register[%0d] = %0h, expected %0h", Addr_A_t, Data_A_t , Register_model[Addr_A_t]);
        error++;
      end 
      if(Register_model[Addr_B_t] !== Data_B_t) begin
        $display("Test failed: Register[%0d] = %0h, expected %0h", Addr_B_t, Data_B_t, Register_model[Addr_B_t]);
        error++;
      end 
       
        
     end
        if(error == 0) begin
            $display("All tests passed");
        end else begin
            $display("%0d tests failed.", error);
        end
        $finish;
     
    end
    endmodule