library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cuA is
    port (
        clk_a : in std_logic;
        start : in std_logic;
        tk : in std_logic;
        cts : in std_logic;
        rst : out std_logic;
        rd : out std_logic;
        en : out std_logic;
        rts: out std_logic
    );
end cuA;

architecture Behavioral of cuA is
    type stato is (IDLE, READ, REQ, ACK, FINE);
    signal current_state, next_state : stato;
begin
    f_stato_uscita: process(current_state, start, tk, cts)
    begin
        next_state <= current_state;
        rst <= '0';
        rd <= '0';
        en <= '0';
        rts <= '0';
        case current_state is
            when IDLE =>
                rst <= '1';                     -- contatore a 0
                if start = '1' then
                    next_state <= READ;
                end if;
            when READ =>
                rd <= '1';                      -- il dato e' pronto prima di rts
                next_state <= REQ;
            when REQ =>
                rts <= '1';
                if cts = '1' then
                    next_state <= ACK;
                end if;
            when ACK =>                         -- rts = 0, aspetto che B abbassi cts
                if cts = '0' then
                    en <= '1';
                    if tk = '1' then
                        next_state <= FINE;
                    else
                        next_state <= READ;
                    end if;
                end if;
            when FINE =>
                if start = '0' then
                    next_state <= IDLE;
                end if;
        end case;
    end process;

    mem: process(clk_a)
    begin
        if clk_a'event and clk_a = '1' then
            current_state <= next_state;
        end if;
    end process;
end Behavioral;