library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_sequence is
    port(
        i: in std_logic;
        m: in std_logic;
        a: in std_logic; -- tempificazione
        rst: in std_logic;
        en : in std_logic;
        y: out std_logic
    );
end fsm_sequence;

architecture Behavioral of fsm_sequence is
    type state is (S0, S1, S2, G1, G1E, G2, G2E);
    
    -- m = 1
    -- SO -> Inizio
    -- S1 -> visto 1
    -- S2 -> visto 10
    
    -- m = 0
    -- S0 -> Inizio gruppo
    -- G1 -> letto 1
    -- G1E -> bit sbagliato
    -- G2 -> letto 10 
    -- G2EE -> gruppo perso
    
    signal current_state, next_state : state; 
    
begin
    f_stato_uscita : process(current_state, m, i)
    begin
        -- default in testa (archi omessi)
        y <= '0';
        
        if M = '1' then
            if i = '1' then next_state <= S1;
            else next_state <= S0;
            end if;
        else 
            if i = '1' then next_state <= G1;
            else next_state <= G1E;
            end if;
        end if;
        
        case current_state is
            when S0 => null;
            
            when S1 =>
                if m = '1' and i = '0' then
                    next_state <= S2;
                end if;
                
            when S2 =>
                if m = '1' and i = '1' then
                    y <= '1';
                    next_state <= S0;
                end if;
                
            when G1 =>
                if m = '0' then
                    if i = '0' then next_state <= G2; else next_state <= G2E;
                    end if;
                end if;
                
            when G1E =>
                if m = '0' then
                    next_state <= G2E; 
                end if;  
                
            when G2 =>
                if m = '0' then
                    next_state <= S0;
                    if i = '1' then y <= '1'; end if;
                end if;  
                
            when G2E =>
                if m = '0' then
                    next_state <= S0;
                end if;        
        end case;        
    end process;
    
    mem: process(a)
    begin 
        if (a'event and a = '1') then
            if (rst = '1') then 
                current_state <= S0;
            elsif en = '1' then
                current_state <= next_state;
            end if;
        end if;
    end process;
end Behavioral;
