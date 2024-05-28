

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;




ENTITY boundryScell IS
        PORT(

            boundryScell_in, boundryScell_PrevCell_in: IN std_logic;
            ClockDR, UpdateDR:IN std_logic;
            shiftDR, Mode: IN std_logic;
            reset,clock: IN std_logic;
	    boundryScell_out,boundryScell_NexCell_out: OUT std_logic
        );
        
END boundryScell;

ARCHITECTURE behavioral  OF boundryScell IS
SIGNAL D_CapScaFF_reg, Q_CapScaFF_reg, D_outputFF_reg, Q_outputFF_reg, out_CapScaFF_MUX: std_logic;

BEGIN
    --Input BSC Operation #1: Normal

        PROCESS(reset, clock) 
            BEGIN   
                IF(reset='1')THEN
                    Q_outputFF_reg <='0';
		
                ELSIF(Clock'event AND Clock = '1') THEN
                    Q_outputFF_reg <= D_outputFF_reg;
                END IF;
        END PROCESS;
        boundryScell_out <= boundryScell_in WHEN Mode = '0' ELSE
            Q_outputFF_reg;

    
     --Input BSC Operation #3: Update

        D_outputFF_reg    <= Q_CapScaFF_reg when UpdateDR ='1' else Q_outputFF_reg;
    
    --Input BSC Operation #4: Capture
        PROCESS(reset, clock) 
            BEGIN   
                IF(reset='1')THEN
                    Q_CapScaFF_reg <='0';
                ELSIF(Clock'event AND Clock = '1') THEN
                    Q_CapScaFF_reg <= D_CapScaFF_reg;
                END IF;
        END PROCESS;

        out_CapScaFF_MUX <= boundryScell_in  WHEN shiftDR ='0' ELSE 
            boundryScell_PrevCell_in;
        D_CapScaFF_reg <= out_CapScaFF_MUX WHEN ClockDR ='1' ELSE
            Q_CapScaFF_reg;
        -- Input BSC Operation #2: Scan
        boundryScell_NexCell_out <= Q_CapScaFF_reg;


end behavioral ;


