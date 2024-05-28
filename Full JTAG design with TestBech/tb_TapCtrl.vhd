

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;





ENTITY tb_TapCtrl IS
 
END tb_TapCtrl;




architecture Behavioral of tb_TapCtrl IS

COMPONENT TapCtrl IS
  Port (
        TMS: IN std_logic;
        TRST, TCK: IN std_logic; --TCK = ClOCk , --TRST = Reset
        ShiftIR, UpdateIR : out std_logic;
        
		Select_MUX: out std_logic;
        ClockDR, ShiftDR, UpdateDR: out std_logic
   );
END COMPONENT;


    SIGNAL TMS:  std_logic:= '0';
    SIGNAL reset: std_logic:= '0';
    SIGNAL clock: std_logic:= '0'; 
    SIGNAL ShiftIR: std_logic:= '0';
    SIGNAL UpdateIR : std_logic:= '0';

    SIGNAL Select_MUX: std_logic:= '0';
    SIGNAL ClockDR: std_logic:= '0';
    SIGNAL ShiftDR: std_logic:= '0';
    SIGNAL UpdateDR: std_logic:= '0';
    constant clock_period: time :=10ns;
    SIGNAL TbSimEnded : BOOLEAN;

    

BEGIN


    Tap0:  TapCtrl 
        PORT MAP(

            TMS => TMS,
            TRST=>reset,
            TCK=>clock,
            ShiftIR=>ShiftIR, 
            Select_MUX=>Select_MUX, 
            UpdateIR=>UpdateIR ,
            ClockDR=>ClockDR, 
            ShiftDR=>ShiftDR, 
            UpdateDR =>UpdateDR
        );

clocking : PROCESS
    BEGIN
      WHILE NOT TbSimEnded LOOP
        clock <= '0', '1' AFTER clock_period / 2;
        WAIT FOR clock_period;
      END LOOP;
      WAIT;
    END PROCESS;



    
    stimulus: process
    begin
    reset  <='1';
    wait for clock_period*5;
    reset <= '0';
    wait for clock_period*2;




    -- --- EXTEST
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- ------ SP
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;       
    -- --- BYPASS
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;

    
    -- -- BSC and TAP Controller (1) slide 7
    
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '0';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for clock_period;
    -- TMS <= '1';
    -- wait for 5*clock_period;


    -- - Reset
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    -- BSC and TAP Controller (2) slide 8

    TMS <= '0';
    wait for clock_period;
    TMS <= '0';
    wait for clock_period;
    TMS <= '0';
    wait for clock_period;
    TMS <= '0';
    wait for clock_period;
    TMS <= '0';
    wait for clock_period;
    TMS <= '0';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    TMS <= '0';
    wait for 5*clock_period;
    

    --- Reset
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    TMS <= '1';
    wait for clock_period;
    -- Stop the clock and hence terminate the simulation
    TbSimEnded <= true;
   
   wait;
    end process;




end Behavioral;