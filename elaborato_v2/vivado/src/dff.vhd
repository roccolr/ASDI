library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    port(
        clk: in std_logic; 
        rst: in std_logic;  -- sincrono
        d: in std_logic;
        q: out std_logic
    );
end dff;

architecture behavioral of dff is
    
begin
    process(clk)
    begin 
    if clk'event and clk = '1' then
        if rst = '1' then
            q <= '0';
        else 
            q <= d;
        end if;
    end if;
end process;
    
end behavioral;
