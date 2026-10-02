library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity onecount is
    port (
        x: in std_logic_vector(7 downto 0);
        y: out std_logic_vector(3 downto 0)
    );
end onecount;

architecture behavioral of onecount is
    
begin
    process(x) 
        variable n : unsigned(3 downto 0);
    begin
        n := (others => '0');
        for i in 7 downto 0 loop 
            if x(i) = '1' then
                n := n+1;
            end if;
        end loop;
        y <= std_logic_vector(n);
    end process;
end behavioral;
