library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;




ENTITY INstructionRegCell IS
  PORT ( 
        ClockIR, reset: std_logic;
        TDI, ShiftIR: IN std_logic;
        UpdateIR: IN std_logic;
        IrCell2Decoder_Out, IrCell_Out: OUT std_logic
  
  );
END INstructionRegCell;

architecture Behavioral of INstructionRegCell is
signal D_CapScaFF_Ir, Q_CapScaFF_Ir, D_outputFF_Ir, Q_outputFF_Ir: std_logic;

begIN
process(reset,ClockIR)
begIN   
    if (reset ='1')then 
    Q_CapScaFF_Ir <= '0';
    elsif (ClockIR'event and ClockIR='1') then 
    Q_CapScaFF_Ir <= D_CapScaFF_Ir;
    end if;
    end process;
    D_CapScaFF_Ir <= TDI when ShiftIR ='1' else Q_CapScaFF_Ir;




process(ClockIR, reset)
begIN
    if (reset ='1') then 
    Q_outputFF_Ir <= '0';
    elsif  (ClockIR'event and ClockIR='1') then
    Q_outputFF_Ir <= D_outputFF_Ir;
    end if;
    end process;
    D_outputFF_Ir <= Q_CapScaFF_Ir when UpdateIR ='1' else Q_outputFF_Ir;
    IrCell2Decoder_Out<= Q_outputFF_Ir;
    IrCell_Out <= Q_CapScaFF_Ir;
    
         

end Behavioral;