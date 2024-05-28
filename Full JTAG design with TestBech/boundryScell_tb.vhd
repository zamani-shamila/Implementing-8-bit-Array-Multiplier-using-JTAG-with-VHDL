library ieee;
use ieee.std_logic_1164.all;

entity tb_boundryScell is
end tb_boundryScell;

architecture tb of tb_boundryScell is

    component boundryScell
        port (boundryScell_in          : in std_logic;
              boundryScell_PrevCell_in : in std_logic;
              ClockDR                  : in std_logic;
              UpdateDR                 : in std_logic;
              shiftDR                  : in std_logic;
              Mode                     : in std_logic;
              reset                    : in std_logic;
              clock                    : in std_logic;
              boundryScell_out,boundryScell_NexCell_out : out std_logic


);
    end component;

    signal boundryScell_in          : std_logic;
    signal boundryScell_PrevCell_in : std_logic;
    signal ClockDR                  : std_logic;
    signal UpdateDR                 : std_logic;
    signal shiftDR                  : std_logic;
    signal Mode                     : std_logic;
    signal reset                    : std_logic;
    signal clock                    : std_logic;
    signal boundryScell_out         : std_logic;
    signal boundryScell_NexCell_out : std_logic;

    constant clock_period : time := 10 ns; -- EDIT Put right period here
    
    SIGNAL TbSimEnded : BOOLEAN;

begin

    dut : boundryScell
    port map (boundryScell_in          => boundryScell_in,
              boundryScell_PrevCell_in => boundryScell_PrevCell_in,
              ClockDR                  => ClockDR,
              UpdateDR                 => UpdateDR,
              shiftDR                  => shiftDR,
              Mode                     => Mode,
              reset                    => reset,
              clock                    => clock,
              boundryScell_out         => boundryScell_out,
              boundryScell_NexCell_out => boundryScell_NexCell_out);

    -- Clock generation
    
    clocking : PROCESS
    BEGIN
      WHILE NOT TbSimEnded LOOP
        clock <= '0', '1' AFTER clock_period / 2;
        WAIT FOR clock_period;
      END LOOP;
      WAIT;
    END PROCESS;
    


    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        boundryScell_in <= '0';
        boundryScell_PrevCell_in <= '0';
        UpdateDR <= '0';
        ClockDR <= '0';
        shiftDR <= '0';
        Mode <= '0';
        --clock <= '0';

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- EDIT Add stimuli here
        wait for 5 * clock_period;

    
    boundryScell_in <= '0';
    boundryScell_PrevCell_in<='1';
    ClockDR <= '1';
    shiftDR <= '1';

    WAIT FOR clock_period;

    UpdateDR <= '1';
    Mode <= '1';

   
    WAIT FOR clock_period;
    Mode <= '0';

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= true;
        wait;
    end process;

end tb;

