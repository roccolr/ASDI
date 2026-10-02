library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cuB is
    port (
        clk_b : in std_logic;
        rts : in std_logic;
        cts : out std_logic;
        load : out std_logic
    );
end cuB;

architecture Behavioral of cuB is
    type stato is (LISTEN, ACK);
    signal current_state, next_state: stato;
begin
    f_stato_uscita: process(current_state, rts)
    begin
        next_state <= current_state;
        cts <= '0';
        load <= '0';
        case current_state is
            when LISTEN =>
                if rts = '1' then
                    load <= '1';                -- il dato e' gia' stabile
                    next_state <= ACK;
                end if;
            when ACK =>
                cts <= '1';
                if rts = '0' then
                    next_state <= LISTEN;
                end if;
        end case;
    end process;

    mem: process (clk_b)
    begin
        if clk_b'event and clk_b = '1' then
            current_state <= next_state;
        end if;
    end process;
end Behavioral;