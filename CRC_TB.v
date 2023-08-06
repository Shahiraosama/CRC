`timescale 1ns/1ps
`timescale 1ns/1ps
module CRC_tb;
    reg clk_tb, rst_tb, active_tb;
    reg [7:0] Data_tb;
    wire crc_out_tb, valid_tb;

    CRC DUT (
        .clk(clk_tb),
        .rst(rst_tb),
        .active(active_tb),
        .Data(Data_tb),
        .crc_out(crc_out_tb),
        .valid(valid_tb)
    );
localparam T=100;

    always begin
        #(T/2) clk_tb=~clk_tb;
    end

   reg [7:0] Data_Test [0:9];
   reg [7:0] Expected_out[0:9]; 
   
   integer i;

initial 
begin
        $dumpfile("CRC.vcd");
        $dumpvars;
        initialize();



$readmemh("DATA_h.txt",Data_Test);
$readmemh ("Expec_Out_h.txt",Expected_out); 

       

        for (i=0; i<10;i=i+1)
          begin
         
        Data_tb=Data_Test[i];
        reset();
        #(T/10) 
        active_tb=1'b1;
        
        #(8*T)
       
 if ( DUT.LFSR == Expected_out[i] )

begin
   $display("Test Case %d is succeeded",i+1);
end     

else

begin 
     $display("Test Case %d is failed",i+1);
end

end


 #10 $finish;

end
         

task initialize ;
begin
clk_tb=1'b0;
active_tb =1'b0;
Data_tb=8'hd8;
end
endtask
 
       
task reset;
begin
rst_tb=1'b0;
#(T/10) 
rst_tb=1'b1;
end
endtask


   
endmodule
