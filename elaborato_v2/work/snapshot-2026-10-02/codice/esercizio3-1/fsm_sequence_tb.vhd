library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_sequence_tb is
end fsm_sequence_tb;

architecture behavioral of fsm_sequence_tb is

    signal clk  : std_logic := '0';
    signal rst  : std_logic := '1';
    signal mode : std_logic := '0';
    signal x    : std_logic := '0';
    signal y    : std_logic;

    constant T : time := 10 ns;

begin

    dut : entity work.fsm_sequence(behavioral)
        port map (clk => clk, rst => rst, mode => mode, x => x, y => y);

    clk_proc : process
    begin
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;

    stim : process
    begin
        rst <= '1'; wait for 2*T;
        rst <= '0';

        -- Test 1: mode 0, 1 0 1 0 1 -> un solo riconoscimento
        mode <= '0';
        x <= '1'; wait for T;
        x <= '0'; wait for T;
        x <= '1'; wait for T;   -- y = 1
        x <= '0'; wait for T;
        x <= '1'; wait for T;   -- y = 0

        rst <= '1'; wait for T; rst <= '0';

        -- Test 2: mode 0, 1 1 0 1 
        mode <= '0';
        x <= '1'; wait for T;
        x <= '1'; wait for T;
        x <= '0'; wait for T;
        x <= '1'; wait for T;   -- y = 1

        rst <= '1'; wait for T; rst <= '0';

        -- Test 3: mode 1, 1 0 1 0 1 
        mode <= '1';
        x <= '1'; wait for T;
        x <= '0'; wait for T;
        x <= '1'; wait for T;   -- y = 1
        x <= '0'; wait for T;
        x <= '1'; wait for T;   -- y = 1

        rst <= '1'; wait for T; rst <= '0';

        -- Test 4: cambio di mode a meta' sequenza -> si torna in S0, nessun riconoscimento
        mode <= '1';
        x <= '1'; wait for T;
        x <= '0'; wait for T;
        mode <= '0';
        x <= '1'; wait for T;   -- y = 0

        wait;
    end process;

end behavioral;