
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;



entity BypassReg is
	Port ( reset,clock: IN std_logic;
	   TDI,shiftDR: IN std_logic;
       	   ClockDR: IN std_logic;
            BypassReg_OUT: OUT std_logic
    );
end BypassReg;

architecture Behavioral of BypassReg is
	signal Q_BypassReg_reg, D_BypassReg_reg, BypassReg_Reg_OUT: std_logic;

COMPONENT myAND is
  Port ( a : in STD_LOGIC;
  b : in STD_LOGIC;
  Y : out STD_LOGIC);
end COMPONENT;
	
	begin
        --Capture/Shift part
		
		And0:myAND
		 PORT MAP(
           
            a => shiftDR, b => TDI,
            Y => BypassReg_Reg_OUT
        );
		
		PROCESS(reset, clock) 
            BEGIN   
                IF(reset='1')THEN
                    Q_BypassReg_reg <='0';
                ELSIF(Clock'event AND Clock = '1') THEN
                    Q_BypassReg_reg <= D_BypassReg_reg;
                END IF;
        END PROCESS;
		
				

        D_BypassReg_reg <= BypassReg_Reg_OUT when ClockDR = '1' else Q_BypassReg_reg;
        
 
        
       
        BypassReg_OUT <= Q_BypassReg_reg;

end Behavioral;
