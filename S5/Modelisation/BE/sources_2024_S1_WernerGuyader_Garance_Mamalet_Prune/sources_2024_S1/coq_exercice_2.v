Require Import Naturelle.
Section Session1_2024_Logique_Exercice_2.

Variable A B C : Prop.


Theorem Exercice_2_Naturelle : ((A /\ B) -> C) -> ((A -> C) \/ (~B)).
Proof. 
I_imp H.
I_ou_d.
I_non H1.
I_antiT(B).
Hyp H1.
E_ou(B)(~B).
TE.
I_imp H2.

Qed.


Theorem Exercice_2_Coq : ((A /\ B) -> C) -> ((A -> C) \/ (~B)).
Proof.
intro.
left.
intro.
absurd C.
unfold not.
intro.
absurd B.
elim H1.


Qed.



End Session1_2024_Logique_Exercice_2.

