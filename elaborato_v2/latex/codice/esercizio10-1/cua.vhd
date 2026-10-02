library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cuA is
    port(
        clk: in std_logic;
        rst: in std_logic;
        start: in std_logic;
        -- contatore
        en: out std_logic;

        
        -- UART
        cts: in std_logic;
        wr: out std_logic;
        rts: out std_logic
    );
end cuA;

architecture Behavioral of cuA is
    type stato is (IDLE,FIRE, RELOAD);
    signal current_state, next_state : stato;
begin
    
    f_stato_uscita: process(start, current_state, cts)
    begin
        rts <= '0';
        en <= '0';
        wr <= '0';
        next_state <= current_state;
        
        case current_state is 
            when IDLE =>
                if start = '1' then
                    next_state <= FIRE;
                    rts <= '1';
                end if;
            
            when FIRE =>
                rts <= '1';
                if cts = '1' then
                    wr <= '1';
                    next_state <= RELOAD;
                end if;
            
            when RELOAD =>
                if cts = '0' then
                    next_state <= IDLE;
                    en <= '1';
                end if;
        end case;
    end process;
    
    mem: process(clk)
    begin 
        if clk'event and clk = '1' then
            if rst = '1' then
                current_state <= IDLE;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;
end Behavioral;
