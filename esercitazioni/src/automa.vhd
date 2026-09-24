----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.08.2026 18:16:05
-- Design Name: 
-- Module Name: automa - Behavioral
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

entity automa is
--  Port ( );
    port (
    i   :   in  std_logic;
    CLK :   in  std_logic;
    Y   :   out std_logic
    );
end automa;

architecture Behavioral of automa is
    type stato is (S0, S1, S2); 
    signal stato_corrente   :   stato   := S0;
    signal stato_prossimo   :   stato;
begin

    f_stato_uscita : process (stato_corrente, i) -- sensitivity list 
    begin
        case stato_corrente is

            when S0 =>
                if i = '0' then
                    stato_prossimo <= S0;
                    Y <= '0';
                else
                    stato_prossimo <= S1;
                    Y <= '0';
                end if;

            when S1 =>
                if i = '0' then
                    stato_prossimo <= S2;
                    Y <= '0';
                else
                    stato_prossimo <= S1;
                    Y <= '0';
                end if;

            when S2 =>
                if i = '0' then
                    stato_prossimo <= S0;
                    Y <= '0';
                else
                    stato_prossimo <= S0;
                    Y <= '1';
                end if;

            when others =>
                stato_prossimo <= S0;
                Y <= '0';

        end case;
    end process;
    
    mem : process (CLK)
    begin
        if rising_edge(CLK) then
            stato_corrente <= stato_prossimo;
        end if;
    end process;
    
end Behavioral;
