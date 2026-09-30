library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsm_sequence is
    port(
        x: in std_logic;
        mode: in std_logic;
        clk, rst: in std_logic;
        y: out std_logic
    );
end fsm_sequence;

architecture Behavioral of fsm_sequence is
    type state is (S0, S1, S2, S3, S4);
    signal current_state : state; 
    signal next_state : state;
begin
    f_stato_uscita : process(current_state, mode, x)
    begin
        -- default in testa
        next_state <= S0;
        y <= '0';
        case current_state is
            when S0 =>
                if x = '1' then
                    if mode = '0' then 
                        next_state <= S1;
                    else 
                        next_state <= S3;
                    end if;
                end if;
            when S1 =>
                if mode = '0' then
                    if x = '0' then 
                        next_state <= S2;
                    else 
                        next_state <= S1;
                    end if;
                end if; 
            when S2 =>
                if mode = '0' and x = '1' then
                    y <= '1';
                end if;
                
            when S3 =>
                if mode = '1' then
                    if x = '0' then 
                        next_state <= S4;
                    else 
                        next_state <= S3;
                    end if;
                end if; 
            
            when S4 =>
                if mode = '1' and x = '1' then
                    y <= '1';
                    next_state <= S3; 
                end if;           
        end case;        
    end process;
    
    mem: process(clk)
    begin 
        if (clk'event and clk = '1') then
            if (rst = '1') then 
                current_state <= S0;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;
end Behavioral;
