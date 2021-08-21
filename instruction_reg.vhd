library ieee;
use ieee.std_logic_1164.all;

entity instruction_reg is 
   port(
   i_rst: in std_logic;
	i_clk: in std_logic;
	i_en: in std_logic;
	i_oe: in std_logic;
   i_data: in std_logic_vector(7 downto 0);
   o_instruction: out std_logic_vector(3 downto 0);
	o_data_bus: out std_logic_vector(7 downto 0));
end entity;

architecture behave of instruction_reg is 

   signal r_data: std_logic_vector(7 downto 0);

begin

   process(i_clk, i_rst)
   begin
      if (i_rst = '0') then
         r_data <= (others => '0');
      elsif (rising_edge(i_clk)) then
         if (i_en = '1') then
	    r_data <= i_data;
         end if;
      end if;
   end process;
	      
   o_instruction <= r_data(7 downto 4);
   o_data_bus <= ("0000" & r_data(3 downto 0)) when i_oe = '1' else (others => 'Z');

end behave;
