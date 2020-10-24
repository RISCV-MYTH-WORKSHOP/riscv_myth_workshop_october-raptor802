\m4_TLV_version 1d: tl-x.org
\SV
//Calculator labs solutions here
// The code below implements calc pipe line with calculator and counter in a single stage pipeline
m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   

   |calc
      @1
         $val2[31:0] = $rand2[3:0];//to keep input val2 to a lower magnitude number
         $sum[31:0] = $val1[31:0] + $val2[31:0];
         $diff[31:0] = $val1[31:0] - $val2[31:0];
         $prod[31:0] = $val1[31:0] * $val2[31:0];
         $quot[31:0] = $val1[31:0] / $val2[31:0];
         // 4 x 1 Mux implementation (used divide and conquer;; 3 separate 2 x1 mux used)
         $out[31:0] = *reset ? 0 :($op[1] ? ($op[0] ? $quot[31:0]:$prod[31:0]):($op[0] ? $diff[31:0]:$sum[31:0]));
         $val1[31:0] = >>1$out;
         $cnt[31:0] = *reset ? 0                   // 1 if reset
                    : >>1$cnt + 1;  // otherwise add 1 to previous count 
         
                    
                    
   
   

   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

