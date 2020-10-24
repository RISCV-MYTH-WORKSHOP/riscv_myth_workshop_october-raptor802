\m4_TLV_version 1d: tl-x.org
\SV

   // This code implements 3 stage pipeline. The counter is changed to a 1-bit counter, MUX is shifted to 2nd stage, $val2 receives 2 clock shifted output signal
   // Also a valid signal is generated. The NOT valid is ORed with Reset is supplied to MUX to output 0 if valid is FALSE or RESET is HIGH
   
   
\TLV
   

   |calc
      @1
         //1-bit counter
         $cnt[31:0] = *reset ? 0                   // 1 if reset
                    : >>1$cnt + 1;  // otherwise add 1 to previous count 
         $valid = >>1$cnt;// valid signal generated
         $val2[31:0] = $rand2[3:0];// to keep input value of lower magnitude
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
         
         $val1[31:0] = >>2$out;
      @2
         // 4 x 1 Multiplexer (Internally implemented by 3 separate 2x1 mux using Divide and conquer) 
         $out[31:0] = (!$valid | *reset) ? 0 :($op[1] ? ($op[0] ? $quot[31:0]:$prod[31:0]):($op[0] ? $diff[31:0]:$sum[31:0]));
         
                    
                    
   

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

