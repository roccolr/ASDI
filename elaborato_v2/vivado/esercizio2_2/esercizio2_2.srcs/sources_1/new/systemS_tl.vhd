library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity systemS_tl is
    port(
        SW: in std_logic_vector(3 downto 0);
        LED: out std_logic_vector(3 downto 0)
    );
end systemS_tl;

architecture structural of systemS_tl is
    
begin
    SYSTEM_S: entity work.systemS 
        port map( input => SW, output => LED );
end structural;
