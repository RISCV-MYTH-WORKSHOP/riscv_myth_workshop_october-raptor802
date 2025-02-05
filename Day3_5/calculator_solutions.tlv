\m4_TLV_version 1d: tl-x.org
\SV
   // =========================================
   // Final Lab Day -3 
   //LAB:  2-CYCLE CALCULATOR WITH SINGLE VALUE MEMORY
   // Visualised in Viz tabs: giving correct outputs
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
         
         $val2[31:0] = $rand2[3:0];// to keep input value of lower magnitude
         $val1[31:0] = >>2$out;
         
           
      
         
         
      ?$valid_or_reset
         @1
            
            
            
            
            // calculator computation
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
            

      
         @2
            
            // 4 x 1 Multiplexer  
            $out[31:0] = $reset ? 32'b0:
                           ($op[2:0] == 3'b000)? $sum:
                           ($op[2:0] == 3'b001)? $diff:
                           ($op[2:0] == 3'b010)? $prod:
                           ($op[2:0] == 3'b011)? $quot:
                           ($op[2:0] == 3'b100)? >>2$mem:>>2$out;
            // Mem Mux
            $mem[31:0] = $reset ? 32'b0:
                           ($op[2:0] == 3'b101) ? $val1[31:0]: >>2$mem;
                           
            


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

