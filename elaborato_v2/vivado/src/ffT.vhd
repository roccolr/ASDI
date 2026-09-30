----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.08.2026 18:49:41
-- Design Name: 
-- Module Name: ffT - Behavioral
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

entity ffT is
  Port ( 
    clk     :   in std_logic;
    reset   :   in std_logic;
    Y       :   out std_logic
  );
end ffT;

architecture rtl of ffT is
    signal TY : std_logic;  -- dobbiamo usarlo perchè Y è di sola scrittura, mentre noi 
                            -- per effettuare il toggle obbiamo leggerlo                          
begin
    ff: process(clk, reset)
        begin 
            if(reset='1') then -- RESET ha priorità! Se è alto non guarda nemmeno il clock 
                TY <= '0';
            elsif(clk'event AND clk='0') then 
                TY <= NOT TY; 
            end if;
        end process;  
    Y<=TY;
end rtl;

