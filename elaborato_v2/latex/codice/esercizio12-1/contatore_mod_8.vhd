library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contatore_mod_8 is
    port (
        clk_a : in std_logic;
        en : in std_logic;
        tk : out std_logic;
        addr : out std_logic_vector(2 downto 0);
        rst : in std_logic
    );
end contatore_mod_8;

architecture Behavioral of contatore_mod_8 is
    signal count: unsigned(2 downto 0) := (others => '0');
begin
    process (clk_a)
    begin
        if clk_a'event and clk_a = '1' then
            if rst = '1' then
                count <= (others => '0');
            elsif en = '1' then
                if count = 7 then
                    count <= (others => '0');
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    tk <= '1' when en = '1' and count = 7 else '0';
    addr <= std_logic_vector(count);
end Behavioral;
