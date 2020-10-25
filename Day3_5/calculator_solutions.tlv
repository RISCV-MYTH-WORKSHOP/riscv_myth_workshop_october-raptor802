\m4_TLV_version 1d: tl-x.org
\SV
   // =========================================
   // LAB: 2-CYCLE CALCULATOR WITH VALIDITY _Final Version_3
   // Vizualized in VIZ tab: Giving correct outputs
   // =========================================
   
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/bd1f186fde018ff9e3fd80597b7397a1c862cf15/tlv_lib/calculator_shell_lib.tlv'])

\SV
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
         
           
      
         
         
      ?$valid_or_reset
         @1
            
            //calculator computation
            
            
            
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
            

      
         @2
            
            // 4 x 1 Multiplexer (Internally implemented by 3 seaparate 2x1 mux using Divide and conquer) 
            $out[31:0] = $reset ? 32'b0 :($op[1] ? ($op[0] ? $quot[31:0]:$prod[31:0]):($op[0] ? $diff[31:0]:$sum[31:0]));



      // Macro instantiations for calculator visualization(disabled by default).
      // Uncomment to enable visualisation, and also,
      // NOTE: If visualization is enabled, $op must be defined to the proper width using the expression below.
      //       (Any signals other than $rand1, $rand2 that are not explicitly assigned will result in strange errors.)
      //       You can, however, safely use these specific random signals as described in the videos:
      //  o $rand1[3:0]
      //  o $rand2[3:0]
      //  o $op[x:0]
      
   m4+cal_viz(@3) // Arg: Pipeline stage represented by viz, should be atleast equal to last stage of CALCULATOR logic.

   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   

\SV
   endmodule

