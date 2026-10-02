library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem is
    generic (
        N : positive := 16; -- locazioni
        A : positive := 4;  -- indirizzamento
        W : positive := 4   -- larghezza
    );
    port (
        clk : in std_logic;
        we : in std_logic; -- write enable
        waddr : in std_logic_vector(A-1 downto 0);
        din : std_logic_vector(W-1 downto 0);
        
        -- utilita' testbench
        raddr : in std_logic_vector(A-1 downto 0);
        dout: out std_logic_vector(W-1 downto 0)
    );
end mem;
    
architecture behavioral of mem is
    type mem_t is array (0 to N-1) of std_logic_vector(W-1 downto 0);
    signal ram : mem_t := (others => (others => '1'));
    
begin
    assert N <= 2**A
        report "mem: N non indirizzabile su A bit"
        severity failure;
   
    process (clk)
    begin 
        if clk'event and clk = '1' then
            if we = '1' then
                ram(to_integer(unsigned(waddr))) <= din;
            end if;
        end if;
    end process;
    
    dout <= ram(to_integer(unsigned(raddr))); -- lettura asincrona
end behavioral;
