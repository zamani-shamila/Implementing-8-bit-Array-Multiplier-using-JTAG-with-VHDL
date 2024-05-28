library ieee;
use ieee.std_logic_1164.all;

entity tb_boundrySReg is
end tb_boundrySReg;

architecture tb of tb_boundrySReg is

    component boundrySReg
        port (boundryScell_in1 : in std_logic_vector (7 downto 0);
              boundryScell_in2 : in std_logic_vector (7 downto 0);
              ClockDR          : in std_logic;
              UpdateDR         : in std_logic;
              shiftDR          : in std_logic;
              Mode             : in std_logic;
              reset            : in std_logic;
              clock            : in std_logic;
              TDI              : in std_logic;
              boundrySReg_out  : out std_logic;
              boundryScell_out : out std_logic_vector (15 downto 0));
    end component;

    signal boundryScell_in1 : std_logic_vector (7 downto 0);
    signal boundryScell_in2 : std_logic_vector (7 downto 0);
    signal ClockDR          : std_logic;
    signal UpdateDR         : std_logic;
    signal shiftDR          : std_logic;
    signal Mode             : std_logic;
    signal reset            : std_logic;
    signal clock            : std_logic;
    signal TDI              : std_logic;
    signal boundrySReg_out  : std_logic;
    signal boundryScell_out : std_logic_vector (15 downto 0);

    constant clock_period : time := 10 ns; 

    SIGNAL TbSimEnded : BOOLEAN;

begin

    dut : boundrySReg
    port map (boundryScell_in1 => boundryScell_in1,
              boundryScell_in2 => boundryScell_in2,
              ClockDR          => ClockDR,
              UpdateDR         => UpdateDR,
              shiftDR          => shiftDR,
              Mode             => Mode,
              reset            => reset,
              clock            => clock,
              TDI              => TDI,
              boundrySReg_out  => boundrySReg_out,
              boundryScell_out => boundryScell_out);

    -- Clock generation

    clocking : PROCESS
    BEGIN
      WHILE NOT TbSimEnded LOOP
        Clock <= '0', '1' AFTER clock_period / 2;
        WAIT FOR clock_period;
      END LOOP;
      WAIT;
    END PROCESS;

    stimuli : process
    begin
        -- initialization 
        boundryScell_in1 <= (others => '0');
        boundryScell_in2 <= (others => '0');
        UpdateDR <= '0';
        shiftDR <= '0';
        Mode <= '0';
        ClockDR <= '0';
        TDI <= '0';

        -- Reset generation
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        wait for 100 * clock_period;


	-------------------------------
         --     shiftDR <= '0';       
        --     Mode <= '1';       
        --     ClockDR <= '1';     
        --     UpdateDR <= '0';    
        --     TDI <= '1';             
        --     wait for 32*clock_period;
        -- TDI <= '0';
        -- wait for 5*clock_period;
        -- TDI <= '1';
        --     Mode <= '1';       
        --     ClockDR <= '0';     
        --     UpdateDR <= '1';    
        --     wait for 5*clock_period;
	-------------------------------

	Mode <= '1';  
	wait for clock_period;
	shiftDR <= '0';       
                 
            ClockDR <= '1';     
            UpdateDR <= '1';    
            TDI <= '1';             
            wait for 32*clock_period;
        	--TDI <= '0';
        --wait for 5*clock_period;
	shiftDR <= '1'; 
        TDI <= '1';
            Mode <= '1';       
            ClockDR <= '0';     
            UpdateDR <= '0';    
            wait for 5*clock_period;


        --TDI <= '0';
        --wait for 2*clock_period;
        --TDI <= '1';
        --wait for 2*clock_period;
        --TDI <= '0';
        --wait for 2*clock_period;
        --TDI <= '1';
        --wait for 2*clock_period;
        --TDI <= '0';
        --wait for 2*clock_period;

	
        --ClockDR <= '0';       
        --UpdateDR <= '1';       
        --wait for 2*clock_period*2;
        --Mode <= '1';          

        -- Stop the clock and terminate the simulation
        TbSimEnded <= true;
       
        wait;
    end process;

end tb;

