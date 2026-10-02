library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_manager is
    port(
        clk : in std_logic;
        input : in std_logic_vector(1 downto 0);
        change_m : in std_logic;
        load_next : in std_logic;
        
        detect_input : out std_logic;
        detect_m : out std_logic;
        detect_en : out std_logic -- step
    );
end input_manager;

architecture Behavioral of input_manager is

begin
    input_manager: process(clk)
    begin 
        if clk'event and clk='1' then
            detect_en <= '0';
            if load_next = '1' then 
                detect_input <= input(0);
                detect_en <= '1';
            end if;
            if change_m = '1' then
                detect_m <= input(1);
            end if;
        end if;
    end process;
end Behavioral;
