library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity cpu is
   port(
   i_rst: in std_logic;
   i_clk: in std_logic);
end entity;

architecture behave of cpu is

   signal s_data: std_logic_vector(7 downto 0);
   signal s_bus: std_logic_vector(7 downto 0);
   signal s_alu: std_logic_vector(7 downto 0);
   signal r_regA: std_logic_vector(7 downto 0);
   signal r_regB: std_logic_vector(7 downto 0);
   signal s_pc: std_logic_vector(3 downto 0);
   signal s_step_counter: std_logic_vector(2 downto 0);
   signal r_mem_addr: std_logic_vector(3 downto 0);
   signal s_instruction: std_logic_vector(3 downto 0);
   signal s_clk: std_logic;
   signal s_clk_div: std_logic;
   signal s_zf: std_logic;
   signal s_cf: std_logic;
   signal r_zf: std_logic;
   signal r_cf: std_logic;
	
   -- Control signals
   signal s_control: std_logic_vector(15 downto 0);
   signal s_hlt: std_logic;
   signal s_mi: std_logic;
   signal s_ri: std_logic;
   signal s_ro: std_logic;
   signal s_ii: std_logic;
   signal s_io: std_logic;
   signal s_ai: std_logic;
   signal s_ao: std_logic;
   signal s_bi: std_logic;
   signal s_eo: std_logic;
   signal s_su: std_logic;
   signal s_oi: std_logic;
   signal s_ce: std_logic;
   signal s_co: std_logic;
   signal s_jp: std_logic;
   signal s_fi: std_logic;
	
begin 
   
   -- Clock logic
   s_clk <= (not s_hlt) and i_clk;

   -- Reg A
   RegA: reg generic map (8) port map (i_rst, s_clk, s_ai, s_ao, s_bus, r_regA, s_bus);
   -- Reg B
   RegB: reg generic map (8) port map (i_rst, s_clk, s_bi, '0', s_bus, r_regB, open);
   -- Instruction Reg
   RegI: instruction_reg port map (i_rst, s_clk, s_ii, s_io, s_bus, s_instruction, s_bus);
   -- Output Reg
   RegO: reg generic map (8) port map (i_rst, s_clk, s_oi, '0', s_bus, s_data, open);
   -- Memory Addr Reg
   RegM: reg generic map (4) port map (i_rst, s_clk, s_mi, '0', s_bus(3 downto 0), r_mem_addr, open);
   -- Flags Reg 
   process(i_rst, s_clk)
   begin
      if (i_rst = '0') then
         r_cf <= '0';
         r_zf <= '0';
      elsif (rising_edge(s_clk)) then
         if (s_fi = '1') then
	         r_cf <= s_cf;
	         r_zf <= s_zf;
	      end if;
      end if;
   end process;
	
   -- ALU
   alu_circuit: alu port map (r_regA, r_regB, s_su, s_eo, s_alu, s_bus, s_cf, s_zf);
	
   -- Program Counter
   pc: program_counter port map (i_rst, s_clk, s_jp, s_ce, s_co, s_bus(3 downto 0), s_pc, s_bus(3 downto 0));
	
   -- RAM
   memory: ram port map (s_clk, r_mem_addr, s_bus, s_ri, s_ro, s_bus);
	
   -- Control
   control_circuit: control port map (i_rst, s_clk, r_cf, r_zf, s_instruction, s_step_counter, s_control);
   s_hlt <= s_control(15);
   s_mi <= s_control(14);
   s_ri <= s_control(13);
   s_ro <= s_control(12);
   s_ii <= s_control(11);
   s_io <= s_control(10);
   s_ai <= s_control(9);
   s_ao <= s_control(8);
   s_bi <= s_control(7);
   s_eo <= s_control(6);
   s_su <= s_control(5);
   s_oi <= s_control(4);
   s_ce <= s_control(3);
   s_co <= s_control(2);
   s_jp <= s_control(1);
   s_fi <= s_control(0);
	
end behave;
