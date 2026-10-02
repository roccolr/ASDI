library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.common_defs.all;

entity control_store is
    port (
        addr : in  mpc_type;
        word : out mir_type
    );
end control_store;

architecture rom of control_store is

    type cs_array is array (0 to 511) of mir_type;

    --                              Addr          JAM     ALU          C              Mem     B
    constant NOP : mir_type :=   "000000000" & "000" & "00000000" & "000000000" & "000" & "1111";

    constant CS : cs_array := (
        -- avvio
        16#100# => "100000001" & "000" & "00010100" & "000000001" & "011" & "0100",  -- MAR = SP; rd; fetch
        16#101# => "100000010" & "000" & "00000000" & "000000000" & "000" & "1111",  -- attesa della memoria
        16#102# => "100000011" & "000" & "00010100" & "001000000" & "000" & "0000",  -- TOS = MDR
        -- main
        16#103# => "000000000" & "100" & "00110101" & "000000100" & "001" & "0001",  -- PC = PC + 1; fetch; goto (MBR)
        -- iadd = 0x65
        16#065# => "001100110" & "000" & "00110110" & "000001001" & "010" & "0100",  -- MAR = SP = SP - 1; rd
        16#066# => "001100111" & "000" & "00010100" & "100000000" & "000" & "0111",  -- H = TOS
        16#067# => "100000011" & "000" & "00111100" & "001000010" & "100" & "0000",  -- MDR = TOS = MDR + H; wr; goto main
        -- halt = 0xFF
        16#0FF# => "011111111" & "000" & "00000000" & "000000000" & "000" & "1111",  -- goto halt
        others  => NOP
    );

begin

    word <= CS(to_integer(unsigned(addr)));

end rom;