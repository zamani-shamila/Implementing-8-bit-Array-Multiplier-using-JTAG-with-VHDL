

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;




entity InstructionReg is
    Port (
      ClockIR, reset: IN std_logic; 
      TDI: IN std_logic;
      
      ShiftIR, UpdateIR: in std_logic;
      IrCell2Decoder_Out_1, IrCell2Decoder_out_2,IrCell2Decoder_out_3,IrCell2Decoder_out_4: out std_logic;
      IrCell_Out: out std_logic
    
     );
  end InstructionReg;
  
  architecture Behavioral of InstructionReg is
  SIGNAL  IrCell_Out0,IrCell_Out1,IrCell_Out2: std_logic;

  COMPONENT INstructionRegCell IS
  PORT ( 
        ClockIR, reset: std_logic;
        TDI, ShiftIR: IN std_logic;
        UpdateIR: IN std_logic;
        IrCell2Decoder_Out, IrCell_Out: OUT std_logic
  
  );
END COMPONENT;


  begin
  IR_Reg0: INstructionRegCell
              PORT MAP(
                          ClockIR => ClockIR, reset =>reset,
                          
                          ShiftIR =>ShiftIR, UpdateIR =>UpdateIR,
                          TDI => TDI, 
                          IrCell_Out =>IrCell_Out0, IrCell2Decoder_Out =>IrCell2Decoder_Out_1
              
              );
  IR_Reg1: INstructionRegCell
              PORT MAP(
                          ClockIR => ClockIR, reset =>reset,
                          
                          ShiftIR =>ShiftIR, UpdateIR =>UpdateIR,
                          TDI => IrCell_Out0, 
                          IrCell_Out =>IrCell_Out1, IrCell2Decoder_Out =>IrCell2Decoder_Out_2
                          
                          );
  IR_Reg2: INstructionRegCell
              PORT MAP(
                          ClockIR => ClockIR, reset =>reset,
                          
                          ShiftIR =>ShiftIR, UpdateIR =>UpdateIR,
                          TDI =>IrCell_Out1,
                          IrCell_Out =>IrCell_Out2, IrCell2Decoder_Out =>IrCell2Decoder_Out_3
                                                  
                                                  );
  IR_Reg3: INstructionRegCell
              PORT MAP(
                          ClockIR => ClockIR, reset =>reset,
                          
                          ShiftIR =>ShiftIR, UpdateIR =>UpdateIR,
                          TDI =>IrCell_Out2, 
                          IrCell_Out =>IrCell_Out, IrCell2Decoder_Out =>IrCell2Decoder_Out_4
                                                              
                                                              );
  end Behavioral;

