library ieee;
use ieee.std_logic_1164.all;

entity program_counter_tb is 
end entity;

architecture test of program_counter_tb is
   
   signal rst: std_logic;
   signal clk: std_logic;
   signal ld: std_logic;
   signal en: std_logic;
   signal oe: std_logic;
   signal input: std_logic_vector(3 downto 0) := "1100";
   signal output: std_logic_vector(3 downto 0);
   signal output_bus: std_logic_vector(3 downto 0);
	
   constant t: time := 20 ns;
	
begin

   dut: entity work.program_counter port map (rst, clk, ld, en, oe, input, output, output_bus);
	
   -- Clock signal
   process
   begin
      clk <= '0';
      wait for t/2;
      clk <= '1';
      wait for t/2;
   end process;

   -- Control signals
   process
   begin
      rst <= '0';
      ld <= '0';
      en <= '0';
      oe <= '0';
      wait for t;
      rst <= '1';
      wait for t*3;
      oe <= '1';
      wait for t*3;
      en <= '1';
      wait for t*4;
      en <= '0';
      wait for t*3;
      ld <= '1';
      wait for t;
      ld <= '0';
      wait for t;
      en <= '1';
      wait;
   end process;
	
end test;
