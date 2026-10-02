library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro_6 is
    port (
        clk_b : in std_logic;
        sum : in std_logic_vector(5 downto 0);
        load : in std_logic;
        rst : in std_logic;
        data_out : out std_logic_vector(5 downto 0)
    );
end registro_6;

architecture Behavioral of registro_6 is
    signal reg : std_logic_vector(5 downto 0) := (others => '0');
begin
    process (clk_b)
    begin
        if clk_b'event and clk_b = '1' then
            if rst = '1' then
                reg <= (others => '0');
            elsif load = '1' then 
                reg <= sum;
            end if;
        end if;
    end process;
    data_out <= reg;
end Behavioral;
