library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cu_B is
    port  (
        clk : in std_logic;
        reset: in std_logic;
        start: in std_logic;
        
        req: in std_logic;
        ack: out std_logic;
        
        count_en: out std_logic;
        mem_read: out std_logic;
        mem_write: out std_logic;
        reg_read: out std_logic
    );
end cu_B;

architecture Behavioral of cu_B is
    type state is (WAIT_TX, ACK_TX, WAIT_END_REQ, END_TX);
    signal current_state, next_state : state := WAIT_TX;
begin
    
    f_ctrl: process(req, current_state)
    begin
        next_state <= current_state;
        count_en <= '0';
        mem_read <= '0';
        mem_write <= '0';
        reg_read <= '0';
        
        case current_state is 
            when WAIT_TX =>
                if req = '1' then
                    next_state <= ACK_TX;
                end if;
            
            when ACK_TX =>
                -- ack <= '1';
                reg_read <= '1';
                mem_read <= '1';
                next_state <= WAIT_END_REQ;
            
            when WAIT_END_REQ =>
                if req = '0' then
                    next_state <= END_TX;
                end if;
           
            when END_TX =>
                mem_write <= '1';
                count_en <= '1';
                next_state <= WAIT_TX;
            
            end case;
        end process;   
        
    mem_proc: process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                current_state <= WAIT_TX;
                ack <= '0';
            else 
                current_state <= next_state;
                if next_state = ACK_TX then
                    ack <= '1';
                elsif next_state = END_TX then
                    ack <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
