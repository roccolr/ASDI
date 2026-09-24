----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.08.2026 19:58:10
-- Design Name: 
-- Module Name: mux_2_1_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2_1_tb is
--  Port ( );
end mux_2_1_tb;

architecture bench of mux_2_1_tb is
signal input    :   std_logic_vector(0 to 1) := (others => 'U');
signal control  :   std_logic := 'U';
signal output   :   std_logic := 'U';
begin
    utt : entity work.mux_2_1(alternative)
        port map (
            a0 => input(0),
            a1 => input(1),
            s => control,
            y => output
        );
        
        
    stim_proc : process
    begin 
        wait for 10 ns;
        input <= "01";
        wait for 10 ns;
        control <= '1';
        wait for 5 ns;
        input <= "00";
        wait for 5 ns;
        input <= "10";
        wait for 5 ns;
        control <= '0';
        assert output = '0'
            report "errore0"
            severity failure;
        wait;
    end process; 
end bench;
