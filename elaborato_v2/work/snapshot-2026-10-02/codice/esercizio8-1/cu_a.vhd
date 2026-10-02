library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_A is
    port (
        clk: in std_logic;
        reset: in std_logic;
        start: in std_logic;
        
        ack: in std_logic;
        req : out std_logic;
        
        counter_q : in std_logic;
        count_en : out std_logic;
        count_rst: out std_logic;
        
        rom_read : out std_logic
    );
end cu_A;

architecture behavioral of cu_A is
    type state is (IDLE, DATA_READ, WAIT_ACK, START_TX, END_TX, CHECK_COUNT);
    signal current_state, next_state : state := IDLE;
    
begin
    f_ctrl: process(current_state, start, ack, counter_q)
    begin
        next_state <= current_state;
        -- req <= '0'; 
        count_en <= '0';
        count_rst <= '0';
        rom_read <= '0';

    case current_state is 
    
        when IDLE =>
            count_rst <= '1';
            if start = '1' then
                next_state <= DATA_READ;
            end if;
        
        when DATA_READ => 
            next_state <= START_TX;
            -- count_rst <= '0'; è gia default
            rom_read <= '1';
        
        when START_TX =>
            next_state <= WAIT_ACK;
            -- rom_read <= '0'; gia default
        
        when WAIT_ACK =>
            -- req <= '1';
            -- count_en <= '0'; gia default
            if ack = '1' then 
                next_state <= END_TX;
            end if;
        
        when END_TX =>
            -- req <= '0';
            if ack = '0' then
                next_state <= CHECK_COUNT;
            end if;
        
        when CHECK_COUNT => 
            count_en <= '1';
            if counter_q = '1' then
                next_state <= IDLE;
            else 
                next_state <= DATA_READ;
            end if;
        end case;
    end process;
    
    mem_proc: process(clk)
    begin
        if clk'event and clk = '1' then
            if reset = '1' then
                current_state <= IDLE;
                req <= '0';
            else 
                current_state <= next_state;
                if next_state = WAIT_ACK then
                    req <= '1';
                else 
                    req <= '0';
                end if; -- il sistema potrebbe valutare cfg intermedie sullo stato
            end if;
        end if;
    end process;
end Behavioral;
