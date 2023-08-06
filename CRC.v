module CRC (
    input clk,
    input rst,
    input active,
    input [7:0] Data,
    output reg crc_out,
    output reg valid
);


reg [7:0] LFSR;
reg [3:0] count;
wire  feedback;
wire count_done;
reg [7:0] temp;


assign feedback = temp[0]^LFSR[0];

always @(posedge clk or negedge rst) begin
    if (!rst)
        begin
            LFSR <= 8'hD8;
            valid <= 1'b0;
            crc_out<=1'b0;
            temp <= Data;
        end
    else if (active && !count_done) begin
            LFSR[7]<=feedback;
            LFSR[6]<=LFSR[7]^feedback;
            LFSR[5]<=LFSR[6];
            LFSR[4]<=LFSR[5];
            LFSR[3]<=LFSR[4];
            LFSR[2]<=LFSR[3]^feedback;
            LFSR[1]<=LFSR[2];
            LFSR[0]<=LFSR[1];
            temp <= temp >> 1;
            valid=1'b0;
        end
    else if (!active && !count_done) begin
            valid=1'b1;
            {LFSR, crc_out} <= {1'b0, LFSR};
        end
    else begin
        valid <= 1'b0;
        count <= 4'b0;
    end
    end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        count<=4'b0;
    end
    else if (!count_done) begin
        count <= count + 4'b1;
    end
end

assign count_done = (count==4'd8) ? 1'b1 : 1'b0;
endmodule
