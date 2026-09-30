----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.09.2026 18:41:53
-- Design Name: 
-- Module Name: rca_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rca_tb is
end rca_tb;

architecture bench of rca_tb is
    signal a, b: std_logic_vector(7 downto 0);
    signal c_in: std_logic:= '0';
    signal s: std_logic_vector(7 downto 0);
    signal c_out: std_logic;
    
    signal errors : natural := 0;
begin
    dut : entity work.rca(structural)
        port map (
            a => a, b => b, c_in => c_in,
            s => s, c_out => c_out
        );

    stim : process

        -- verifica un singolo caso: applica gli ingressi, aspetta, confronta
        procedure check (va, vb : integer; vcin : std_logic) is
            variable expected : integer;
            variable got      : integer;
        begin
            a    <= std_logic_vector(to_unsigned(va, 8));
            b    <= std_logic_vector(to_unsigned(vb, 8));
            c_in <= vcin;
            wait for 10 ns;

            -- golden model: somma calcolata per via aritmetica indipendente
            expected := va + vb;
            if vcin = '1' then
                expected := expected + 1;
            end if;

            -- risultato del DUT ricomposto in intero: c_out e' il bit 8
            got := to_integer(unsigned(s));
            if c_out = '1' then
                got := got + 256;
            end if;

            assert got = expected
                report "MISMATCH: " & integer'image(va) & " + " & integer'image(vb) &
                       " + cin=" & std_logic'image(vcin) &
                       "  atteso " & integer'image(expected) &
                       "  ottenuto " & integer'image(got)
                severity error;

            if got /= expected then
                errors <= errors + 1;
            end if;
        end procedure;

    begin

        -- qui andranno le chiamate a check(...)

        wait;
    end process;

end bench;
