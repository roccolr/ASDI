library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity marco_system is
    port(
        clk: in std_logic;
        rst: in std_logic;
        start: in std_logic;
        addr: in std_logic_vector(2 downto 0);
        data: out std_logic_vector(7 downto 0)
    );
end marco_system;

architecture structural of marco_system is
    signal wire, rts, cts : std_logic;
begin
    sysA: entity work.systemA(structural)
        port map(
            clk => clk, rst => rst, start => start, cts => cts,
            rts => rts, tx => wire
            );
    
    sysB: entity work.systemB(structural)
        port map(
            clk => clk, rst => rst, cts => cts, rts => rts, rx => wire,
            raddr => addr, dout => data
            );
end structural;
