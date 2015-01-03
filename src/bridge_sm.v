`timescale 1ns / 1ps


module bridge_sm(
    input GPS_I0,
    input GPS_I1,
    input GPS_Q0,
    input GPS_Q1,
    input MCU_CLK_25_000,
	 input RESET,
    output MCU_SCK,
    output MCU_SS,
    output MCU_MOSI
    );

	reg bitcount_en;
   reg [7:0] bitcounter;
   
	// Ok...maybe we don't need bitcount_en...it's there for now.
   always @(posedge MCU_CLK_25_000)
      if (RESET)
         bitcounter <= 0xFF;
      else if (bitcount_en)
         bitcounter <= bitcounter - 1;
					
   parameter start_st  = 4'b0000;
   parameter <state2>  = 4'b0001;
   parameter <state3>  = 4'b0010;
   parameter <state4>  = 4'b0011;
   parameter <state5>  = 4'b0100;
   parameter <state6>  = 4'b0101;
   parameter <state7>  = 4'b0110;
   parameter <state8>  = 4'b0111;
   parameter <state9>  = 4'b1000;
   parameter <state10> = 4'b1001;
   parameter <state11> = 4'b1010;
   parameter <state12> = 4'b1011;
   parameter <state13> = 4'b1100;
   parameter <state14> = 4'b1101;
   parameter <state15> = 4'b1110;
   parameter <state16> = 4'b1111;

   (* FSM_ENCODING="SEQUENTIAL", SAFE_IMPLEMENTATION="YES", SAFE_RECOVERY_STATE="<recovery_state_value>" *) reg [3:0] state = <state1>;

   always@(posedge <clock>)
      if (<reset>) begin
         state <= <state1>;
         <outputs> <= <initial_values>;
      end
      else
         (* PARALLEL_CASE, FULL_CASE *) case (state)
            start_st : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state2> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state3> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state4> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state5> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state6> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state7> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state8> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state9> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state10> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state11> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state12> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state13> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state14> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state15> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            <state16> : begin
               if (<condition>)
                  state <= <next_state>;
               else if (<condition>)
                  state <= <next_state>;
               else
                  state <= <next_state>;
               <outputs> <= <values>;
            end
            default : begin  // Fault Recovery
               state <= <state1>;
               <outputs> <= <values>;
            end   
         endcase
							
endmodule
