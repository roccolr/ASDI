library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_sequence_tb is
end fsm_sequence_tb;

architecture bench of fsm_sequence_tb is

    signal A   : std_logic := '0';
    signal rst : std_logic := '1';
    signal M   : std_logic := '0';
    signal i   : std_logic := '0';
    signal Y   : std_logic;

    constant T : time := 10 ns;

begin

    dut : entity work.fsm_sequence(behavioral)
        port map (i => i, M => M, A => A, rst => rst, Y => Y);

    clk_proc : process
    begin
        A <= '0'; wait for T/2;
        A <= '1'; wait for T/2;
    end process;

    stim : process
    begin
        rst <= '1'; wait for 2*T;
        rst <= '0';

        -- Test 1: M = 1, 0 1 0 1 0 1 -> riconosciuto al 4o bit
        M <= '1';
        i <= '0'; wait for T;
        i <= '1'; wait for T;
        i <= '0'; wait for T;
        i <= '1'; wait for T;   -- Y = 1
        i <= '0'; wait for T;
        i <= '1'; wait for T;   -- Y = 0: l'1 finale e' stato scartato

        rst <= '1'; wait for T; rst <= '0';

        -- Test 2: M = 0, 010 | 101 -> riconosciuto al 6o bit
        M <= '0';
        i <= '0'; wait for T;
        i <= '1'; wait for T;
        i <= '0'; wait for T;   -- fine del primo gruppo, perso
        i <= '1'; wait for T;
        i <= '0'; wait for T;
        i <= '1'; wait for T;   -- Y = 1

        rst <= '1'; wait for T; rst <= '0';

        -- Test 3: M = 1, 1 1 0 1 -> riconosciuto grazie all'autoanello su S1
        M <= '1';
        i <= '1'; wait for T;
        i <= '1'; wait for T;
        i <= '0'; wait for T;
        i <= '1'; wait for T;   -- Y = 1

        rst <= '1'; wait for T; rst <= '0';

        -- Test 4: cambio di modo a meta' sequenza, nessun bit perso
        M <= '0';
        i <= '1'; wait for T;   -- G1
        i <= '0'; wait for T;   -- G2
        M <= '1';
        i <= '1'; wait for T;   -- modo cambiato: si comporta come S0 -> S1
        i <= '0'; wait for T;   -- S2
        i <= '1'; wait for T;   -- Y = 1

        wait;
    end process;

end bench;