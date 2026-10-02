library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common_defs.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port(
        ctrl : in alu_ctrl_type;
        a : in reg_data_type;
        b : in reg_data_type;
        c: out reg_data_type;
        n: out std_logic; -- negativo
        z: out std_logic -- zero
    );
end alu;

architecture Behavioral of alu is
    signal a_en, a_in, b_in     : unsigned(REG_WIDTH-1 downto 0);
    signal inc                  : unsigned(0 downto 0);
    signal f                    : std_logic_vector(1 downto 0);
    signal res                  : unsigned(REG_WIDTH-1 downto 0); -- uscita ALU
    signal sh                   : unsigned(REG_WIDTH-1 downto 0); -- uscita shifter
    
    
    
begin
    -- abilitazione degli ingressi
    a_en <= unsigned(a) when ctrl(ALU_ENA) = '1' else (others => '0');
    b_in <= unsigned(b) when ctrl(ALU_ENB) = '1' else (others => '0');
    
    -- inversione eventuale di a
    a_in <= not a_en when ctrl(ALU_INVA) = '1' else a_en;
    
    -- operazione
    
    f <= ctrl(ALU_F0) & ctrl(ALU_F1);
    inc(0) <= ctrl(ALU_INC);
    
    with f select
        res <=  a_in and b_in when "00",
                a_in or b_in when "01",
                not b_in when "10",
                a_in + b_in + inc when others;
                
    n <= res(REG_WIDTH-1);
    z <= '1' when res = 0 else '0';
    
    sh <=   res(REG_WIDTH-9 downto 0) & x"00" when ctrl(ALU_SLL8) = '1' 
            else
            res(REG_WIDTH-1) & res(REG_WIDTH-1 downto 1) when ctrl(ALU_SRA1) = '1' else res;
    
    c <= std_logic_vector(sh);
end Behavioral;
