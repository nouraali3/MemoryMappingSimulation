
module Cache(add,cs,din1,dout,h);

input [21:0] add;
input cs;
input [31:0] din1; ///
output reg [31:0] dout; ///
output reg h;
wire [11:0] index;
wire [7:0] TagInAddress;  
reg [31:0] cache [0:1023]; //
reg [7:0] TagInCache [0:1023];
reg valid [0:1023]; 
integer d;

assign index=  add [13:2];
assign TagInAddress= add [21:14];
//assign TagInCache= cache[index][15:8];
//assign valid=cache[index][16];

initial
begin
for(d=0;d<4096;d=d+1)
valid[d]=0;
end


always@(add)
begin
h=(valid[index]==1 && TagInCache[index]==TagInAddress)? 1:0 ;
if(h==0)
begin
cache[index]=din1 ;
TagInCache[index]=TagInAddress;
valid[index]=1;
dout<=8'bxxxxxxxx;
end
//else if(h==0 && (valid[index]==1 && TagInCache[index]!=TagInAddress))
else if (h==1)
dout=cache[index];

end
endmodule

