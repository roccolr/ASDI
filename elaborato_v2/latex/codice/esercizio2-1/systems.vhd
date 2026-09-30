library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;


entity systemS is
    port(
        input: in std_logic_vector(3 downto 0);
        output: out std_logic_vector(3 downto 0)
    );
end systemS;

architecture structural of systemS is
    signal q: std_logic_vector(7 downto 0) := (others => '0');
begin
    MEM: entity work.rom16_8 port map(address => input, data => q); 
    SYSTEM_M: entity work.systemM port map(data_in => q, data_out => output);
    
end structural;
