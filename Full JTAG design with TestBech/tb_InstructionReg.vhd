


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;






entity tb_InstructionReg is
end tb_InstructionReg;

architecture tb of tb_InstructionReg is

    component InstructionReg
        port (ClockIR              : in std_logic;
              reset                : in std_logic;
              TDI                  : in std_logic;
              ShiftIR              : in std_logic;
              UpdateIR             : in std_logic;
              IrCell2Decoder_Out_1 : out std_logic;
              IrCell2Decoder_out_2 : out std_logic;
              IrCell2Decoder_out_3 : out std_logic;
              IrCell2Decoder_out_4 : out std_logic;
              IrCell_Out           : out std_logic);
    end component;

    signal ClockIR              : std_logic;
    signal reset                : std_logic;
    signal TDI                  : std_logic;
    signal ShiftIR              : std_logic;
    signal UpdateIR             : std_logic;
    signal IrCell2Decoder_Out_1 : std_logic;
    signal IrCell2Decoder_out_2 : std_logic;
    signal IrCell2Decoder_out_3 : std_logic;
    signal IrCell2Decoder_out_4 : std_logic;
    signal IrCell_Out           : std_logic;

    constant clock_period : time := 10 ns; -- EDIT Put right period here
    
    SIGNAL TbSimEnded : BOOLEAN;

begin

    dut : InstructionReg
    port map (ClockIR              => ClockIR,
              reset                => reset,
              TDI                  => TDI,
              ShiftIR              => ShiftIR,
              UpdateIR             => UpdateIR,
              IrCell2Decoder_Out_1 => IrCell2Decoder_Out_1,
              IrCell2Decoder_out_2 => IrCell2Decoder_out_2,
              IrCell2Decoder_out_3 => IrCell2Decoder_out_3,
              IrCell2Decoder_out_4 => IrCell2Decoder_out_4,
              IrCell_Out           => IrCell_Out);

    -- Clock generation
    
    
    clocking : PROCESS
    BEGIN
      WHILE NOT TbSimEnded LOOP
        ClockIR <= '0', '1' AFTER clock_period / 2;
        WAIT FOR clock_period;
      END LOOP;
      WAIT;
    END PROCESS;  
			  
			  
			  

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        TDI <= '0';
        ShiftIR <= '0';
        UpdateIR <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * clock_period;


        ShiftIR <= '1';         -- enable for shift
        wait for clock_period;
        UpdateIR  <= '0';
        wait for clock_period*6;
        ShiftIR <='0';
        TDI <='1';
        wait for clock_period;
        ShiftIR <= '1';
        wait for clock_period;




        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= true;
        wait;
    end process;

end tb;