\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // LAB:  CALCULATOR WITH SINGLE VALUE MEMORY
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
                           ($op == 3'b000)? $sum:
                           ($op == 3'b001)? $diff:
                           ($op == 3'b010)? $prod:
                           ($op == 3'b011)? $quot:
                           ($op == 3'b100)? >>2$mem:>>2$out;
            // Mem Mux
            $mem[31:0] = $reset ? 31'b0:
                           ($op == 3'b101) ? $val1[31:0]: >>2$mem;
                           
            


   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
