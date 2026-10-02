library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_8_4 is
    port (
        clk_a : in std_logic;
        rd : in std_logic;
        addr: in std_logic_vector(2 downto 0);
        data: out std_logic_vector(3 downto 0)
    );
end ROM_8_4;

architecture Behavioral of ROM_8_4 is
    type ROM_8_4 is array (0 to 7) of std_logic_vector(3 downto 0);
    signal rom : ROM_8_4 :=     (
                                x"0", x"1", x"2", x"3",
                                x"4", x"5", x"6", x"7"
                                );
    
begin
    process (clk_a)
    begin
        if clk_a'event and clk_a = '1' then
            if rd = '1' then
                data <= rom(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
end Behavioral;
