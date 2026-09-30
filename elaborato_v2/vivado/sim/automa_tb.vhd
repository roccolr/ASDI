library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity automa_tb is
end automa_tb;

architecture bench of automa_tb is

    signal i   : std_logic := '0';
    signal CLK : std_logic := '0';
    signal Y   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    clk_proc : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;
    
    dut : entity work.automa(Behavioral)
    port map (
        i   => i,
        CLK => CLK,
        Y   => Y
    );
    
    stim_proc : process
    begin
        i <= '0';
        wait for CLK_PERIOD;

        i <= '1';
        wait for CLK_PERIOD;

        i <= '0';
        wait for CLK_PERIOD;

        i <= '1';
        wait for CLK_PERIOD;

        i <= '0';
        wait for CLK_PERIOD;

        i <= '1';
        wait for CLK_PERIOD;

        i <= '0';
        wait for 3 * CLK_PERIOD;

        wait;
    end process;
end bench;