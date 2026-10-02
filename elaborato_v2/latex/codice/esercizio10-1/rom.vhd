library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
    generic(
        N : positive := 16; -- locazioni
        A : positive := 4 --bit di address
        -- byte addressable
    );
    port(
        clk: in std_logic;
        rd: in std_logic;
        addr: in std_logic_vector(A-1 downto 0);
        data: out std_logic_vector(7 downto 0)
    );
end rom;

architecture behavioral of rom is
    type rom_t is array(0 to N-1) of std_logic_vector(7 downto 0);
    
    constant CONTENT: rom_t := (
        x"00", x"FF", x"01", x"80",
        x"0F", x"F0", x"AA", x"55"
        --x"7F", x"FE", x"81", x"3C",
        --x"E7", x"10", x"C3", x"5A",
        --others => x"00"
        -- uni 
        -- 0, 8, 1, 1, 
        -- 4, 4, 4. 4,
        -- 7, 7, 2, 4,
        -- 6, 1, 4, 4
    );
    
begin
    
    assert N <= 2**A 
        report "generic error: N non  indirizzabile su A bit"
        severity failure;
    
    -- l'indirizzo viene campionato al fronte    
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rd = '1' then 
                data <= CONTENT(to_integer(unsigned (addr)));
            end if;
        end if;
    end process;     

end behavioral;
