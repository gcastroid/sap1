library ieee;
use ieee.std_logic_1164.all;

package components is 

component full_adder is 
   port(
	i_a: in std_logic;
	i_b: in std_logic;
   i_c: in std_logic;
   o_s: out std_logic;
   o_c: out std_logic);
end component;

component alu is 
   generic (Nbits: integer := 8);
   port(
	i_a: in std_logic_vector(Nbits-1 downto 0);
	i_b: in std_logic_vector(Nbits-1 downto 0);
	i_sub: in std_logic;
	i_oe: in std_logic;
   o_res: out std_logic_vector(Nbits-1 downto 0);
	o_res_bus: out std_logic_vector(Nbits-1 downto 0);
	o_cf: out std_logic;
	o_zf: out std_logic);
end component;

component control is 
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_cf: in std_logic;
	i_zf: in std_logic;
	i_instruction: in std_logic_vector(3 downto 0);
	o_step_counter: out std_logic_vector(2 downto 0);
	o_control: out std_logic_vector(15 downto 0));
end component;

component instruction_reg is 
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_en: in std_logic;
   i_oe: in std_logic;
   i_data: in std_logic_vector(7 downto 0);
   o_instruction: out std_logic_vector(3 downto 0);
	o_data_bus: out std_logic_vector(7 downto 0));
end component;

component program_counter is 
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_ld: in std_logic;
	i_en: in std_logic;
	i_oe: in std_logic;
	i_data: in std_logic_vector(3 downto 0);
	o_data: out std_logic_vector(3 downto 0);
	o_data_bus: out std_logic_vector(3 downto 0));
end component;

component ram is
   port(
	i_clk: in std_logic;
	i_addr: in std_logic_vector(3 downto 0);
	i_data: in std_logic_vector(7 downto 0);
   i_we: in std_logic;
   i_oe: in std_logic;
   o_data: out std_logic_vector(7 downto 0));
end component;

component reg is 
   generic(Nbits: integer);
   port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_en: in std_logic;
	i_oe: in std_logic;
	i_data: in std_logic_vector(Nbits-1 downto 0);
   o_data: out std_logic_vector(Nbits-1 downto 0);
	o_data_bus: out std_logic_vector(Nbits-1 downto 0));
end component;

--------------------------------------------------------------------
-- Decoders
--------------------------------------------------------------------

component seven_seg_anode is 
   port(
	i_binary: in std_logic_vector(3 downto 0);
	o_display: out std_logic_vector(7 downto 0));
end component;

component seven_seg_cathode is 
   port(
	i_binary: in std_logic_vector(3 downto 0);
	o_display: out std_logic_vector(7 downto 0));
end component;

--------------------------------------------------------------------
-- Clock Divider
--------------------------------------------------------------------

component clk_div is
	port(
	i_rst: in std_logic;
	i_clk: in std_logic;
	i_hlt: in std_logic;
	o_clk: out std_logic);
end component;

end components;
