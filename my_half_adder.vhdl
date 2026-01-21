-- Laboratory GdTi solutions/versuch7
-- Winter Semester 24/25
-- Group Details
-- Lab Date:
-- 1. Participant First and  Last Name: 
-- 2. Participant First and Last Name:
 
 
-- coding conventions
-- g_<name> Generics
-- p_<name> Ports
-- c_<name> Constants
-- s_<name> Signals
-- v_<name> Variables

library ieee;
use ieee.std_logic_1164.all;

entity my_half_adder is
  port (
    -- begin solution:
    P_A         : in  std_logic;
    P_B         : in  std_logic;
    P_SUM       : out std_logic;
    P_CARRY_OUT : out std_logic
    -- end solution!!
  );
end my_half_adder;

	--Notieren Sie ihre Umformungsschritte unter diesem Kommentar:
  
	-- begin solution:
	-- not A = A nand A
	-- SUM = A xor B = (A or B) and not(A and B) = not(not A and not B) and not(A and B)
	-- = not((A nand A) and (B nand B)) and (A nand B) = (A nand A) nand (B nand B) and (A nand B)
	-- XOR with NAND only:
	-- N1 = A nand B
	-- N2 = A nand N1
	-- N3 = B nand N1
	-- SUM = N2 nand N3
	-- CARRY = A and B = not(not(A and B)) = not(A nand B) = (A nand B) nand (A nand B)
	-- end solution!!	

-- dataflow
architecture dataflow of my_half_adder is
  begin
-- begin solution:
  P_SUM       <= (P_A nand (P_A nand P_B)) nand (P_B nand (P_A nand P_B));
  P_CARRY_OUT <= (P_A nand P_B) nand (P_A nand P_B);
-- end solution!!
end dataflow;
