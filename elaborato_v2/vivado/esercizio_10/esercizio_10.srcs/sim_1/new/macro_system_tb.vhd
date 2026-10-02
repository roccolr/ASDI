library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity macro_system_tb is
--  Port ( );
end macro_system_tb;

architecture Behavioral of macro_system_tb is
    signal start : std_logic := 'U';
    signal addr : std_logic_vector(2 downto 0);
    signal data : std_logic_vector(7 downto 0);
    signal clk: std_logic;
    signal rst: std_logic := 'U';
    constant T : time := 10 ns;
begin
    dut: entity work.marco_system(structural)
        port map(
            clk => clk, rst => rst, start => start, addr => addr,
            data => data
            );
    clock: process
    begin
        clk <= '0'; wait for T/2;
        clk <= '1'; wait for T/2;
    end process;
    
    stim: process
    begin
        rst <= '1'; wait for T;
        rst <= '0';
        wait for T;
        
        start <= '1';
        wait for 3*T;
        start <= '0';
        wait for 2*T;
        
        
        for i in 2 downto 0 loop
            addr <= std_logic_vector(to_unsigned(i, 3));
            wait for T;
        end loop;
        wait;
    end process;
    
end Behavioral;
