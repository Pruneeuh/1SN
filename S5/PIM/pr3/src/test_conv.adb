with module_decompresser;  use module_decompresser;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


procedure test_conv is 
   Octet : T_Octet:= 146; 
   Suite_Bits : Unbounded_String; 
begin 
   Convertir_octet_bits(Octet,Suite_Bits); 
   Put(To_String(Suite_Bits)); 
end test_conv;

