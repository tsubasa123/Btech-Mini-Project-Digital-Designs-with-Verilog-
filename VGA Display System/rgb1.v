`timescale 1ns / 1ps
module rgb1(input clk,
		input rst,
		input [2:0] switch,
		output reg red,green,blue,
		output reg hsync,vsync,
		output reg [10:0] hcount1,
		output reg [9:0] vcount1
    );
reg sync_h, sync_v, fp_h, fp_v, bp_h, bp_v,clk11,q;	 
reg [2:0] pr_state, nx_state;
parameter black_state = 3'b000;
parameter blue_state = 3'b001;
parameter green_state = 3'b010;
parameter cyan_state = 3'b011;
parameter red_state = 3'b100;
parameter magenta_state = 3'b101;
parameter yellow_state = 3'b110;
parameter white_state = 3'b111;
reg [10:0] hcount;
reg [9:0] vcount;

always @ (posedge clk or posedge rst)
begin
	if (rst) 
		begin
			hcount1 <= 0 ;
			vcount1<= 0 ;
			
		end
	else 
		begin
			hcount1 <= hcount;
			

			vcount1 <= vcount;
		end
end

always @ (posedge clk or posedge rst)   // clock divider
begin
	if (rst) 
		begin
			clk11 <= 0 ;
			q <= 0 ;
			
		end
	else 
		begin
			q <= ~clk11 ;
			clk11 <= ~clk11;
		end
end

//hcounter:
always @ (posedge q or posedge rst)
begin
	if (rst) 
		begin
			hcount <= 0 ;
			vcount <= 0 ;
		end
	else 
		begin
            if (hcount == 799) 
				begin
                hcount <= 0;
					 if (vcount == 520)  
                    vcount <= 0;
					else 
                vcount <= vcount + 1;
				 end
            else 
                hcount <= hcount + 1;
       end

//sync:
 
	if (rst) 
	begin
              sync_h <= 0;
			  sync_v <= 0;
	end
	else 
		begin
            if (hcount <= 751 && hcount>=656) 
               sync_h <= 0;
            else 
               sync_h <= 1;

            if (vcount<=491 && vcount>=490) 
					sync_v <= 0;
            else 
					sync_v <= 1;
            hsync <= sync_h;
			vsync <= sync_v;	

       end
		 
//front_porch:
	if (rst) 
	begin
       fp_h <= 0;
       fp_v <= 0;
	end
	else 
		begin
				if (hcount<=655 && hcount>=640)
						fp_h <= 1;
				else 
						fp_h <= 0;
				if (vcount<=489 && vcount>=480) 
						fp_v <= 1;
				else 
						fp_v <= 0;            
       end		 
//back_porch:
	if (rst) 
	begin
       bp_h <= 0;
       bp_v <= 0;
	end
	else 
		begin
			if (hcount<=799 && hcount>=752) 
					bp_h <= 1;
			else 
					bp_h <= 0;
			if (vcount<=520 && vcount>=492)  
					bp_v <= 1;
			else 
					bp_v <= 0;
       end		 
end


//colors: 
always @ (posedge q or posedge rst)
begin

    if (rst==1'b1)
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
			nx_state <= 0;

		end
    else if (sync_h==1'b0) 
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
		end
    else if (sync_v == 0) 
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
		end 
    else if (fp_h == 1 ) 
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
		end
    else if (fp_v == 1)
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
		end
    else if (bp_h == 1)
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
		end
    else if (bp_v == 1) 
		begin
			red <= 1'b0;
		   green <= 0;
			blue <= 0;
		end
    else 
		begin
		case (switch)
		3'b000:
				case (pr_state) 	
					black_state :    //black
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
								if(hcount == 79)
								nx_state <= blue_state;
								
							end
					
					blue_state: //blue
							begin
								red <= 0;
								green <= 0;
								blue <= 1;
								if(hcount == 159)
								nx_state<=green_state;
							end
					green_state: //green
							begin
								red <= 0;
								green <= 1;
								blue <= 0;
						if(hcount == 239)
								nx_state<=cyan_state;
							end
							
					cyan_state: //cyan
							begin
								red <= 0;
								green <= 1;
								blue <= 1;
							if(hcount == 319)
								nx_state<=red_state;
							end
							
					red_state: //red
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
						if(hcount == 399)
								nx_state<=magenta_state;
							end
							
					magenta_state: //magenta
							begin
								red <= 1;
								green <= 0;
								blue <= 1;
						if(hcount == 479)
								nx_state<=yellow_state;
							end
					yellow_state: //yellow
							begin
								red <= 1;
								green <= 1;
								blue <= 0;
							if(hcount == 559)
								nx_state<=white_state;
							end
					white_state: //white
							begin
								red <= 1;
								green <= 1;
								blue <= 1;
								if(hcount == 559)
								nx_state<=black_state;
							end
						default:
							begin			
							red <= 0;
							green <= 0;
							blue <= 0;	
							
							end
				endcase
		3'b001:
				case (pr_state) 	
					black_state :    //black
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
								if(hcount == 79)
								nx_state <= cyan_state;
								
							end
					
					blue_state: //blue
							begin
								red <= 0;
								green <= 0;
								blue <= 1;
								if(hcount == 159)
								nx_state<=green_state;
							end
					green_state: //green
							begin
								red <= 0;
								green <= 1;
								blue <= 0;
						if(hcount == 239)
								nx_state<=cyan_state;
							end
							
					cyan_state: //cyan
							begin
								red <= 0;
								green <= 1;
								blue <= 1;
							if(hcount == 319)
								nx_state<=red_state;
							end
							
					red_state: //red
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
						if(hcount == 399)
								nx_state<=magenta_state;
							end
							
					magenta_state: //magenta
							begin
								red <= 1;
								green <= 0;
								blue <= 1;
						if(hcount == 479)
								nx_state<=yellow_state;
							end
					yellow_state: //yellow
							begin
								red <= 1;
								green <= 1;
								blue <= 0;
							if(hcount == 559)
								nx_state<=white_state;
							end
					white_state: //white
							begin
								red <= 1;
								green <= 1;
								blue <= 1;
								if(hcount == 559)
								nx_state<=black_state;
							end
						default:
							begin			
							red <= 0;
							green <= 0;
							blue <= 0;	
							
							end
				endcase
		3'b010:
				case (pr_state) 	
					black_state :    //black
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
								if(hcount == 79)
								nx_state <= red_state;
								
							end
					
					blue_state: //blue
							begin
								red <= 0;
								green <= 0;
								blue <= 1;
								if(hcount == 159)
								nx_state<=green_state;
							end
					green_state: //green
							begin
								red <= 0;
								green <= 1;
								blue <= 0;
						if(hcount == 239)
								nx_state<=cyan_state;
							end
							
					cyan_state: //cyan
							begin
								red <= 0;
								green <= 1;
								blue <= 1;
							if(hcount == 319)
								nx_state<=red_state;
							end
							
					red_state: //red
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
						if(hcount == 399)
								nx_state<=magenta_state;
							end
							
					magenta_state: //magenta
							begin
								red <= 1;
								green <= 0;
								blue <= 1;
						if(hcount == 479)
								nx_state<=yellow_state;
							end
					yellow_state: //yellow
							begin
								red <= 1;
								green <= 1;
								blue <= 0;
							if(hcount == 559)
								nx_state<=white_state;
							end
					white_state: //white
							begin
								red <= 1;
								green <= 1;
								blue <= 1;
								if(hcount == 559)
								nx_state<=black_state;
							end
						default:
							begin			
							red <= 0;
							green <= 0;
							blue <= 0;	
							
							end
				endcase
		3'b011:
				case (pr_state) 	
					black_state :    //black
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
								if(hcount == 79)
								nx_state <= yellow_state;
								
							end
					
					blue_state: //blue
							begin
								red <= 0;
								green <= 0;
								blue <= 1;
								if(hcount == 159)
								nx_state<=green_state;
							end
					green_state: //green
							begin
								red <= 0;
								green <= 1;
								blue <= 0;
						if(hcount == 239)
								nx_state<=cyan_state;
							end
							
					cyan_state: //cyan
							begin
								red <= 0;
								green <= 1;
								blue <= 1;
							if(hcount == 319)
								nx_state<=red_state;
							end
							
					red_state: //red
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
						if(hcount == 399)
								nx_state<=magenta_state;
							end
							
					magenta_state: //magenta
							begin
								red <= 1;
								green <= 0;
								blue <= 1;
						if(hcount == 479)
								nx_state<=yellow_state;
							end
					yellow_state: //yellow
							begin
								red <= 1;
								green <= 1;
								blue <= 0;
							if(hcount == 559)
								nx_state<=white_state;
							end
					white_state: //white
							begin
								red <= 1;
								green <= 1;
								blue <= 1;
								if(hcount == 559)
								nx_state<=black_state;
							end
						default:
							begin			
							red <= 0;
							green <= 0;
							blue <= 0;	
							
							end
				endcase
		3'b100:
				case (pr_state) 	
					black_state :    //black
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
								if(hcount == 79)
								nx_state <= white_state;
								
							end
					
					blue_state: //blue
							begin
								red <= 0;
								green <= 0;
								blue <= 1;
								if(hcount == 159)
								nx_state<=green_state;
							end
					green_state: //green
							begin
								red <= 0;
								green <= 1;
								blue <= 0;
						if(hcount == 239)
								nx_state<=cyan_state;
							end
							
					cyan_state: //cyan
							begin
								red <= 0;
								green <= 1;
								blue <= 1;
							if(hcount == 319)
								nx_state<=red_state;
							end
							
					red_state: //red
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
						if(hcount == 399)
								nx_state<=magenta_state;
							end
							
					magenta_state: //magenta
							begin
								red <= 1;
								green <= 0;
								blue <= 1;
						if(hcount == 479)
								nx_state<=yellow_state; 
							end
					yellow_state: //yellow
							begin
								red <= 1;
								green <= 1;
								blue <= 0;
							if(hcount == 559)
								nx_state<=white_state;
							end
					white_state: //white
							begin
								red <= 1;
								green <= 1;
								blue <= 1;
								if(hcount == 559)
								nx_state<=black_state;
							end
						default:
							begin			
							red <= 0;
							green <= 0;
							blue <= 0;	
							
							end
				endcase
		default:
				case (pr_state) 	
					black_state :    //black
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
								if(hcount == 79)
								nx_state <= blue_state;
								
							end
					
					blue_state: //blue
							begin
								red <= 0;
								green <= 0;
								blue <= 1;
								if(hcount == 159)
								nx_state<=green_state;
							end
					green_state: //green
							begin
								red <= 0;
								green <= 1;
								blue <= 0;
						if(hcount == 239)
								nx_state<=cyan_state;
							end
							
					cyan_state: //cyan
							begin
								red <= 0;
								green <= 1;
								blue <= 1;
							if(hcount == 319)
								nx_state<=red_state;
							end
							
					red_state: //red
							begin
								red <= 1;
								green <= 0;
								blue <= 0;
						if(hcount == 399)
								nx_state<=magenta_state;
							end
							
					magenta_state: //magenta
							begin
								red <= 1;
								green <= 0;
								blue <= 1;
						if(hcount == 479)
								nx_state<=yellow_state;
							end
					yellow_state: //yellow
							begin
								red <= 1;
								green <= 1;
								blue <= 0;
							if(hcount == 559)
								nx_state<=white_state;
							end
					white_state: //white
							begin
								red <= 1;
								green <= 1;
								blue <= 1;
								if(hcount == 559)
								nx_state<=black_state;
							end
						default:
							begin			
							red <= 0;
							green <= 0;
							blue <= 0;	
							
							end
				endcase
		endcase

	end
end
always@(posedge q or posedge rst)
begin
		if(rst)
		begin
				pr_state <= 0;
		end
		else
		begin
				pr_state <= nx_state;
	   end
end		 


endmodule