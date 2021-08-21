library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity alu is
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
end entity;

architecture behave of alu is 

   signal s_carry: std_logic_vector(Nbits downto 0);
   signal s_b: std_logic_vector(Nbits-1 downto 0);
   signal s_res: std_logic_vector(Nbits-1 downto 0);

begin
   
   -- Full Adders
   s_carry(0) <= i_sub;
   gen_fa: for i in 0 to Nbits-1 generate
      s_b(i) <= i_sub xor i_b(i);
      fa: full_adder port map (i_a(i), s_b(i), s_carry(i), s_res(i), s_carry(i+1));
   end generate;
	
   -- Carry flag
   o_cf <= s_carry(Nbits);
	
   -- Zero flag 
   o_zf <= '1' when s_res = (s_res'range => '0') else '0';
	
   -- ALU result
   o_res <= s_res;
   o_res_bus <= s_res when i_oe = '1' else (others => 'Z');
	
end behave;
