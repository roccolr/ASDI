library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity register_M is
    generic(
        M : integer := 8
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        load : in std_logic;
        input: in std_logic_vector(M-1 downto 0);
        output: out std_logic_vector(M - 1 downto 0)
    );
end register_M;

architecture behavioral of register_M is
    signal data : std_logic_vector(M-1 downto 0);
begin
    output <= data;
    
    process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                data <= (others => '0');
            elsif load = '1' then
                data <= input;
            end if; 
        end if;
    end process;
end behavioral;
