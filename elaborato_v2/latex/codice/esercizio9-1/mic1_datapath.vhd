library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.common_defs.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mic1_datapath is
    port(
        clk : in std_logic;
        reset : in std_logic;
        
        -- controllo
        alu_ctrl : in alu_ctrl_type;
        c_ctrl : in c_ctrl_type;
        mem_ctrl : in mem_ctrl_type;
        b_ctrl : in b_ctrl_type;
        
        -- verso la cu 
        mbr_out : out mbr_data_type;
        n_flag: out std_logic;
        z_flag: out std_logic;
        
        -- interfaccia dati
        mem_data_addr : out reg_data_type;
        mem_data_out: out reg_data_type;
        mem_data_in : in reg_data_type;
        mem_data_we: out std_logic;
        
        --interfaccia istruzioni
        mem_instr_addr : out reg_data_type;
        mem_instr_in : in mbr_data_type
    );
end mic1_datapath;

architecture rtl of mic1_datapath is
    -- registri
    signal mar, mdr, pc, sp, lv, cpp, tos, opc, h : reg_data_type;
    signal mbr : mbr_data_type;
    
    signal rd_ff, wr_ff, fetch_ff : std_logic;
    
    -- bus
    signal b_bus, c_bus : reg_data_type;
    
    -- MBR esteso a 32 bit, con e senza segno
    signal mbr_s, mbr_u : reg_data_type;
begin
    -- registri
    
    reg_proc : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                mar <= (others => '0');
                mdr <= (others => '0');
                pc  <= (others => '0');
                sp  <= x"00000101";
                lv  <= x"00000100";
                cpp <= x"00000080";
                tos <= (others => '0');
                opc <= (others => '0');
                h   <= (others => '0');
                mbr <= (others => '0');
                rd_ff    <= '0';
                wr_ff    <= '0';
                fetch_ff <= '0';
            else
                -- scritture dal bus C: ogni registro ha il suo enable
                if c_ctrl(C_MAR) = '1' then mar <= c_bus; end if;
                if c_ctrl(C_PC)  = '1' then pc  <= c_bus; end if;
                if c_ctrl(C_SP)  = '1' then sp  <= c_bus; end if;
                if c_ctrl(C_LV)  = '1' then lv  <= c_bus; end if;
                if c_ctrl(C_CPP) = '1' then cpp <= c_bus; end if;
                if c_ctrl(C_TOS) = '1' then tos <= c_bus; end if;
                if c_ctrl(C_OPC) = '1' then opc <= c_bus; end if;
                if c_ctrl(C_H)   = '1' then h   <= c_bus; end if;

                -- MDR: dal bus C oppure dalla memoria
                if c_ctrl(C_MDR) = '1' then
                    mdr <= c_bus;
                elsif rd_ff = '1' then
                    mdr <= mem_data_in;
                end if;

                -- MBR: solo dalla memoria istruzioni
                if fetch_ff = '1' then
                    mbr <= mem_instr_in;
                end if;

                -- le richieste di questo ciclo agiscono nel prossimo
                rd_ff    <= mem_ctrl(MEM_READ);
                wr_ff    <= mem_ctrl(MEM_WRITE);
                fetch_ff <= mem_ctrl(MEM_FETCH);
            end if;
        end if;
    end process;

    -- bus B
    mbr_s <= std_logic_vector(resize(signed(mbr), REG_WIDTH));
    mbr_u <= std_logic_vector(resize(unsigned(mbr), REG_WIDTH));

    with b_ctrl select
        b_bus <= mdr   when B_MDR,
                 pc    when B_PC,
                 mbr_s when B_MBR,
                 mbr_u when B_MBRU,
                 sp    when B_SP,
                 lv    when B_LV,
                 cpp   when B_CPP,
                 tos   when B_TOS,
                 opc   when B_OPC,
                 (others => '0') when others;
    
    mem_data_addr  <= mar;
    mem_data_out   <= mdr;
    mem_data_we    <= wr_ff;
    mem_instr_addr <= pc;
    mbr_out        <= mbr;

end rtl;
