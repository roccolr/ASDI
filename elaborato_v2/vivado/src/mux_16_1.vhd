library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1 is
    port(
        a: in std_logic_vector(0 to 15);
        s: in std_logic_vector(3 downto 0);
        y: out std_logic
    );
end mux_16_1;

architecture structural of mux_16_1 is
    signal u: std_logic_vector(0 to 3);
begin
    M0: entity work.mux_4_1 port map(a => a(0 to 3), s => s(1 downto 0), y => u(0));
    M1: entity work.mux_4_1 port map(a => a(4 to 7), s => s(1 downto 0), y => u(1));
    M2: entity work.mux_4_1 port map(a => a(8 to 11), s => s(1 downto 0), y => u(2));
    M3: entity work.mux_4_1 port map(a => a(12 to 15), s => s(1 downto 0), y => u(3));
    
    M4: entity work.mux_4_1 port map(a => u, s => s(3 downto 2), y => y);
end structural;
