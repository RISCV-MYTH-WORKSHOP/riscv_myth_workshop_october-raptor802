\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // LAB: 2-CYCLE CALCULATOR WITH VALIDITY _Final Version
   // =========================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @0
         $reset = *reset;
      @1
         
         $valid = $reset? 1'b0: >>1$valid + 1'b1;
         $valid_or_reset = $valid || $reset;
         //$valid_or_reset =$valid || $reset;
         $cnt[31:0] = $reset ? '0                   // 1 if reset
                       : >>1$cnt + 1;  // otherwise add 1 to previous count 
         $val2[31:0] = $rand2[3:0];// to keep input value of lower magnitude
         $val1[31:0] = >>2$out;
         
           
      
         
         
      ?$valid
         @1
            
            //1-bit counter
            
            
            
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
            

      
         @2
            
            // 4 x 1 Multiplexer (Internally implemented by 3 seaparate 2x1 mux using Divide and conquer) 
            $out[31:0] = $reset ? 0 :($op[1] ? ($op[0] ? $quot[31:0]:$prod[31:0]):($op[0] ? $diff[31:0]:$sum[31:0]));


   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

