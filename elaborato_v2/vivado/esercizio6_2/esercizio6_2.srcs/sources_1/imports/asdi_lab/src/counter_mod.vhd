library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_mod is
    generic (
        M: positive := 60; -- modulo
        W: positive := 6   -- numero bit uscita
    );
    port (
        clk: in std_logic;
        rst: in std_logic; -- sincrono 
        en: in std_logic; -- 1 -> avanza di uno
        load: in std_logic; -- carica d
        d: in std_logic_vector(W-1 downto 0); 
        q: out std_logic_vector(W-1 downto 0); -- conteggio
        tc: out std_logic -- riporto al prossimo
    );
end counter_mod;

architecture behavioral of counter_mod is
    signal cnt : unsigned(W-1 downto 0);
begin
    assert M<= 2**W 
        report "counter_mod: M non rappresentabile su W bit"
        severity failure;
    
    process(clk)
    begin
        if clk'event and clk = '1' then 
            if rst = '1' then 
                cnt <= (others => '0');
            elsif load = '1' then
                cnt <= unsigned(d);
            elsif en = '1' then 
                if cnt = M-1 then
                    cnt <= (others => '0');
                else 
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;
    
    q <= std_logic_vector(cnt);
    tc <= '1' when en = '1' and cnt = M-1 else '0';
end behavioral;
