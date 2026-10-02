library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acq_reg is
    port (
        clk     : in  std_logic;
        load_lo : in  std_logic;                     -- carica la prima meta'
        load_hi : in  std_logic;                     -- carica la seconda meta'
        d       : in  std_logic_vector(0 to 7);      -- mezzo dato, dagli switch
        q       : out std_logic_vector(0 to 15)      -- dato completo, verso la rete
    );
end acq_reg;

architecture behavioral of acq_reg is
    signal r : std_logic_vector(0 to 15) := (others => '0');
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if load_lo = '1' then
                r(0 to 7) <= d;
            end if;
            if load_hi = '1' then
                r(8 to 15) <= d;
            end if;
        end if;
    end process;

    q <= r;

end behavioral;