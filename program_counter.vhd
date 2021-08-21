library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is 
   port(
   i_rst: in std_logic;
	i_clk: in std_logic;
	i_ld: in std_logic;
	i_en: in std_logic;
	i_oe: in std_logic;
	i_data: in std_logic_vector(3 downto 0);
	o_data: out std_logic_vector(3 downto 0);
	o_data_bus: out std_logic_vector(3 downto 0));
end entity;

architecture behave of program_counter is 
   
   signal s_count: unsigned(3 downto 0);
	
begin 

   process(i_rst, i_clk)
   begin 
      if (i_rst = '0') then
         s_count <= (others => '0');
      elsif (rising_edge(i_clk)) then
         if (i_ld = '1') then
	         s_count <= unsigned(i_data);
         elsif (i_en = '1') then
	         s_count <= s_count + 1;
         end if;
      end if;
   end process;
	      
   o_data <= std_logic_vector(s_count);
   o_data_bus <= std_logic_vector(s_count) when i_oe = '1' else (others => 'Z');

end behave;
