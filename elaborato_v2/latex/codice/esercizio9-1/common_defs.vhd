library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package common_defs is

    ---------------------------------------------------------------- larghezze
    constant REG_WIDTH : positive := 32;
    constant MBR_WIDTH : positive := 8;

    subtype reg_data_type is std_logic_vector(REG_WIDTH-1 downto 0);
    subtype mbr_data_type is std_logic_vector(MBR_WIDTH-1 downto 0);

    ---------------------------------------------------------------- campo ALU
    -- SLL8 SRA1 F0 F1 ENA ENB INVA INC
    subtype alu_ctrl_type is std_logic_vector(7 downto 0);
    constant ALU_SLL8 : natural := 7;
    constant ALU_SRA1 : natural := 6;
    constant ALU_F0   : natural := 5;
    constant ALU_F1   : natural := 4;
    constant ALU_ENA  : natural := 3;
    constant ALU_ENB  : natural := 2;
    constant ALU_INVA : natural := 1;
    constant ALU_INC  : natural := 0;

    ---------------------------------------------------------------- campo C
    -- H OPC TOS CPP LV SP PC MDR MAR
    subtype c_ctrl_type is std_logic_vector(8 downto 0);
    constant C_H   : natural := 8;
    constant C_OPC : natural := 7;
    constant C_TOS : natural := 6;
    constant C_CPP : natural := 5;
    constant C_LV  : natural := 4;
    constant C_SP  : natural := 3;
    constant C_PC  : natural := 2;
    constant C_MDR : natural := 1;
    constant C_MAR : natural := 0;

    ---------------------------------------------------------------- campo Mem
    -- WRITE READ FETCH
    subtype mem_ctrl_type is std_logic_vector(2 downto 0);
    constant MEM_WRITE : natural := 2;
    constant MEM_READ  : natural := 1;
    constant MEM_FETCH : natural := 0;

    ---------------------------------------------------------------- campo B
    subtype b_ctrl_type is std_logic_vector(3 downto 0);
    constant B_MDR  : b_ctrl_type := "0000";
    constant B_PC   : b_ctrl_type := "0001";
    constant B_MBR  : b_ctrl_type := "0010";
    constant B_MBRU : b_ctrl_type := "0011";
    constant B_SP   : b_ctrl_type := "0100";
    constant B_LV   : b_ctrl_type := "0101";
    constant B_CPP  : b_ctrl_type := "0110";
    constant B_TOS  : b_ctrl_type := "0111";
    constant B_OPC  : b_ctrl_type := "1000";

        ---------------------------------------------------------------- control store
    subtype mpc_type is std_logic_vector(8 downto 0);     -- 512 parole
    subtype mir_type is std_logic_vector(35 downto 0);    -- 36 bit
end package common_defs;